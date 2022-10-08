import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:ninjastudy/app/data/firebase/firebase_db_helper.dart';
import 'package:ninjastudy/app/widgets/snackbar_cutom.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class ChatscreenController extends GetxController {
  late stt.SpeechToText speechToText;
  RxBool isListening = false.obs;
  RxString speechText = "".obs;

  String chatRoomID = "";
  String randomUserEmail = "";
  List recentMesseges = [];
  final fireBaseDBHelper =FireBaseDBHelper();


  @override
  void onInit() {
    super.onInit();
    speechToText = stt.SpeechToText();
    chatRoomID = Get.arguments["chatroomID"];
    randomUserEmail = Get.arguments["email"];
  }

  RxBool isVisible = true.obs;

  void buttonsVisibilty() {
    if (recentMesseges.isNotEmpty &&
        recentMesseges.last["sendBy"] == fireBaseDBHelper.currentUser!.email) {
      isVisible.value = false;
    } else {
      isVisible.value = true;
    }
  }

  Future<void> listenSpeech() async {
    if (!isListening.value) {
      bool available = await speechToText.initialize(
        onError: (error) {
          log(error.toString());
        },
        onStatus: (status) {
          status == "done" || status == "notListening"
              ? isListening.value = false
              : null;
          log(status);
          update();
        },
      );
      if (available) {
        isListening.value = true;
        speechToText.listen(
            onResult: (result) => speechText.value = result.recognizedWords,
            listenMode: stt.ListenMode.confirmation);
      }
    }
  }

  Future<Map<String, String>> addVoicetoList() async {
    isListening.value = false;
    String? chat;
    Map<String, String> messagesMap = {};
    speechText.value != "" ? chat = speechText.value : null;

    await speechToText.stop();
    if (chat != null) {
      messagesMap = {
        "message": chat,
        "sendBy": fireBaseDBHelper.currentUser!.email!
      };
      speechText.value = "";
      return messagesMap;
    } else {
      return messagesMap;
    }
  }

  Future<void> sendChat() async {
    Map<String, String> messagesMap = await addVoicetoList();
    if (messagesMap.isEmpty) {
      snackBarCustom(
          title: "OOPS",
          message: "Could not recognize that please record one more time");
      return;
    }

    final time = DateTime.now();
    await fireBaseDBHelper.chatsRoomRef
        .doc(chatRoomID)
        .collection("CHATS")
        .doc(time.toString())
        .set(messagesMap)
        .catchError((e) {
      log("Send chat ERROR  ${e.toString()}");
    });
  }

  getRecentChats() {
    fireBaseDBHelper.chatsRoomRef
        .doc(chatRoomID)
        .collection("CHATS")
        .where("message")
        .snapshots()
        .forEach((element) {
      recentMesseges.clear();
      element.docs.map((DocumentSnapshot document) {
        Map a = document.data() as Map<dynamic, dynamic>;
        recentMesseges.add(a);
      }).toList();
      buttonsVisibilty();

      update();
    }).catchError((e) {
      log(e.toString());
    });
  }
}
