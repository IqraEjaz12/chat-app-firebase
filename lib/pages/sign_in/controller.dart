import 'package:firebase_chat/common/entities/user.dart';
import 'package:firebase_chat/common/store/user.dart';
import 'package:firebase_chat/common/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SiginInController extends GetxController {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Email/Password form controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Form validation
  final RxBool isEmailValid = false.obs;
  final RxBool isPasswordValid = false.obs;
  final RxBool showPassword = false.obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    print('SiginInController initialized');

    // Add listeners for real-time validation
    emailController.addListener(_validateEmail);
    passwordController.addListener(_validatePassword);
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void _validateEmail() {
    final email = emailController.text.trim();
    isEmailValid.value = duIsEmail(email);
  }

  void _validatePassword() {
    final password = passwordController.text;
    isPasswordValid.value = duCheckStringLength(password, 6);
  }

  void togglePasswordVisibility() {
    showPassword.value = !showPassword.value;
  }

  // Email/Password Sign In
  Future<void> handleEmailSignIn() async {
    if (!isEmailValid.value || !isPasswordValid.value) {
      Get.snackbar(
        'Validation Error',
        'Please enter valid email and password',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;

      final email = emailController.text.trim();
      final password = passwordController.text;

      // Sign in with email and password
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        await _handleSuccessfulAuth(userCredential.user!);
        Get.snackbar('Success', 'Signed in successfully!');
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = _getAuthErrorMessage(e.code);
      Get.snackbar(
        'Sign In Failed',
        errorMessage,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'An unexpected error occurred: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Email/Password Sign Up
  Future<void> handleEmailSignUp() async {
    if (!isEmailValid.value || !isPasswordValid.value) {
      Get.snackbar(
        'Validation Error',
        'Please enter valid email and password',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;

      final email = emailController.text.trim();
      final password = passwordController.text;

      // Create user with email and password
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        // Send email verification
        await userCredential.user!.sendEmailVerification();

        await _handleSuccessfulAuth(userCredential.user!);

        Get.snackbar(
          'Success',
          'Account created successfully! Please verify your email.',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = _getAuthErrorMessage(e.code);
      Get.snackbar(
        'Sign Up Failed',
        errorMessage,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'An unexpected error occurred: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Forgot Password
  Future<void> handleForgotPassword() async {
    final email = emailController.text.trim();

    if (!duIsEmail(email)) {
      Get.snackbar(
        'Invalid Email',
        'Please enter a valid email address',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      await _auth.sendPasswordResetEmail(email: email);
      Get.snackbar(
        'Email Sent',
        'Password reset email sent to $email',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage = _getAuthErrorMessage(e.code);
      Get.snackbar(
        'Error',
        errorMessage,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Handle successful authentication (common for both email and Google)
  Future<void> _handleSuccessfulAuth(User user) async {
    try {
      // Create user profile for UserStore
      final profile = UserLoginResponseEntity(
        accessToken: await user.getIdToken(),
        displayName: user.displayName ?? user.email?.split('@')[0] ?? 'User',
        email: user.email,
        photoUrl: user.photoURL,
      );

      // Save to UserStore
      await UserStore.to.saveProfile(profile);

      // Create/Update user document in Firestore
      await _createOrUpdateUserInFirestore(user);

      // Navigate to main app (uncomment when ready)
      // Get.offAllNamed('/application');
    } catch (e) {
      print('Error handling successful auth: $e');
    }
  }

  // Create or update user in Firestore
  Future<void> _createOrUpdateUserInFirestore(User user) async {
    try {
      final userRef = _firestore.collection('users').doc(user.uid);
      final userData = {
        'id': user.uid,
        'name': user.displayName ?? user.email?.split('@')[0] ?? 'User',
        'email': user.email,
        'photourl': user.photoURL ?? '',
        'addtime': Timestamp.now(),
        'fcmtoken': '', // Can be updated later with FCM token
      };

      await userRef.set(userData, SetOptions(merge: true));
    } catch (e) {
      print('Error creating/updating user in Firestore: $e');
    }
  }

  // Get user-friendly error messages
  String _getAuthErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'user-not-found':
        return 'No user found with this email address.';
      case 'wrong-password':
        return 'Wrong password provided.';
      case 'email-already-in-use':
        return 'An account already exists with this email.';
      case 'weak-password':
        return 'The password is too weak.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'too-many-requests':
        return 'Too many requests. Please try again later.';
      case 'operation-not-allowed':
        return 'Email/password accounts are not enabled.';
      default:
        return 'An error occurred. Please try again.';
    }
  }

  Future<void> handleGoogleSignIn() async {
    print('Google Sign-In button pressed!'); // Debug log

    try {
      // Show loading
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      print('Starting Google Sign-In process...');

      // Sign out first to ensure clean state
      await _googleSignIn.signOut();
      await _auth.signOut();

      print('Cleared previous sign-in state');

      // Start Google Sign-In
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      print('Google Sign-In result: $googleUser');

      if (googleUser == null) {
        // User canceled the sign-in
        print('User canceled Google Sign-In');
        Get.back(); // Close loading dialog
        return;
      }

      print('Getting Google authentication...');

      // Get Google Sign-In authentication
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      print('Creating Firebase credential...');

      // Create Firebase credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      print('Signing in to Firebase...');

      // Sign in to Firebase
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      // Close loading dialog
      Get.back();

      print('Firebase sign-in successful: ${userCredential.user?.email}');

      if (userCredential.user != null) {
        // Success - navigate to main app
        await _handleSuccessfulAuth(userCredential.user!);
        Get.snackbar('Success', 'Signed in successfully!');
        // Navigate to your main app page
        // Get.offAllNamed('/main');
      }
    } catch (e) {
      // Close loading dialog
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }

      print('Google Sign-In Error: $e');
      Get.snackbar(
        'Error',
        'Sign-in failed: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Navigate to Sign-Up page
  void handleCreateAccount() {
    print('Navigate to Create Account');
    Get.toNamed('/sign_up');
  }

  // Handle forgot password (show dialog with email input)
  void handleForgotPasswordDialog() {
    final TextEditingController forgotEmailController = TextEditingController();

    Get.dialog(
      AlertDialog(
        title: const Text('Reset Password'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
                'Enter your email address to receive a password reset link.'),
            const SizedBox(height: 16),
            TextField(
              controller: forgotEmailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email Address',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final email = forgotEmailController.text.trim();
              Get.back(); // Close dialog first

              if (email.isNotEmpty) {
                // Set the email in the main controller and call forgot password
                emailController.text = email;
                await handleForgotPassword();
              }
            },
            child: const Text('Send Reset Email'),
          ),
        ],
      ),
    );
  }
}
