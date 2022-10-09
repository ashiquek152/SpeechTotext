import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ninjastudy/app/widgets/text_custom.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const TextCustomized(
          text: "Hello there !",
          textSize: 25,
          textColor: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: ElevatedButton.icon(
              label: const TextCustomized(text: "Logout", textSize: 18),
              onPressed: () => homeController.signout(),
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: AvatarGlow(
            animate: true,
            endRadius: 200,
            curve: Curves.slowMiddle,
            shape: BoxShape.circle,
            repeat: true,
            duration: const Duration(milliseconds: 2000),
            glowColor: Colors.black,
            repeatPauseDuration: const Duration(milliseconds: 100),
            child: GetBuilder<HomeController>(builder: (context) {
              return SizedBox(
                child: controller.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.green,
                        ),
                      )
                    : InkWell(
                        onTap: () => controller.pickRandomUsers(),
                        borderRadius: BorderRadius.circular(130),
                        splashColor: Colors.white,
                        child: Container(
                          alignment: Alignment.center,
                          width: 250.0,
                          height: 250.0,
                          decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black45,
                                  blurRadius: 10,
                                  spreadRadius: 0.2,
                                  blurStyle: BlurStyle.outer,
                                )
                              ]),
                          child: const TextCustomized(
                            text: "Connect with random",
                            textSize: 25,
                          ),
                        ),
                      ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
