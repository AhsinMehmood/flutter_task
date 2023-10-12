import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_task/Controllers/app_settings.dart';
import 'package:flutter_task/Controllers/departures_controller.dart';
import 'package:flutter_task/Controllers/directions_controller.dart';
import 'package:flutter_task/Controllers/metro_rail_controller.dart';
import 'package:flutter_task/Controllers/routes_controller.dart';

import 'package:get/get.dart';

import 'package:json_theme/json_theme.dart';
import 'package:device_preview/device_preview.dart';
import 'package:provider/provider.dart';

import 'Controllers/rail_stations_controller.dart';
import 'ui/splash_ui.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeStr = await rootBundle.loadString('assets/theme.json');
  final themeStrDark = await rootBundle.loadString('assets/dark_theme.json');

  final themeJson = jsonDecode(themeStr);
  final darkThemeJson = jsonDecode(themeStrDark);

  final theme = ThemeDecoder.decodeThemeData(themeJson)!;
  final darkTheme = ThemeDecoder.decodeThemeData(darkThemeJson)!;

  // await Firebase.initializeApp();
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
    builder: (context) => MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppSettingsController()),
        ChangeNotifierProvider(create: (context) => MetroRailController()),
        ChangeNotifierProvider(
            create: (context) => MetroRailStationsController()),
        ChangeNotifierProvider(create: (context) => DirectionsController()),
        ChangeNotifierProvider(create: (context) => DeparturesController()),
        ChangeNotifierProvider(create: (context) => RoutesController()),
      ],
      child: MyApp(
        theme: theme,
        themeStrDark: darkTheme,
      ),
    ),
  ));
}

class MyApp extends StatelessWidget {
  final ThemeData theme;
  final ThemeData themeStrDark;
  const MyApp({super.key, required this.theme, required this.themeStrDark});
//
  ///Great client to work with. Gives clear instructions and sets reasonable deadlines. Would love to collaborate again in the future.
  ///
  ///
  @override
  Widget build(BuildContext context) {
    final AppSettingsController appSettingsController =
        Provider.of<AppSettingsController>(context);
    return GetMaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'BNC Part 2',
      debugShowCheckedModeBanner: false,
      themeMode:
          appSettingsController.isDark ? ThemeMode.dark : ThemeMode.light,
      darkTheme: themeStrDark,
      theme: theme,
      home: const SplashUi(),
    );
  }
}
//nyWMW5nw 



/**
 * 
 * {"Trains":
 * [{
 * "Car":"8",
 * "Destination":"Ballston",
 * "DestinationCode":"K04",
 * "DestinationName":"Ballston-MU",
 * "Group":"1",
 * "Line":"SV",
 * "LocationCode":"N06",
 * "LocationName":"Wiehle-Reston East",
 * "Min":"3"},
 * {"Car":"8",
 * "Destination":"Ashburn",
 * "DestinationCode":"N12",
 * "DestinationName":"Ashburn",
 * "Group":"2",
 * "Line":"SV",
 * "LocationCode":"N06",
 * "LocationName":"Wiehle-Reston East",
 * "Min":"4"},
 * {"Car":"8",
 * "Destination":"Ballston",
 * "DestinationCode":"K04",
 * "DestinationName":"Ballston-MU","Group":"1",
 * "Line":"SV",
 * "LocationCode":"N06",
 * "LocationName":"Wiehle-Reston East",
 * "Min":"11"},
 * {"Car":"8",
 * "Destination":"Ashburn",
 * "DestinationCode":"N12",
 * "DestinationName":"Ashburn",
 * "Group":"2",
 * "Line":"SV",
 * "LocationCode":"N06",
 * "LocationName":"Wiehle-Reston East",
 * "Min":"14"},
 * {"Car":"8",
 * "Destination":"Ballston",
 * "DestinationCode":"K04",
 * "DestinationName":"Ballston-MU",
 * "Group":"1",
 * "Line":"SV",
 * "LocationCode":"N06",
 * "LocationName":"Wiehle-Reston East",
 * "Min":""}]}
 * 
 * */