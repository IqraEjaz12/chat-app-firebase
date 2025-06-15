import 'package:firebase_chat/common/widgets/widgets.dart';
import 'package:firebase_chat/pages/sign_up/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpPage extends GetView<SignUpController> {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => controller.navigateToSignIn(),
        ),
        title: Text(
          'Create Account',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30.h),
              
              // Welcome text
              Text(
                'Join us today!',
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Create your account to get started',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 40.h),

              // Name field
              Text(
                'Full Name',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8.h),
              _buildNameField(),
              SizedBox(height: 20.h),

              // Email field
              Text(
                'Email Address',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8.h),
              _buildEmailField(),
              SizedBox(height: 20.h),

              // Password field
              Text(
                'Password',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8.h),
              _buildPasswordField(),
              SizedBox(height: 20.h),

              // Confirm Password field
              Text(
                'Confirm Password',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8.h),
              _buildConfirmPasswordField(),
              SizedBox(height: 30.h),

              // Terms and conditions
              _buildTermsCheckbox(),
              SizedBox(height: 30.h),

              // Sign up button
              _buildSignUpButton(),
              SizedBox(height: 20.h),

              // Sign in link
              _buildSignInLink(),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNameField() {
    return Container(
      height: 50.h,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: TextField(
        controller: controller.nameController,
        decoration: InputDecoration(
          hintText: 'Enter your full name',
          hintStyle: TextStyle(color: Colors.grey[500]),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          prefixIcon: Icon(Icons.person_outline, color: Colors.grey[500]),
        ),
        style: TextStyle(fontSize: 16.sp),
      ),
    );
  }

  Widget _buildEmailField() {
    return Container(
      height: 50.h,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: TextField(
        controller: controller.emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: 'Enter your email address',
          hintStyle: TextStyle(color: Colors.grey[500]),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          prefixIcon: Icon(Icons.email_outlined, color: Colors.grey[500]),
        ),
        style: TextStyle(fontSize: 16.sp),
      ),
    );
  }

  Widget _buildPasswordField() {
    return Obx(() => Container(
      height: 50.h,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: TextField(
        controller: controller.passwordController,
        obscureText: !controller.isPasswordVisible.value,
        decoration: InputDecoration(
          hintText: 'Enter your password',
          hintStyle: TextStyle(color: Colors.grey[500]),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          prefixIcon: Icon(Icons.lock_outline, color: Colors.grey[500]),
          suffixIcon: IconButton(
            icon: Icon(
              controller.isPasswordVisible.value 
                  ? Icons.visibility_off 
                  : Icons.visibility,
              color: Colors.grey[500],
            ),
            onPressed: controller.togglePasswordVisibility,
          ),
        ),
        style: TextStyle(fontSize: 16.sp),
      ),
    ));
  }

  Widget _buildConfirmPasswordField() {
    return Obx(() => Container(
      height: 50.h,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: TextField(
        controller: controller.confirmPasswordController,
        obscureText: !controller.isConfirmPasswordVisible.value,
        decoration: InputDecoration(
          hintText: 'Confirm your password',
          hintStyle: TextStyle(color: Colors.grey[500]),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          prefixIcon: Icon(Icons.lock_outline, color: Colors.grey[500]),
          suffixIcon: IconButton(
            icon: Icon(
              controller.isConfirmPasswordVisible.value 
                  ? Icons.visibility_off 
                  : Icons.visibility,
              color: Colors.grey[500],
            ),
            onPressed: controller.toggleConfirmPasswordVisibility,
          ),
        ),
        style: TextStyle(fontSize: 16.sp),
      ),
    ));
  }

  Widget _buildTermsCheckbox() {
    return Obx(() => Row(
      children: [
        Checkbox(
          value: controller.agreedToTerms.value,
          onChanged: (value) => controller.toggleTermsAgreement(),
          activeColor: Colors.blue,
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
              children: [
                const TextSpan(text: 'I agree to the '),
                TextSpan(
                  text: 'Terms and Conditions',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const TextSpan(text: ' and '),
                TextSpan(
                  text: 'Privacy Policy',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }

  Widget _buildSignUpButton() {
    return Obx(() => Container(
      width: double.infinity,
      height: 50.h,
      child: ElevatedButton(
        onPressed: controller.isLoading.value 
            ? null 
            : controller.handleSignUp,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          elevation: 0,
        ),
        child: controller.isLoading.value
            ? const CircularProgressIndicator(color: Colors.white)
            : Text(
                'Create Account',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
      ),
    ));
  }

  Widget _buildSignInLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account? ',
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey[600],
          ),
        ),
        GestureDetector(
          onTap: controller.navigateToSignIn,
          child: Text(
            'Sign In',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.blue,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
