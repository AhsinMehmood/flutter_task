import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_task/Global/hex_color.dart';
import 'package:flutter_task/ui/home_ui.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../Controllers/app_settings.dart';

class SplashUi extends StatefulWidget {
  const SplashUi({super.key});

  @override
  State<SplashUi> createState() => _SplashUiState();
}

class _SplashUiState extends State<SplashUi> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then((value) async {
      final AppSettingsController appSettingsController =
          Provider.of<AppSettingsController>(context, listen: false);
      await appSettingsController.checkTheme();
      Get.offAll(() => const Home());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor(colorPurple),
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.light,
          // systemNavigationBarDividerColor: null,
          statusBarColor: HexColor(colorPurple),
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        elevation: 0.0,
        backgroundColor: HexColor(colorPurple),
      ),
      body: Center(
        child: Image.asset(
          'assets/logo_bnc.png',
          width: 131,
          height: 88,
        ),
      ),
    );
  }
}
