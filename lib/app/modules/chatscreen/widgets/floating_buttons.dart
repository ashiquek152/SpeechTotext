import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ninjastudy/app/widgets/text_custom.dart';

import '../controllers/chatscreen_controller.dart';

class FAButtons extends StatelessWidget {
  const FAButtons({
    Key? key,
    required this.chatscreenController,
  }) : super(key: key);

  final ChatscreenController chatscreenController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Obx(
        () => Visibility(
          visible: chatscreenController.isVisible.value,
          replacement: const Center(
            child: TextCustomized(
              text: "It's not your turn to speak",
              textSize: 20,
              textColor: Colors.black45,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: AvatarGlow(
                  animate: chatscreenController.isListening.value,
                  endRadius: 90.0,
                  repeat: chatscreenController.isListening.value,
                  duration: const Duration(milliseconds: 2000),
                  glowColor: Colors.red,
                  repeatPauseDuration: const Duration(milliseconds: 100),
                  child: FloatingActionButton(
                    heroTag: "record",
                    tooltip: "Press to record",
                    child: Icon(
                      chatscreenController.isListening.value
                          ? Icons.mic
                          : Icons.mic_none,
                    ),
                    onPressed: () => chatscreenController.listenSpeech(),
                  ),
                ),
              ),
              Expanded(
                child: FloatingActionButton.extended(
                  heroTag: "send",
                  label: const TextCustomized(text: "Send", textSize: 18),
                  onPressed: () => chatscreenController.sendChat(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
