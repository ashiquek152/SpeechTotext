import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ninjastudy/app/data/firebase/firebase_db_helper.dart';
import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:ninjastudy/app/modules/chatscreen/controllers/chatscreen_controller.dart';
import 'package:ninjastudy/app/widgets/text_custom.dart';

class MessgesList extends StatelessWidget {
   MessgesList({Key? key}) : super(key: key);

  final fireBaseDBHelper =FireBaseDBHelper();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatscreenController>(builder: (controller) {
      return controller.recentMesseges.isEmpty
          ? const Center(
              child: TextCustomized(
                text: "Press the mic button record chat",
                textSize: 20,
                textColor: Colors.black45,
              ),
            )
          : ListView.builder(
              itemCount: controller.recentMesseges.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final message = controller.recentMesseges[index]["message"];
                bool sendBy = controller.recentMesseges[index]["sendBy"] ==
                        fireBaseDBHelper.currentUser?.email
                    ? true
                    : false;
                return BubbleNormal(
                  text: message ?? "",
                  textStyle: const TextStyle(color: Colors.white, fontSize: 16),
                  bubbleRadius: 15,
                  color: Colors.black45,
                  isSender: sendBy,
                  sent: true,
                );
              },
            );
    });
  }
}
