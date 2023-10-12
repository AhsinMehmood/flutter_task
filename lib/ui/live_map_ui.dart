import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../Controllers/app_settings.dart';
import '../Controllers/routes_controller.dart';
import '../Global/hex_color.dart';
import '../Models/routes_model.dart';

import '../Widgets/map_widget.dart';

import '../Widgets/routes_selection_dialoge.dart';
import 'select_multi_routes_ui.dart';

class LiveMapUi extends StatefulWidget {
  const LiveMapUi({super.key});

  @override
  State<LiveMapUi> createState() => _LiveMapUiState();
}

class _LiveMapUiState extends State<LiveMapUi> {
  @override
  void initState() {
    super.initState();
  }

  double percentage = 1.0;

  @override
  Widget build(BuildContext context) {
    final AppSettingsController appSettingsController =
        Provider.of<AppSettingsController>(context);
    final RoutesController routesController =
        Provider.of<RoutesController>(context);
    // _markers.clear();

    return WillPopScope(
      onWillPop: () async {
        routesController.stopCountdown();
        routesController.changeSelectedRouteOption(3);
        routesController.clearPolyLines();
        // Get.offAll(() => const Home());

        return true;
      },
      child: Scaffold(
        backgroundColor: appSettingsController.isDark
            ? Theme.of(context).cardColor
            : Colors.white,
        appBar: AppBar(
          title: Text(
            'Map Tracking',
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
          ),
          elevation: 0.0,
          centerTitle: true,
          actions: [
            InkWell(
              onTap: null,
              child: Container(
                height: 30,
                width: 50,
                padding: const EdgeInsets.only(top: 0, right: 15),
                margin: const EdgeInsets.only(top: 10, bottom: 10, right: 0),
                child: routesController.loading
                    ? const Center(
                        child: Padding(
                          padding: EdgeInsets.all(1.0),
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      )
                    : Stack(
                        children: [
                          Transform.rotate(
                            angle: 1.0,
                            child: CircularProgressIndicator(
                              strokeCap: StrokeCap.round,
                              color: Colors.white,
                              value: routesController.countdownPercentage,
                            ),
                          ),
                          Center(
                            child: Text(
                              routesController.countdownValue.toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontSize: 10.0),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                Get.dialog(const RoutesSelection());
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 20, left: 10),
                child: routesController.selectedRouteOption == 1
                    ? SvgPicture.asset(
                        'assets/multi_routes.svg',
                        color: Colors.white,
                      )
                    : routesController.selectedRouteOption == 2
                        ? SvgPicture.asset(
                            'assets/vehicles_on_multi.svg',
                            color: Colors.white,
                          )
                        : routesController.selectedRouteOption == 3
                            ? SvgPicture.asset(
                                'assets/directions_bus.svg',
                                color: Colors.white,
                              )
                            : SvgPicture.asset(
                                'assets/place.svg',
                                color: Colors.white,
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
          leading: IconButton(
            onPressed: () {
              routesController.stopCountdown();
              routesController.clearPolyLines();
              routesController.changeSelectedRouteOption(3);
              // Get.offAll(() => const Home());
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
          ),
        ),
        body: Stack(
          children: [
            const LiveMapWidget(),
            // Container(
            //   height: Get.height,
            //   width: Get.width,
            //   color: Colors.red,
            // ),
            // buildFloatingSearchBar(),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    // height: 50,
                    margin: const EdgeInsets.only(
                        top: 10, bottom: 6, right: 20, left: 20),
                    width: Get.width,
                    decoration: BoxDecoration(
                        color: appSettingsController.isDark
                            ? Theme.of(context).cardColor
                            : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: appSettingsController.isDark
                              ? HexColor(colorBlack80)
                              : HexColor(colorGrey60),
                        )),
                    padding: const EdgeInsets.only(
                        // bottom: 5,
                        // top: 0,
                        // left: 15,
                        ),
                    child: routesController.selectedRouteOption == 3
                        ? lisTileCard(routesController.selectedSingleRoute)
                        : routesController.selectedRouteOption == 4
                            ? lisTileCard(routesController.selectedSingleRoute)
                            : _searchBar(),
                  ),
                  if (search.isNotEmpty)
                    Container(
                      decoration: BoxDecoration(
                        // color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      height: Get.height - 400,
                      margin: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      child: ListView.builder(
                          itemCount: _searchRoutes.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final RouteModel routeModel = _searchRoutes[index];
                            return lisTileCard2(routeModel, index);
                          }),
                    )
                ],
              ),
            ),

            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: appSettingsController.isDark
                              ? HexColor(colorBlack100)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        margin: const EdgeInsets.only(left: 20, bottom: 20),
                        child: InkWell(
                          onTap: () {
                            routesController.getBuses(isRefresh: true);
                            // routesController.filterBusesByRoute();
                          },
                          child: const Icon(
                            Icons.refresh_outlined,
                            size: 24,
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () async {
                              routesController.mapController
                                  .animateCamera(CameraUpdate.zoomIn());
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: appSettingsController.isDark
                                    ? HexColor(colorBlack100)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              margin:
                                  const EdgeInsets.only(right: 20, bottom: 5),
                              child: const Icon(Icons.add),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              routesController.mapController
                                  .animateCamera(CameraUpdate.zoomOut());
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: appSettingsController.isDark
                                    ? HexColor(colorBlack100)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              margin:
                                  const EdgeInsets.only(right: 20, bottom: 10),
                              child: const Icon(Icons.remove),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  if (routesController.selectedRouteOption == 2)
                    Container(
                      height: 120,
                      decoration: BoxDecoration(
                          color: appSettingsController.isDark
                              ? Theme.of(context).cardColor
                              : Colors.white,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(22),
                            topRight: Radius.circular(22),
                          )),
                      padding: const EdgeInsets.all(10),
                      width: Get.width,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 3,
                            width: 37,
                            decoration: BoxDecoration(
                              color: HexColor('D9D9D9'),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Multiple Routes',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color: appSettingsController.isDark
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 14,
                                    ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(() => const SelectMultiRoutesUi());
                                },
                                child: Text(
                                  'See All',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        color: appSettingsController.isDark
                                            ? HexColor('BABABA')
                                            : Colors.black,
                                        fontSize: 14,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 40,
                            width: Get.width,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: routesController.selectedRoutes.length,
                              itemBuilder: (context, index) {
                                final RouteModel routeModel =
                                    routesController.selectedRoutes[index];
                                // String id = routeModel.name.split('-').first;
                                return Container(
                                  height: 35,
                                  margin: const EdgeInsets.only(left: 15),
                                  width: 47.53,
                                  decoration: BoxDecoration(
                                    color: HexColor(colorGrey80),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Center(
                                    child: Text(routeModel.routeID),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  List<RouteModel> _searchRoutes = [];
  Widget _searchBar() {
    final RoutesController routesController =
        Provider.of<RoutesController>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 15),
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.search,
                  color: HexColor(colorBlack60),
                ),
                hintText: 'Search Routes...',
                hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: HexColor(colorBlack60),
                    fontSize: 12,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.normal)),
            onChanged: (value) {
              setState(() {
                if (value.isEmpty) {
                  _searchRoutes.clear();
                  search = '';
                } else {
                  search = value;
                  _searchRoutes = routesController.routes
                      .where((element) => element.name
                          .toLowerCase()
                          .contains(value.toLowerCase()))
                      .toList();
                }
              });
            },
          ),
        ],
      ),
    );
  }

  String search = '';
  String selectedRoute = '';
  lisTileCard2(RouteModel routeModel, int index) {
    final AppSettingsController appSettingsController =
        Provider.of<AppSettingsController>(context);
    final RoutesController routesController =
        Provider.of<RoutesController>(context);

    return Container(
      padding: const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 10),

      decoration: BoxDecoration(
        color: appSettingsController.isDark
            ? Theme.of(context).cardColor
            : Colors.white,
        borderRadius: index == 0
            ? const BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12))
            : const BorderRadius.only(),
      ),
      // margin: const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 5),
      child: InkWell(
        onTap: () async {
          // routesController.
          setState(() {
            selectedRoute = routeModel.name;
            search = '';
          });
          routesController.changeSelectedRouteOption(3);
          routesController.changeSelectedSingleRoute(selectedRoute);
          routesController.clearPolyLines();

          // Get.back();
          await routesController.getBuses(isFilter: true);
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
                      color: selectedRoute == routeModel.name
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

  lisTileCard(String routeModel) {
    final AppSettingsController appSettingsController =
        Provider.of<AppSettingsController>(context);
    final RoutesController routesController =
        Provider.of<RoutesController>(context);

    return Container(
      padding: const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
      // color: selectedRoute == routeModel.name ? HexColor(colorPurple) : null,
      // margin: const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 5),
      child: InkWell(
        onTap: () {},
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
                  routeModel.split('-').first.trim(),
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
                routeModel,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: appSettingsController.isDark
                          ? Colors.white
                          : HexColor(colorBlack100),
                      fontSize: 12,
                    ),
              ),
            ),
            InkWell(
              onTap: () {
                routesController.getBuses(isFilter: true);
                routesController.changeSelectedSingleRoute('');
                // SingleRouteBusSearch
                routesController.changeSelectedRouteOption(1);
                setState(() {
                  _searchRoutes.clear();
                  selectedRoute = '';
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.close,
                  size: 18,
                  color: appSettingsController.isDark ? Colors.white : null,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
