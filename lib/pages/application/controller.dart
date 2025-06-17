import 'package:firebase_chat/common/entities/user.dart';
import 'package:firebase_chat/common/store/user.dart';
import 'package:firebase_chat/common/utils/validator.dart';
import 'package:firebase_chat/pages/application/state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ApplicationController extends GetxController {
  final state = ApplicationState();
  ApplicationController();
}
