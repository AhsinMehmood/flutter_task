import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_task/ui/select_multi_routes_ui.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../Controllers/app_settings.dart';
import '../Controllers/routes_controller.dart';
import '../ui/vehicles_single_route.dart';

class RoutesSelection extends StatelessWidget {
  const RoutesSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final AppSettingsController appSettingsController =
        Provider.of<AppSettingsController>(context);
    final RoutesController routesController =
        Provider.of<RoutesController>(context);
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: appSettingsController.isDark
              ? Theme.of(context).cardColor
              : Colors.white,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                      onTap: () {
                        Get.close(1);
                      },
                      child: const Icon(Icons.close)),
                ],
              ),
              Text(
                'Please select the route you\nwant option',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: appSettingsController.isDark
                          ? Colors.white
                          : Colors.black,
                      fontSize: 14,
                    ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'System will automatically display the results of the\nselected route option',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: appSettingsController.isDark
                          ? Colors.white
                          : Colors.black,
                      fontSize: 11,
                    ),
              ),
              const SizedBox(
                height: 10,
              ),
              Card(
                color: appSettingsController.isDark
                    ? Theme.of(context).cardColor
                    : Colors.white,

                // elevation: 4.0,
                elevation: 2.0,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    routesController.getBuses(isFilter: true);

                    // SingleRouteBusSearch
                    routesController.changeSelectedRouteOption(1);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset(
                          'assets/multi_routes.svg',
                          color: appSettingsController.isDark
                              ? Colors.white
                              : Colors.black,
                          height: 25,
                          width: 25,
                        ),
                        Text(
                          'All Vehicles',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                color: appSettingsController.isDark
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 11,
                              ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Card(
                color: appSettingsController.isDark
                    ? Theme.of(context).cardColor
                    : Colors.white,
                elevation: 2.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(
                  onTap: () {
                    // routesController.changeSelectedRouteOption(2);

                    Navigator.pop(context);
                    Get.to(() => const SelectMultiRoutesUi());
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset(
                          'assets/vehicles_on_multi.svg',
                          height: 25,
                          width: 25,
                          color: appSettingsController.isDark
                              ? Colors.white
                              : Colors.black,
                        ),
                        Text(
                          'Vehicles on Multiple routes',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                color: appSettingsController.isDark
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 11,
                              ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Card(
                color: appSettingsController.isDark
                    ? Theme.of(context).cardColor
                    : Colors.white,
                elevation: 2.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    // routesController.getBuses();
                    Get.to(() => const SingleRouteBusSearch(
                          option: 3,
                        ));
                    // routesController.changeSelectedRouteOption(1);
                    // routesController.changeSelectedRouteOption(3);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset(
                          'assets/directions_bus.svg',
                          height: 25,
                          width: 25,
                          color: appSettingsController.isDark
                              ? Colors.white
                              : Colors.black,
                        ),
                        Text(
                          'Vehicles on one route',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                color: appSettingsController.isDark
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 11,
                              ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Card(
                color: appSettingsController.isDark
                    ? Theme.of(context).cardColor
                    : Colors.white,
                elevation: 2.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    // routesController.getBuses();
                    Get.to(() => const SingleRouteBusSearch(
                          option: 4,
                        ));
                    // routesController.changeSelectedRouteOption(4);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset(
                          'assets/place.svg',
                          height: 25,
                          width: 25,
                          color: appSettingsController.isDark
                              ? Colors.white
                              : Colors.black,
                        ),
                        Text(
                          'Routes',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                color: appSettingsController.isDark
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 11,
                              ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
