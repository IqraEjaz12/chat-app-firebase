import 'package:firebase_chat/pages/sign_in/controller.dart';
import 'package:firebase_chat/pages/sign_in/widgets/build_logo.dart';
import 'package:firebase_chat/pages/sign_in/widgets/build_email_login_form.dart';
import 'package:firebase_chat/pages/sign_in/widgets/build_third_party_login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignInPage extends GetView<SiginInController> {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Column(
            children: [
              SizedBox(height: 50.h),
              BuildLogoSignIn(),
              SizedBox(height: 50.h),
              BuildEmailLoginForm(),
              BuildThirdPartyLogin(
                onGoogleSignIn: () => controller.handleGoogleSignIn(),
              ),
              SizedBox(height: 50.h),
            ],
          ),
        ),
      ),
    );
  }
}
