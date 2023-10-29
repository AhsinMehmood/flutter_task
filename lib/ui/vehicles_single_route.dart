import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../Controllers/app_settings.dart';
import '../Controllers/routes_controller.dart';
import '../Global/hex_color.dart';
import '../Models/routes_model.dart';
import 'live_map_ui.dart';

class SingleRouteBusSearch extends StatefulWidget {
  final int option;
  const SingleRouteBusSearch({super.key, required this.option});

  @override
  State<SingleRouteBusSearch> createState() => _SingleRouteBusSearchState();
}

class _SingleRouteBusSearchState extends State<SingleRouteBusSearch> {
  String search = '';
  List<RouteModel> _searchRoutes = [];
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 1)).then((value) {
      Provider.of<RoutesController>(context, listen: false).getRoutes();
      // final RoutesController routesController =
      //     Provider.of<RoutesController>(context, listen: false);
      // setState(() {
      //   for (var element in routesController.selectedRoutes) {
      //     selectedList.add(element);
      //   }
      // });
      // print(selectedList.length);
    });
    super.initState();
  }

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
            'Routes',
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
            statusBarBrightness: Brightness.light,
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
            routesController.changeSelectedRouteOption(widget.option);
            // routesController.changeSelectedSingleRoute(routeModel.name);
            routesController.clearPolyLines();
            // routesController.customInfoWindow.hideInfoWindow!();

            Get.back();
            await routesController.getBuses(isFilter: true);
            // routesController.filterBusesByRoute();
            // Get.offAll(() => const LiveMapUi());
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

    return Container(
      padding: const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 10),
      color: routesController.selectedSingleRoute == routeModel.name
          ? HexColor(colorPurple)
          : null,
      // margin: const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 5),
      child: InkWell(
        onTap: () {
          routesController.changeSelectedSingleRoute(routeModel.name);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 36,
              width: 47.53,
              decoration: BoxDecoration(
                color: HexColor(colorGrey80),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  routeModel.routeID,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                routeModel.name,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: routesController.selectedSingleRoute ==
                              routeModel.name
                          ? Colors.white
                          : appSettingsController.isDark
                              ? Colors.white
                              : HexColor(colorBlack100),
                      fontSize: 12,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
