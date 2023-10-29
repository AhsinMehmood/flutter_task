import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_task/Controllers/rail_stations_controller.dart';
import 'package:flutter_task/Models/metro_rail_model.dart';
import 'package:flutter_task/Models/metro_rail_stations_model.dart';
import 'package:flutter_task/ui/directions_ui.dart';
import 'package:get/get.dart';
// import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';

import '../Controllers/app_settings.dart';
import '../Global/hex_color.dart';

class MetroRailStationsUi extends StatefulWidget {
  final MetroRailModel metroRailModel;

  final Color color;
  final Color secondColor;
  const MetroRailStationsUi(
      {super.key,
      required this.metroRailModel,
      required this.secondColor,
      required this.color});

  @override
  State<MetroRailStationsUi> createState() => _MetroRailStationsUiState();
}

class _MetroRailStationsUiState extends State<MetroRailStationsUi> {
  bool _loading = true;
  List<MetroRailStationsModel> _metroRailStationsFilter = [];
  String search = '';
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1)).then((value) async {
      await Provider.of<MetroRailStationsController>(context, listen: false)
          .getMetroRailStations(
              stationsList: widget.metroRailModel.stationsList,
              stationsCustomOrderList: widget.metroRailModel.customOrderList)
          .then((value) {
        setState(() {
          _loading = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final MetroRailStationsController metroRailStationsController =
        Provider.of<MetroRailStationsController>(context);
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
            padding: const EdgeInsets.only(
              right: 20,
            ),
            child: IconButton(
                onPressed: () {
                  showToast('Coming soon',
                      context: context,
                      position:
                          const StyledToastPosition(align: Alignment.center));
                },
                icon: Icon(
                  Icons.search,
                  color: appSettingsController.isDark
                      ? Colors.white
                      : Colors.black,
                  size: 24,
                )),
          )
        ],
        title: Text(
          'Stations',
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
          statusBarColor: appSettingsController.isDark
              ? Theme.of(context).cardColor
              : Colors.white,
          statusBarIconBrightness:
              appSettingsController.isDark ? Brightness.light : Brightness.dark,
          statusBarBrightness:
              appSettingsController.isDark ? Brightness.light : Brightness.dark,
        ),
        // backgroundColor: HexColor(colorPurple),
      ),
      body: Column(
        children: [
          // const SizedBox(
          //   height: 20,
          // ),
          Container(
            height: 50,
            margin:
                const EdgeInsets.only(top: 10, bottom: 10, right: 20, left: 20),
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
                    color: appSettingsController.isDark
                        ? HexColor(colorGrey80)
                        : HexColor(colorBlack60),
                    size: 24,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: TextFormField(
                  onChanged: (String value) {
                    setState(() {
                      search = value.capitalizeFirst!;
                      _metroRailStationsFilter = metroRailStationsController
                          .metroRailStations
                          .where((element) => element.name
                              .toLowerCase()
                              .contains(search.toLowerCase()))
                          .toList();
                      // if (value.length == 1) {

                      // } else {
                      //   search = value;
                      //   _metroRailsFilter = metroRailProvider.metroRails
                      //       .where((element) =>
                      //           element.displayName.contains(search))
                      //       .toList();
                      // }
                    });
                  },
                  scrollPadding: const EdgeInsets.all(0),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: appSettingsController.isDark
                          ? Colors.white
                          : Colors.black,
                      fontSize: 12),
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(0),
                      hintText: 'Search Stations...',
                      border: InputBorder.none,
                      hintStyle:
                          Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: appSettingsController.isDark
                                    ? HexColor(colorGrey80)
                                    : HexColor(colorBlack60),
                                fontSize: 12,
                              )),
                ))
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          _loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Expanded(
                  child: search.isNotEmpty
                      ? ListView.builder(
                          itemCount: _metroRailStationsFilter.length,
                          itemBuilder: (context, index) {
                            final metroRailStations =
                                _metroRailStationsFilter[index];
                            return cardUi(metroRailStations);
                          },
                        )
                      : ListView.builder(
                          itemCount: metroRailStationsController
                              .metroRailStations.length,
                          itemBuilder: (context, index) {
                            final metroRailStations =
                                metroRailStationsController
                                    .metroRailStations[index];
                            return cardUi(metroRailStations);
                          },
                        ))
        ],
      ),
    );
  }

  cardUi(metroRailStations) {
    final AppSettingsController appSettingsController =
        Provider.of<AppSettingsController>(context);
    return InkWell(
      onTap: () {
        Get.to(() => DirectionsUi(
              metroRailStationsModel: widget.metroRailModel,
              metroRailStationsModels: metroRailStations,
              colorSecond: widget.secondColor,
              color: widget.color,
            ));
      },
      child: Container(
        margin: const EdgeInsets.only(top: 1, left: 10, right: 10, bottom: 10),
        child: ListTile(
          // trailing: const Icon(Icons.keyboard_arrow_down_outlined),
          title: Text(
            metroRailStations.name,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontSize: 12,
                color:
                    appSettingsController.isDark ? Colors.white : Colors.black,
                fontWeight: FontWeight.normal),
          ),
          leading: Container(
            height: 36,
            width: 47.53,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                metroRailStations.code,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ),
          subtitle: Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Container(
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                      color: widget.color,
                      borderRadius: BorderRadius.circular(120),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${widget.metroRailModel.displayName} Line',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: appSettingsController.isDark
                              ? Colors.white
                              : Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                        ),
                  ),
                ],
              ),
            ],
          ),
          // children: [
          //   Row(
          //     children: [
          //       Image.asset('assets/bus.png'),
          //       Text(metroRailStations.name),
          //     ],
          //   )
          // ],
        ),
      ),
    );
  }
}
