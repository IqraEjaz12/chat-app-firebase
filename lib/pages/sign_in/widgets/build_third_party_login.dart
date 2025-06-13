import 'package:firebase_chat/common/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/values/colors.dart';

class BuildThirdPartyLogin extends StatelessWidget {
  const BuildThirdPartyLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 295.w,
      margin: EdgeInsets.only(bottom: 280.h),
      child: Column(
        children: [
          Text(
            "Sign in with Third Party",
            style: TextStyle(
              fontSize: 16.sp,
              height: 1,
              fontWeight: FontWeight.w400,
              color: AppColors.primaryText,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30.h, left: 50.w, right: 50.w),
            child: btnFlatButtonWidget(
              onPressed: () => null,
              width: 200.w,
              height: 55.h,
              title: "Sign in with Google",
            ),
          ),
        ],
      ),
    );
  }
}
