import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:ninjastudy/app/data/firebase/firebase_auth_helper.dart';
import 'package:ninjastudy/app/data/firebase/firebase_db_helper.dart';
import 'package:ninjastudy/app/widgets/snackbar_cutom.dart';

class HomeController extends GetxController {
  final random = Random();

  RxBool isLoading = false.obs;
  List usersList = [];
  final fireBaseDBHelper =FireBaseDBHelper();

  Future<void> pickRandomUsers() async {
    isLoading.value = true;
    update();
    try {
      usersList.clear();
      usersList = await fireBaseDBHelper.getAllUser();
      if (usersList.isEmpty) {
        snackBarCustom(title: "", message: "No users found");
        isLoading.value = false;
        update();
        return;
      }
      var currentUser = FirebaseAuth.instance.currentUser;
      await currentUser?.reload();
      currentUser  = FirebaseAuth.instance.currentUser;

      var randomUser = usersList[random.nextInt(usersList.length)];

//? HANDLING MATCHING WITH THE SAME USER LOGGED IN

      if (randomUser["email"] == currentUser!.email) {
        isLoading.value = false;
        update();
        randomUser = usersList[random.nextInt(usersList.length)];
        snackBarCustom(title: "No users found", message: "Click one more time");
        return;
      } else {
        await fireBaseDBHelper.createChatConversations(
            reciver: randomUser["uid"], reciverEmail: randomUser["email"]);
        isLoading.value = false;
        update();
        return;
      }
    } catch (e) {
      isLoading.value = false;
      update();
      debugPrint(e.toString());
      snackBarCustom(
          title: "Oops", message: "Something went wrong with the server");
    }
  }

  Future signout() async {
    AuthHelper.signout();
  }
}
