import 'package:firebase_chat/pages/sign_in/controller.dart';
import 'package:firebase_chat/pages/sign_in/widgets/build_logo.dart';
import 'package:firebase_chat/pages/sign_in/widgets/build_third_party_login.dart';
import 'package:firebase_chat/pages/welcome/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dots_indicator/dots_indicator.dart';

class SignInPage extends GetView<SiginInController> {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          BuildLogoSignIn(),
          Spacer(),
          BuildThirdPartyLogin(),
        ],
      ),
    ));
  }
}
