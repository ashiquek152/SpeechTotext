import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ninjastudy/app/modules/authentication/views/login.dart';
import 'package:ninjastudy/app/modules/authentication/views/no_connection_view.dart';
import 'package:ninjastudy/app/modules/home/views/home_view.dart';
import '../controllers/authentication_controller.dart';

class AuthenticationView extends GetView<AuthenticationController> {
  AuthenticationView({Key? key}) : super(key: key);

  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.connectionType.value == "wifi" ||
            controller.connectionType.value == "mobile") {
          return StreamBuilder<User?>(
            stream: auth.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text("Something went wrong"));
              } else if (snapshot.hasData) {
                return HomeView();
              } else {
                return LoginScreen();
              }
            },
          );
        } else {
          return const NoConnectionView();
        }
      },
    );
  }
}
