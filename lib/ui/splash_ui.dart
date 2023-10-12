// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_task/Controllers/routes_controller.dart';
import 'package:flutter_task/Global/hex_color.dart';
import 'package:flutter_task/ui/home_ui.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../Controllers/app_settings.dart';
import '../Controllers/metro_rail_controller.dart';

class SplashUi extends StatefulWidget {
  const SplashUi({super.key});

  @override
  State<SplashUi> createState() => _SplashUiState();
}

class _SplashUiState extends State<SplashUi> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(microseconds: 10)).then((value) async {
      final AppSettingsController appSettingsController =
          Provider.of<AppSettingsController>(context, listen: false);
      final RoutesController routesController =
          Provider.of<RoutesController>(context, listen: false);
      await Provider.of<MetroRailController>(context, listen: false)
          .getMetroRails();
      await Provider.of<RoutesController>(context, listen: false).getRoutes();
      await routesController.generateCustomMarker();

      await appSettingsController.checkTheme();

      await routesController.getBuses(splash: true);
      // routesController.changeSelectedSingleRoute(routeId);

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
