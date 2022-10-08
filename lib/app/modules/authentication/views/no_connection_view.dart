import 'package:flutter/material.dart';
import 'package:ninjastudy/app/widgets/text_custom.dart';

class NoConnectionView extends StatelessWidget {
  const NoConnectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: TextCustomized(
          text: "You are not connected",
          textSize: 25,
          fontWeight: FontWeight.bold,
          textColor: Colors.black45,
        ),
      ),
    );
  }
}
