import 'package:firebase_chat/common/entities/user.dart';
import 'package:firebase_chat/common/store/user.dart';
import 'package:firebase_chat/common/utils/validator.dart';
import 'package:firebase_chat/common/values/colors.dart';
import 'package:firebase_chat/pages/application/state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ApplicationController extends GetxController {
  final state = ApplicationState();
  ApplicationController();

  late final List<String> tabTitles;
  late final PageController pageController;
  late final List<BottomNavigationBarItem> bottomTabs;

  @override
  void onInit() {
    super.onInit();
    tabTitles = ["Chats", "Contacts", "Profile"];
    pageController = PageController(initialPage: 0);
    bottomTabs = [
      BottomNavigationBarItem(
        icon: const Icon(
          Icons.message,
          color: AppColors.thirdElementText,
        ),
        activeIcon: const Icon(
          Icons.message,
          color: AppColors.secondaryElementText,
        ),
        label: tabTitles[0],
        backgroundColor: AppColors.primaryBackground,
      ),
      BottomNavigationBarItem(
        icon: const Icon(
          Icons.contact_page,
          color: AppColors.thirdElementText,
        ),
        activeIcon: const Icon(
          Icons.contact_page,
          color: AppColors.secondaryElementText,
        ),
        label: tabTitles[0],
        backgroundColor: AppColors.primaryBackground,
      ),
      BottomNavigationBarItem(
        icon: const Icon(
          Icons.contact_page,
          color: AppColors.thirdElementText,
        ),
        activeIcon: const Icon(
          Icons.contact_page,
          color: AppColors.secondaryElementText,
        ),
        label: tabTitles[1],
        backgroundColor: AppColors.primaryBackground,
      ),
      BottomNavigationBarItem(
        icon: const Icon(
          Icons.person,
          color: AppColors.thirdElementText,
        ),
        activeIcon: const Icon(
          Icons.person,
          color: AppColors.secondaryElementText,
        ),
        label: tabTitles[2],
        backgroundColor: AppColors.primaryBackground,
      ),
    ];
  }
}
