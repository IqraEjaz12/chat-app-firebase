import 'package:firebase_chat/common/entities/user.dart';
import 'package:firebase_chat/common/store/user.dart';
import 'package:firebase_chat/pages/sign_in/state.dart';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    "openid",
    // 'email',
    // 'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class SiginInController extends GetxController {
  final state = SignInState();
  SiginInController();
  final _auth = FirebaseAuth.instance;

  Future<void> handleGoogleSignIn() async {
    try {
      var user = await _googleSignIn.signIn();
      if (user != null) {
        String userName = user.displayName ?? '';
        String userEmail = user.email;
        String userPhotoUrl = user.photoUrl ?? '';
        String userId = user.id;
        UserLoginResponseEntity userProfile = UserLoginResponseEntity(
          displayName: userName,
          email: userEmail,
          photoUrl: userPhotoUrl,
          accessToken: userId,
        );
        UserStore.to.saveProfile(userProfile);
      }
    } catch (e) {}
  }
}
