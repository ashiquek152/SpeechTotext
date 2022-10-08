import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ninjastudy/app/modules/chatscreen/widgets/app_bar.dart';
import 'package:ninjastudy/app/modules/chatscreen/widgets/floating_buttons.dart';
import 'package:ninjastudy/app/modules/chatscreen/widgets/messges_list.dart';
import 'package:ninjastudy/app/widgets/text_custom.dart';

import '../controllers/chatscreen_controller.dart';

class ChatscreenView extends GetView<ChatscreenController> {
  ChatscreenView({Key? key}) : super(key: key);

  final chatscreenController = Get.put(ChatscreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Appbar(
          title: controller.randomUserEmail == ""
              ? "Not available"
              : controller.randomUserEmail,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<ChatscreenController>(
          stream: chatscreenController.getRecentChats(),
          builder: (context, snapshot) {
            return SingleChildScrollView(
              reverse: true,
              child: Column(
                children: [
                   MessgesList(),
                  const SizedBox(height: 20),
                  Obx(() {
                    return TextCustomized(
                      text: controller.speechText.value,
                      textSize: 20,
                      textColor: Colors.green,
                    );
                  }),
                  const SizedBox(height: 100),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton:
          FAButtons(chatscreenController: chatscreenController),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }
}
