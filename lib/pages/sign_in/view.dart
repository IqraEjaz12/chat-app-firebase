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
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(left: 40.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        BuildLogoSignIn(),
                        SizedBox(height: 10.h),
                        BuildEmailLoginForm(),
                        SizedBox(height: 2.h),
                        BuildThirdPartyLogin(
                          onGoogleSignIn: () => controller.handleGoogleSignIn(),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20.h),
                  child: Text(
                    'Powered by Firebase Chat',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
