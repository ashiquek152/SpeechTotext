
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ninjastudy/app/widgets/text_custom.dart';

class Appbar extends StatelessWidget {
  const Appbar({
    Key? key, required this.title
  }) : super(key: key);

 final String title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title:  TextCustomized(
        text: title,
        textSize: 20,
        textColor: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.green,
        ),
      ),
    );
  }
}
