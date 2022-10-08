import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ninjastudy/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:ninjastudy/app/widgets/text_custom.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final authController = AuthenticationController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextCustomized(
              text: "Sign in",
              textSize: 45,
              fontWeight: FontWeight.bold,
              textColor: Colors.black54,
            ),
            const SizedBox(height: 20),
            Center(
              child: Container(
                height: Get.height * 0.2,
                width: Get.width * 0.8,
                decoration: const BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(color: Colors.black45, blurRadius: 6, spreadRadius: 4)
                ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const TextCustomized(
                      text: "You must signin",
                      textSize: 25,
                      textColor: Colors.green,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      icon: Container(
                        padding: const EdgeInsets.all(8),
                        height: 70,
                        width: 70,
                        child: CachedNetworkImage(
                            imageUrl:
                                "https://pngimg.com/uploads/google/google_PNG19630.png"),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black45,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () => authController.signInWithGoogle(),
                      label: const TextCustomized(
                        text: "Signin with google",
                        textSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
