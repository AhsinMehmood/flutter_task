import 'dart:convert';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_task/Controllers/app_settings.dart';
import 'package:flutter_task/Controllers/departures_controller.dart';
import 'package:flutter_task/Controllers/directions_controller.dart';
import 'package:flutter_task/Controllers/metro_rail_controller.dart';
import 'package:flutter_task/ui/home_ui.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:json_theme/json_theme.dart';
import 'package:device_preview/device_preview.dart';
import 'package:provider/provider.dart';

import 'Controllers/rail_stations_controller.dart';
import 'ui/splash_ui.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeStr = await rootBundle.loadString('assets/theme.json');
  final themeJson = jsonDecode(themeStr);
  final theme = ThemeDecoder.decodeThemeData(themeJson)!;
  await Firebase.initializeApp();
  // FlutterError.onError = (errorDetails) {
  //   FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  // };
  // // asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  // PlatformDispatcher.instance.onError = (error, stack) {
  //   FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  //   return true;
  // };
  runApp(DevicePreview(
    enabled: false,
    builder: (context) => MyApp(
      theme: theme,
    ), // Wrap your app
  ));
}

class MyApp extends StatelessWidget {
  final ThemeData theme;
  const MyApp({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppSettingsController()),
        ChangeNotifierProvider(create: (context) => MetroRailController()),
        ChangeNotifierProvider(
            create: (context) => MetroRailStationsController()),
        ChangeNotifierProvider(create: (context) => DirectionsController()),
        ChangeNotifierProvider(create: (context) => DeparturesController()),
      ],
      child: GetMaterialApp(
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        title: 'Flutter Task',
        debugShowCheckedModeBanner: false,
        theme: theme.copyWith(
          textTheme: GoogleFonts.nunitoTextTheme(theme.textTheme),
        ),
        home: const SplashUi(),
      ),
    );
  }
}
