import 'package:firebase_chat/common/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/values/colors.dart';

class BuildThirdPartyLogin extends StatelessWidget {
  const BuildThirdPartyLogin({super.key, required this.onGoogleSignIn});

  final VoidCallback onGoogleSignIn;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 295.w,
      margin: EdgeInsets.only(bottom: 80.h),
      child: Column(
        children: [
          Text(
            "Continue with",
            style: TextStyle(
              fontSize: 16.sp,
              height: 1,
              fontWeight: FontWeight.w400,
              color: AppColors.primaryText,
            ),
          ),
          SizedBox(height: 20.h),
          
          // Google Sign-In Button
          btnFlatButtonWidget(
            onPressed: onGoogleSignIn,
            width: 295.w,
            height: 50.h,
            title: "Continue with Google",
            gbColor: AppColors.primaryElement,
            fontColor: AppColors.primaryElementText,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}
