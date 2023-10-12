import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_task/Controllers/routes_controller.dart';
import 'package:flutter_task/Models/routes_model.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../Controllers/app_settings.dart';
import '../Global/hex_color.dart';

class SelectMultiRoutesUi extends StatefulWidget {
  const SelectMultiRoutesUi({super.key});

  @override
  State<SelectMultiRoutesUi> createState() => _SelectMultiRoutesUiState();
}

class _SelectMultiRoutesUiState extends State<SelectMultiRoutesUi> {
  @override
  void initState() {
    super.initState();
    // Future.delayed(const Duration(milliseconds: 1)).then((value) {
    //   // Provider.of<RoutesController>(context, listen: false).getRoutes();
    // });
  }

  String search = '';
  List<RouteModel> _searchRoutes = [];

  @override
  Widget build(BuildContext context) {
    final AppSettingsController appSettingsController =
        Provider.of<AppSettingsController>(context);
    final RoutesController routesController =
        Provider.of<RoutesController>(context);

    return WillPopScope(
      onWillPop: () async {
        // Get.offAll(() => const LiveMapUi());
        return true;
      },
      child: Scaffold(
        backgroundColor: appSettingsController.isDark
            ? Theme.of(context).cardColor
            : Colors.white,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                // Get.offAll(() => const LiveMapUi());
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_outlined,
                size: 21,
              )),
          title: Text(
            'Multiple Route Selection',
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
          ),
          elevation: 0.0,
          centerTitle: true,
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
        body: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              margin: const EdgeInsets.only(
                  top: 10, bottom: 10, right: 20, left: 20),
              width: Get.width,
              decoration: BoxDecoration(
                  color: appSettingsController.isDark
                      ? Theme.of(context).cardColor
                      : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: HexColor(colorGrey80),
                  )),
              padding: const EdgeInsets.only(
                bottom: 5,
                top: 0,
                left: 15,
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 0,
                      top: 10,
                      left: 0,
                    ),
                    child: Icon(
                      Icons.search,
                      size: 24,
                      color: HexColor(colorBlack80),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: TextFormField(
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: appSettingsController.isDark
                            ? Colors.white
                            : Colors.black),
                    onChanged: (String value) {
                      setState(() {
                        search = value;
                        _searchRoutes = routesController.routes
                            .where((element) => element.name
                                .toLowerCase()
                                .contains(search.toLowerCase()))
                            .toList();
                      });
                    },
                    scrollPadding: const EdgeInsets.all(0),
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(0),
                        hintText: 'Search for multiple routes...',
                        border: InputBorder.none,
                        hintStyle:
                            Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: HexColor(colorBlack80),
                                  fontSize: 12,
                                )),
                  ))
                ],
              ),
            ),
            search.isEmpty
                ? Expanded(
                    child: ListView.builder(
                        itemCount: routesController.routes.length,
                        itemBuilder: (context, index) {
                          final RouteModel routeModel =
                              routesController.routes[index];
                          return lisTileCard(routeModel);
                        }))
                : Expanded(
                    child: ListView.builder(
                        itemCount: _searchRoutes.length,
                        itemBuilder: (context, index) {
                          final RouteModel routeModel = _searchRoutes[index];
                          return lisTileCard(routeModel);
                        })),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: InkWell(
          onTap: () async {
            if (routesController.selectedRoutesIds.length < 2) {
              Get.dialog(const ErrorDialoge());
            } else {
              routesController.changeSelectedRouteOption(2);
              routesController.clearPolyLines();
              routesController.customInfoWindow.hideInfoWindow!();

              // routesController.selectRoutes(selectedList);
              Get.back();
              await routesController.getBuses(isFilter: true);
              // mapController.
              // routesController.filterBusesByRoute();
            }
          },
          child: Container(
            width: Get.width * 0.8,
            margin: const EdgeInsets.only(left: 15, right: 15),
            decoration: BoxDecoration(
              color: HexColor(colorPurple),
              borderRadius: BorderRadius.circular(12),
            ),
            height: 50,
            child: Center(
              child: Text(
                'Apply',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                      fontSize: 12,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  lisTileCard(RouteModel routeModel) {
    final AppSettingsController appSettingsController =
        Provider.of<AppSettingsController>(context);
    final RoutesController routesController =
        Provider.of<RoutesController>(context);

    return ListTile(
      leading: Container(
        height: 36,
        width: 47.53,
        decoration: BoxDecoration(
          color: HexColor(colorGrey80),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(routeModel.routeID),
        ),
      ),
      title: Text(
        routeModel.name,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: appSettingsController.isDark
                  ? Colors.white
                  : HexColor(colorBlack100),
              fontSize: 12,
            ),
      ),
      // isThreeLine: true,
      trailing: CupertinoCheckbox(
          value: routesController.selectedRoutesIds
              .contains(routeModel.name.split('-').first.trim()),
          checkColor:
              appSettingsController.isDark ? Colors.white : Colors.black,
          activeColor: Colors.transparent,
          side: BorderSide(
              color: appSettingsController.isDark
                  ? HexColor(colorGrey20)
                  : HexColor(colorBlack80)),
          onChanged: (value) {
            routesController.selectRoutes(routeModel);

            // routesController.selectRoutes(routeModel);
          }),
    );
  }
}

class ErrorDialoge2 extends StatelessWidget {
  const ErrorDialoge2({super.key});

  @override
  Widget build(BuildContext context) {
    final AppSettingsController appSettingsController =
        Provider.of<AppSettingsController>(context);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      // backgroundColor: Colors.black,
      child: Container(
        height: 168,
        width: Get.width * 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: appSettingsController.isDark
              ? HexColor(colorBlack100)
              : Colors.white,
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              'You can only select\nupto 10 buses',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: appSettingsController.isDark
                        ? Colors.white
                        : Colors.black,
                    fontSize: 14,
                  ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 50,
                width: Get.width * 0.7,
                decoration: BoxDecoration(
                  color: HexColor(colorPurple),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    'Ok',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ErrorDialoge extends StatelessWidget {
  const ErrorDialoge({super.key});

  @override
  Widget build(BuildContext context) {
    final AppSettingsController appSettingsController =
        Provider.of<AppSettingsController>(context);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      // backgroundColor: Colors.black,
      child: Container(
        height: 168,
        width: Get.width * 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: appSettingsController.isDark
              ? HexColor(colorBlack100)
              : Colors.white,
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              'Please select at least two for\nconnection',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: appSettingsController.isDark
                        ? Colors.white
                        : Colors.black,
                    fontSize: 14,
                  ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 50,
                width: Get.width * 0.7,
                decoration: BoxDecoration(
                  color: HexColor(colorPurple),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    'Ok',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
