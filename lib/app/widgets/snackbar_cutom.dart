import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ninjastudy/app/widgets/text_custom.dart';

  SnackbarController snackBarCustom({required String title, required String message}) {
    return Get.snackbar(
      "",
      "",
      titleText:  TextCustomized(
        text: title,
        textSize: 20,
        textColor: Colors.black45,
        fontWeight: FontWeight.bold,
      ),
      duration: const Duration(milliseconds: 1000),
      messageText:  TextCustomized(
        text: message,
        textSize: 16,
        textColor: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    );
  }