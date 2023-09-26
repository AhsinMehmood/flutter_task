import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_task/Widgets/start_screen_dialoge.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../Controllers/app_settings.dart';
import '../Global/hex_color.dart';

class SettingsUi extends StatefulWidget {
  const SettingsUi({super.key});

  @override
  State<SettingsUi> createState() => _SettingsUiState();
}

class _SettingsUiState extends State<SettingsUi> {
  @override
  Widget build(BuildContext context) {
    final AppSettingsController appSettingsController =
        Provider.of<AppSettingsController>(context);
    return Scaffold(
      // backgroundColor: Colors.white,
      backgroundColor: appSettingsController.isDark
          ? Theme.of(context).cardColor
          : Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios_new,
            color: appSettingsController.isDark
                ? Colors.white
                : HexColor(colorBlack100),
            size: 21,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Icon(
              Icons.search,
              color: appSettingsController.isDark
                  ? Colors.white
                  : HexColor(colorBlack100),
              size: 24,
            ),
          ),
        ],
        title: Text(
          'Settings',
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color:
                    appSettingsController.isDark ? Colors.white : Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
        ),
        backgroundColor: appSettingsController.isDark
            ? Theme.of(context).cardColor
            : Colors.white,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarColor:
              appSettingsController.isDark ? Colors.black : Colors.white,
          systemNavigationBarIconBrightness:
              appSettingsController.isDark ? Brightness.light : Brightness.dark,
          // systemNavigationBarDividerColor: null,
          statusBarColor:
              appSettingsController.isDark ? Colors.black : Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness:
              appSettingsController.isDark ? Brightness.dark : Brightness.light,
        ),
        // backgroundColor: HexColor(colorPurple),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _personalPrefrences('Personal Preferences'),
              _liveMapTracking('Live Map Tracking'),
              _transitAgency('Transit Agency'),
              _donations('Donations'),
              _faqs('FAQS'),
              _support('Support'),
              _sharing('Sharing'),
              _general('General'),
            ],
          ),
        ),
      ),
    );
  }

  _general(text) {
    final AppSettingsController appSettingsController =
        Provider.of<AppSettingsController>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: HexColor(colorOrange100),
                fontWeight: FontWeight.w800,
                fontSize: 14,
              ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          'App Version',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: appSettingsController.isDark
                    ? Colors.white
                    : HexColor(colorBlack100),
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'V1.1.6',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: appSettingsController.isDark
                        ? HexColor(colorGrey80)
                        : HexColor(colorBlack60),
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
            ),
            // Icon(
            //   Icons.arrow_forward_ios,
            //   size: 18,
            //   color: appSettingsController.isDark
            //       ? Colors.white.withOpacity(0.8)
            //       : HexColor(colorBlack80),
            // )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          'Terms of use',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: appSettingsController.isDark
                    ? Colors.white
                    : HexColor(colorBlack100),
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Legal jumple blah, blah, blah',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: appSettingsController.isDark
                        ? HexColor(colorGrey80)
                        : HexColor(colorBlack60),
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
            ),
            // Icon(
            //   Icons.arrow_forward_ios,
            //   size: 18,
            //   color: appSettingsController.isDark
            //       ? Colors.white.withOpacity(0.8)
            //       : HexColor(colorBlack80),
            // )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          'Privacy Policy',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: appSettingsController.isDark
                    ? Colors.white
                    : HexColor(colorBlack100),
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Even more legal stuff',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: appSettingsController.isDark
                        ? HexColor(colorGrey80)
                        : HexColor(colorBlack60),
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
            ),
            // Icon(
            //   Icons.arrow_forward_ios,
            //   size: 18,
            //   color: appSettingsController.isDark
            //       ? Colors.white.withOpacity(0.8)
            //       : HexColor(colorBlack80),
            // )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          'About BNC - Better NOVA Connections',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: appSettingsController.isDark
                    ? Colors.white
                    : HexColor(colorBlack100),
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Started from the bottom, now we’re\nhere!',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: appSettingsController.isDark
                        ? HexColor(colorGrey80)
                        : HexColor(colorBlack60),
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
            ),
            // Icon(
            //   Icons.arrow_forward_ios,
            //   size: 18,
            //   color: appSettingsController.isDark
            //       ? Colors.white.withOpacity(0.8)
            //       : HexColor(colorBlack80),
            // )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  _sharing(text) {
    final AppSettingsController appSettingsController =
        Provider.of<AppSettingsController>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: HexColor(colorOrange100),
                fontWeight: FontWeight.w800,
                fontSize: 14,
              ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          'Share with your friends?',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: appSettingsController.isDark
                    ? Colors.white
                    : HexColor(colorBlack100),
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Like the app? share with your friends.\nSupport a local developer',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: appSettingsController.isDark
                        ? HexColor(colorGrey80)
                        : HexColor(colorBlack60),
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
            ),
            // Icon(
            //   Icons.arrow_forward_ios,
            //   size: 18,
            //   color: appSettingsController.isDark
            //       ? Colors.white.withOpacity(0.8)
            //       : HexColor(colorBlack80),
            // )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  _support(text) {
    final AppSettingsController appSettingsController =
        Provider.of<AppSettingsController>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: HexColor(colorOrange100),
                fontWeight: FontWeight.w800,
                fontSize: 14,
              ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          'Email our support team',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: appSettingsController.isDark
                    ? Colors.white
                    : HexColor(colorBlack100),
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          'bnc@jonathancelestin.com',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: appSettingsController.isDark
                    ? HexColor(colorGrey80)
                    : HexColor(colorBlack60),
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'no support offered to users who do\nnot donate to the patreon',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: appSettingsController.isDark
                        ? HexColor(colorGrey80)
                        : HexColor(colorBlack60),
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
            ),
            // Icon(
            //   Icons.arrow_forward_ios,
            //   size: 18,
            //   color: appSettingsController.isDark
            //       ? Colors.white.withOpacity(0.8)
            //       : HexColor(colorBlack80),
            // )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  _faqs(text) {
    final AppSettingsController appSettingsController =
        Provider.of<AppSettingsController>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: HexColor(colorOrange100),
                fontWeight: FontWeight.w800,
                fontSize: 14,
              ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          'FAQS',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: appSettingsController.isDark
                    ? Colors.white
                    : HexColor(colorBlack100),
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'What does that S with in a red box\nand underlined even mean?',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: appSettingsController.isDark
                        ? HexColor(colorGrey80)
                        : HexColor(colorBlack60),
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
            ),
            // Icon(
            //   Icons.arrow_forward_ios,
            //   size: 18,
            //   color: appSettingsController.isDark
            //       ? Colors.white.withOpacity(0.8)
            //       : HexColor(colorBlack80),
            // )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  _donations(text) {
    final AppSettingsController appSettingsController =
        Provider.of<AppSettingsController>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: HexColor(colorOrange100),
                fontWeight: FontWeight.w800,
                fontSize: 14,
              ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          'Become a patreon',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: appSettingsController.isDark
                    ? Colors.white
                    : HexColor(colorBlack100),
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Help me keep this project alive and\nmake taking public transit better',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: appSettingsController.isDark
                        ? HexColor(colorGrey80)
                        : HexColor(colorBlack60),
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
            ),
            // Icon(
            //   Icons.arrow_forward_ios,
            //   size: 18,
            //   color: appSettingsController.isDark
            //       ? Colors.white.withOpacity(0.8)
            //       : HexColor(colorBlack80),
            // )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  _transitAgency(text) {
    final AppSettingsController appSettingsController =
        Provider.of<AppSettingsController>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: HexColor(colorOrange100),
                fontWeight: FontWeight.w800,
                fontSize: 14,
              ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          'Filter transit agencies',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: appSettingsController.isDark
                    ? Colors.white
                    : HexColor(colorBlack100),
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Select transit agencies you would like \nto see',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: appSettingsController.isDark
                        ? HexColor(colorGrey80)
                        : HexColor(colorBlack60),
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
            ),
            // Icon(
            //   Icons.arrow_forward_ios,
            //   size: 18,
            //   color: appSettingsController.isDark
            //       ? Colors.white.withOpacity(0.8)
            //       : HexColor(colorBlack80),
            // )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  _liveMapTracking(text) {
    final AppSettingsController appSettingsController =
        Provider.of<AppSettingsController>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: HexColor(colorOrange100),
                fontWeight: FontWeight.w800,
                fontSize: 14,
              ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          'Update Frequency?',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: appSettingsController.isDark
                    ? Colors.white
                    : HexColor(colorBlack100),
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Frequenty (30 seconds)',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: appSettingsController.isDark
                        ? HexColor(colorGrey80)
                        : HexColor(colorBlack80),
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: appSettingsController.isDark
                  ? Colors.white.withOpacity(0.8)
                  : HexColor(colorBlack80),
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          'Display Route Path',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: appSettingsController.isDark
                    ? Colors.white
                    : HexColor(colorBlack100),
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Draws a line along selected route',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: appSettingsController.isDark
                        ? HexColor(colorGrey80)
                        : HexColor(colorBlack80),
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
            ),
            SizedBox(
              width: 50,
              height: 35,
              child: FittedBox(
                fit: BoxFit.fill,
                child: Switch(
                    value: appSettingsController.displayRoutePath,
                    activeColor: HexColor(colorPurple),
                    onChanged: (onChanged) {
                      appSettingsController.changeDisplayRoutePath(onChanged);
                    }),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          'Enable GPS?',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: appSettingsController.isDark
                    ? Colors.white
                    : HexColor(colorBlack100),
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'When turned on GPS will be used to\nshow location',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: appSettingsController.isDark
                        ? HexColor(colorGrey80)
                        : HexColor(colorBlack80),
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
            ),
            SizedBox(
              width: 50,
              height: 35,
              child: FittedBox(
                fit: BoxFit.fill,
                child: Switch(
                    value: appSettingsController.enableGps,
                    activeColor: HexColor(colorPurple),
                    onChanged: (onChanged) {
                      appSettingsController.changeGps(onChanged);
                    }),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  _personalPrefrences(text) {
    final AppSettingsController appSettingsController =
        Provider.of<AppSettingsController>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: HexColor(colorOrange100),
                fontWeight: FontWeight.w800,
                fontSize: 14,
              ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          'Start Screen',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: appSettingsController.isDark
                    ? Colors.white
                    : HexColor(colorBlack100),
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
        ),
        const SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () {
            // Get.dialog(const StartScreenDialoge());
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Bus Routes',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: appSettingsController.isDark
                          ? HexColor(colorGrey80)
                          : HexColor(colorBlack60),
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 18,
                color: appSettingsController.isDark
                    ? Colors.white.withOpacity(0.8)
                    : HexColor(colorBlack80),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          'Theme',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: appSettingsController.isDark
                    ? Colors.white
                    : HexColor(colorBlack100),
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              appSettingsController.isDark ? 'Dark' : 'Light',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: appSettingsController.isDark
                        ? HexColor(colorGrey80)
                        : HexColor(colorBlack80),
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
            ),
            SizedBox(
              width: 50,
              height: 35,
              child: FittedBox(
                fit: BoxFit.fill,
                child: Switch(
                    value: appSettingsController.isDark,
                    activeColor: HexColor(colorPurple),
                    onChanged: (onChanged) {
                      appSettingsController.changeTheme(onChanged);
                    }),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
