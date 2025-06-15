import 'package:firebase_chat/common/entities/user.dart';
import 'package:firebase_chat/common/store/user.dart';
import 'package:firebase_chat/common/utils/utils.dart';
import 'package:firebase_chat/pages/sign_up/state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpController extends GetxController {
  final SignUpState state = SignUpState();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Text editing controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  // Observable variables
  var isLoading = false.obs;
  var isPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;
  var agreedToTerms = false.obs;

  @override
  void onInit() {
    super.onInit();
    print('SignUpController initialized');
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  void toggleTermsAgreement() {
    agreedToTerms.value = !agreedToTerms.value;
  }

  bool _validateForm() {
    // Validate name
    if (nameController.text.trim().isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Please enter your name',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    // Validate email
    if (!duIsEmail(emailController.text.trim())) {
      Get.snackbar(
        'Validation Error',
        'Please enter a valid email address',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    // Validate password
    if (passwordController.text.length < 6) {
      Get.snackbar(
        'Validation Error',
        'Password must be at least 6 characters long',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    // Validate password confirmation
    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar(
        'Validation Error',
        'Passwords do not match',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    // Validate terms agreement
    if (!agreedToTerms.value) {
      Get.snackbar(
        'Validation Error',
        'Please agree to the terms and conditions',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    return true;
  }

  Future<void> handleSignUp() async {
    if (!_validateForm()) return;

    try {
      isLoading.value = true;

      // Show loading dialog
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      print('Starting sign-up process...');

      // Create user with email and password
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      print('User created in Firebase Auth: ${userCredential.user?.uid}');

      if (userCredential.user != null) {
        // Update display name
        await userCredential.user!.updateDisplayName(nameController.text.trim());

        // Create user document in Firestore
        await _createUserDocument(userCredential.user!);

        // Create user profile for local storage
        final userProfile = UserLoginResponseEntity(
          accessToken: await userCredential.user!.getIdToken(),
          displayName: nameController.text.trim(),
          email: emailController.text.trim(),
          photoUrl: userCredential.user!.photoURL,
        );

        // Save to UserStore
        await UserStore.to.saveProfile(userProfile);

        // Close loading dialog
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }

        print('Sign-up successful: ${userCredential.user?.email}');

        Get.snackbar(
          'Success',
          'Account created successfully!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Navigate to main app or sign-in page
        // You can customize this navigation based on your app flow
        Get.offAllNamed('/sign_in');
      }
    } on FirebaseAuthException catch (e) {
      // Close loading dialog
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }

      String errorMessage = 'Sign-up failed';
      switch (e.code) {
        case 'weak-password':
          errorMessage = 'The password provided is too weak';
          break;
        case 'email-already-in-use':
          errorMessage = 'An account already exists with this email';
          break;
        case 'invalid-email':
          errorMessage = 'Please enter a valid email address';
          break;
        case 'operation-not-allowed':
          errorMessage = 'Email/password accounts are not enabled';
          break;
        default:
          errorMessage = e.message ?? 'Sign-up failed';
      }

      print('Firebase Auth Error: ${e.code} - ${e.message}');
      Get.snackbar(
        'Sign-up Error',
        errorMessage,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      // Close loading dialog
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }

      print('General Sign-up Error: $e');
      Get.snackbar(
        'Error',
        'Sign-up failed: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _createUserDocument(User user) async {
    try {
      final userData = UserData(
        id: user.uid,
        name: nameController.text.trim(),
        email: user.email,
        photourl: user.photoURL,
        addtime: Timestamp.now(),
      );

      await _firestore
          .collection('users')
          .doc(user.uid)
          .set(userData.toFirestore());

      print('User document created in Firestore');
    } catch (e) {
      print('Error creating user document: $e');
      // Don't throw error here as the main sign-up was successful
    }
  }

  void navigateToSignIn() {
    Get.offNamed('/sign_in');
  }
}
