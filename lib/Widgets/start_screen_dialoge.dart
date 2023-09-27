import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task/Global/hex_color.dart';
import 'package:provider/provider.dart';

import '../Controllers/app_settings.dart';

class StartScreenDialoge extends StatelessWidget {
  const StartScreenDialoge({super.key});

  @override
  Widget build(BuildContext context) {
    final AppSettingsController appSettingsController =
        Provider.of<AppSettingsController>(context);
    return Dialog(
      backgroundColor: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.close,
                      size: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 0,
              ),
              Text(
                'Start Screen',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: appSettingsController.isDark
                        ? Colors.white
                        : Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Start Screen',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: appSettingsController.isDark
                                  ? Colors.white
                                  : Colors.black),
                    ),
                    CupertinoCheckbox(
                      value: appSettingsController.enableGps,
                      checkColor: HexColor(colorBlack80),
                      activeColor: Colors.transparent,
                      onChanged: (value) {
                        appSettingsController.changeGps(value!);
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Start Screen',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: appSettingsController.isDark
                                  ? Colors.white
                                  : Colors.black),
                    ),
                    Checkbox(
                      value: false,
                      checkColor: HexColor(colorBlack80),
                      activeColor: HexColor(colorBlack80),
                      onChanged: (value) {},
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
