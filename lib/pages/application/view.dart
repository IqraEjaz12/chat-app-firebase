import 'package:firebase_chat/pages/application/controller.dart';
import 'package:firebase_chat/pages/sign_in/controller.dart';
import 'package:firebase_chat/pages/sign_in/widgets/build_logo.dart';
import 'package:firebase_chat/pages/sign_in/widgets/build_email_login_form.dart';
import 'package:firebase_chat/pages/sign_in/widgets/build_third_party_login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ApplicationPage extends GetView<ApplicationController> {
  const ApplicationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [],
            );
          },
        ),
      ),
    );
  }
}
