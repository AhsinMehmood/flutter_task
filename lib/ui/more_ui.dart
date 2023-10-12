import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../Controllers/app_settings.dart';
import '../Global/hex_color.dart';
import 'metro_pdf_map.dart';
import 'settings_ui.dart';

class MoreUi extends StatelessWidget {
  const MoreUi({super.key});

  @override
  Widget build(BuildContext context) {
    final AppSettingsController appSettingsController =
        Provider.of<AppSettingsController>(context);
    return Scaffold(
      backgroundColor: appSettingsController.isDark
          ? Theme.of(context).cardColor
          : Colors.white,
      appBar: AppBar(
        title: Text(
          'More Features',
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
        ),
        elevation: 0.0,
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              height: 30,
              width: 30,
              child: InkWell(
                borderRadius: BorderRadius.circular(30),
                splashColor: Colors.grey.shade600,
                onTap: () {
                  showToast("Coming soon",
                      context: context, position: const StyledToastPosition());
                },
                child: const Icon(
                  Icons.search,
                  size: 24,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
        systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.light,
          // systemNavigationBarDividerColor: null,
          statusBarColor: HexColor(colorPurple),
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        backgroundColor: HexColor(colorPurple),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 12,
              ),
              menusUi(
                  title: 'Features Routes Other',
                  subtitle: 'VRE Routes',
                  iconPath: 'assets/multiple_stop.svg',
                  context: context,
                  onTap: () {}),
              const SizedBox(
                height: 12,
              ),
              menusUi(
                  title: 'Guide Map',
                  subtitle: 'Metro Map',
                  iconPath: 'assets/map.svg',
                  context: context,
                  onTap: () {
                    Get.to(() => const MetroPdfMap());
                  }),
              const SizedBox(
                height: 12,
              ),
              menusUi(
                  title: 'Departure Information',
                  subtitle: 'Schedules',
                  iconPath: 'assets/calendar.svg',
                  context: context,
                  onTap: () {}),
              const SizedBox(
                height: 12,
              ),
              menusUi(
                  title: 'Important Information',
                  subtitle: 'Alerts',
                  iconPath: 'assets/error.svg',
                  context: context,
                  onTap: () {}),
              const SizedBox(
                height: 12,
              ),
              menusUi(
                  title: 'General Context',
                  subtitle: 'Settings',
                  iconPath: 'assets/settings.svg',
                  context: context,
                  onTap: () {
                    Get.to(() => const SettingsUi());
                  }),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }

  menusUi(
      {required String title,
      required String subtitle,
      required String iconPath,
      required BuildContext context,
      required Function onTap}) {
    final AppSettingsController appSettingsController =
        Provider.of<AppSettingsController>(context);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color:
                    appSettingsController.isDark ? Colors.white : Colors.black),
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            splashColor: Colors.transparent,
            onTap: () {
              onTap();
            },
            hoverColor: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      iconPath,
                      height: 24,
                      width: 24,
                      color: appSettingsController.isDark
                          ? Colors.white
                          : Colors.black,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: appSettingsController.isDark
                              ? Colors.white
                              : Colors.black),
                    ),
                  ],
                ),
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 18,
                  color: appSettingsController.isDark
                      ? Colors.white
                      : Colors.black,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
