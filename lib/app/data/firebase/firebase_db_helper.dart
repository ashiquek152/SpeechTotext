import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ninjastudy/app/models/user_model.dart';
import 'package:ninjastudy/app/modules/chatscreen/views/chatscreen_view.dart';

class FireBaseDBHelper {
  final chatsRoomRef = FirebaseFirestore.instance.collection("CHATROOM");
  final usersRef = FirebaseFirestore.instance.collection("USERS");
  var currentUser = FirebaseAuth.instance.currentUser;

//! //////////////////// --- CREATING NEW USER IN COLLECTION --- //////////////////////////////
  Future<void> createUserInCollection({required UserModel userModel}) async {
    try {
      usersRef.doc(userModel.userEmail).set({
        "email": userModel.userEmail,
        "uid": userModel.userUid,
        "name": userModel.userName,
      });
    } catch (e) {
      log("Creating USERS collection error $e");
    }
  }

//! //////////////////////////////////////////////////

//! //////////////////// --- CREATE CHAT CONVERSATION AND ROOM FIRST TIME --- ////////////////////

  Future<void> createChatConversations(
      {required String reciver, required String reciverEmail}) async {
    await currentUser?.reload();
    currentUser = FirebaseAuth.instance.currentUser;
    try {
      if (currentUser != null) {
        String chatRoomID = await checkExistingChatroomID(
            sender: currentUser!.uid, reciver: reciver);
        if (chatRoomID == "No Rooms found") {
          chatRoomID = createChatRoomID(reciver, currentUser!.uid);
          List<String> users = [reciver, currentUser!.uid];
          Map<String, dynamic> usersMap = {
            "users": users,
            "roomId": chatRoomID,
          };
          await createNewChatRoom(chatRoomID: chatRoomID, usersMap: usersMap);
        }
        // sendMessages(chatRoomID: chatRoomID);
        //  getRecentChats(chatRoomID: chatRoomID);
        Get.to(() => ChatscreenView(),
            arguments: {
              "chatroomID": chatRoomID,
              "email": reciverEmail,
            },
            curve: Curves.ease,
            duration: const Duration(seconds: 1));
      }
    } catch (e) {
      log("createChatConversations ERROR ${e.toString()}");
    }
  }
//! /////////////////////////////////////////////////////////

//! ///////////////// --- CHECK EXISTING CHATROOMID --- ////////////////////

  Future<String> checkExistingChatroomID(
      {required String sender, required String reciver}) async {
    String roomId1 = createChatRoomID(sender, reciver);
    String roomId2 = createChatRoomID2(reciver, sender);
    final search = await chatsRoomRef.doc(roomId1).get();
    if (search.data() != null) {
      log("RoomID 1 Matched");
      return roomId1;
    }
    final search2 = await chatsRoomRef.doc(roomId2).get();
    if (search2.data() != null) {
      log("RoomID 2 Matched");
      return roomId2;
    } else {
      return "No Rooms found";
    }
  }
//! //////////////////////////////////////////////////

//! ////////// --- CREATING CHAT ROOM IF NOT EXISTING --- /////////////////////

  Future<void> createNewChatRoom(
      {required String chatRoomID,
      required Map<String, dynamic> usersMap}) async {
    return await chatsRoomRef
        .doc(chatRoomID)
        .set(usersMap)
        .catchError((e) => log("Creating Chatroom Error ${e.toString()}"));
  }
//! //////////////////////////////////////////////

//! ///////////////// --- GET ALL USERS --- /////////////////////////////

  Future<List> getAllUser() async {
    List allusers = [];
    await usersRef.get().then((value) {
      allusers.clear();
      value.docs.map((DocumentSnapshot document) {
        Map a = document.data() as Map<String, dynamic>;
        allusers.add(a);
      }).toList();
    });
    // log(allusers.toString());
    return allusers;
  }
//! //////////////////////////////////////////////

//! /////// --- CREATING POSSIBLE ROOMID'S --- //////////////////

  String createChatRoomID(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "${b}_$a";
    } else {
      return "${a}_$b";
    }
  }

  String createChatRoomID2(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "${a}_$b";
    } else {
      return "${b}_$a";
    }
  }
//! //////////////////////////////////////////////

}
