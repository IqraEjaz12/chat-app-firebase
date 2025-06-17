import 'package:firebase_chat/common/style/style.dart';
import 'package:firebase_chat/common/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/values/colors.dart';

class BuildLogoSignIn extends StatelessWidget {
  const BuildLogoSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110.w,
      margin: EdgeInsets.only(top: 84.h),
      child: Column(
        children: [
          Container(
            width: 76.w,
            height: 76.w,
            margin: EdgeInsets.symmetric(horizontal: 15.w),
            child: Stack(
              children: [
                Positioned(
                  child: Container(
                    height: 76.w,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryBackground,
                      borderRadius: BorderRadius.all(
                        Radius.circular(35),
                      ),
                      boxShadow: [
                        Shadows.primaryShadow,
                      ],
                    ),
                  ),
                ),
                Positioned(
                  child: Image.asset(
                    'assets/images/ic_launcher.png',
                    width: 76.w,
                    height: 76.w,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 15.h, bottom: 15.h),
            child: Text(
              'Let\'s Chat',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.sp,
                height: 1,
                fontWeight: FontWeight.w600,
                color: AppColors.thirdElement,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
