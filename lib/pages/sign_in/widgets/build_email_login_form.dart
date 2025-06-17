import 'package:firebase_chat/common/widgets/widgets.dart';
import 'package:firebase_chat/common/values/colors.dart';
import 'package:firebase_chat/pages/sign_in/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BuildEmailLoginForm extends StatelessWidget {
  const BuildEmailLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SiginInController>();

    return Container(
      width: 295.w,
      margin: EdgeInsets.only(bottom: 30.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Center(
            child: Text(
              "Sign in with Email",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryText,
              ),
            ),
          ),

          SizedBox(height: 30.h),

          // Email input
          inputEmailEdit(
            controller: controller.emailController,
            keyboardType: TextInputType.emailAddress,
            hintText: "Enter your email",
            marginTop: 0,
          ),

          SizedBox(height: 15.h),

          // Password input with toggle visibility
          Obx(() => Container(
                height: 44.h,
                decoration: BoxDecoration(
                  color: AppColors.primaryBackground,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(41, 0, 0, 0),
                      offset: Offset(0, 1),
                      blurRadius: 0,
                    ),
                  ],
                ),
                child: TextField(
                  controller: controller.passwordController,
                  obscureText: !controller.showPassword.value,
                  decoration: InputDecoration(
                    hintText: "Enter your password",
                    contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 9),
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      color: AppColors.primaryText,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.showPassword.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: AppColors.primaryText.withOpacity(0.6),
                      ),
                      onPressed: () => controller.togglePasswordVisibility(),
                    ),
                  ),
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontFamily: "Avenir",
                    fontWeight: FontWeight.w400,
                    fontSize: 18.sp,
                  ),
                ),
              )),

          SizedBox(height: 10.h),

          // Forgot password link
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => controller.handleForgotPassword(),
              child: Text(
                "Forgot Password?",
                style: TextStyle(
                  color: AppColors.primaryElement,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),

          SizedBox(height: 10.h),

          // Forgot Password link
          // Align(
          //   alignment: Alignment.centerRight,
          //   child: TextButton(
          //     onPressed: () => controller.handleForgotPasswordDialog(),
          //     child: Text(
          //       'Forgot Password?',
          //       style: TextStyle(
          //         fontSize: 14.sp,
          //         color: AppColors.primaryElement,
          //       ),
          //     ),
          //   ),
          // ),

          SizedBox(height: 10.h),

          // Sign In button
          Obx(() => btnFlatButtonWidget(
                onPressed: controller.isLoading.value
                    ? () {}
                    : () => controller.handleEmailSignIn(),
                width: 295.w,
                height: 50.h,
                title: controller.isLoading.value ? "Signing In..." : "Sign In",
                gbColor: AppColors.primaryElement,
                fontColor: AppColors.primaryElementText,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              )),

          SizedBox(height: 15.h),

          // Sign Up button
          Obx(() => btnFlatButtonWidget(
                onPressed: controller.isLoading.value
                    ? () {}
                    : () => controller.handleCreateAccount(),
                width: 295.w,
                height: 50.h,
                title: controller.isLoading.value
                    ? "Creating Account..."
                    : "Create Account",
                gbColor: AppColors.secondaryElement,
                fontColor: AppColors.primaryElement,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              )),

          SizedBox(height: 30.h),

          // Divider
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 1,
                  color: AppColors.tabCellSeparator,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  "OR",
                  style: TextStyle(
                    color: AppColors.fourElementText,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 1,
                  color: AppColors.tabCellSeparator,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
