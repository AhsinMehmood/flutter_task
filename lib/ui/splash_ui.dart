import 'package:flutter/material.dart';
import 'package:flutter_task/Global/hex_color.dart';
import 'package:flutter_task/ui/home_ui.dart';
import 'package:get/get.dart';

class SplashUi extends StatefulWidget {
  const SplashUi({super.key});

  @override
  State<SplashUi> createState() => _SplashUiState();
}

class _SplashUiState extends State<SplashUi> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then((value) {
      Get.offAll(() => const Home());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor(colorPurple),
      body: Center(
        child: Image.asset(
          'assets/logo_bnc.png',
        ),
      ),
    );
  }
}
