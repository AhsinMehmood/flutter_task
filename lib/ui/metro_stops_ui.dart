import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_task/Controllers/departures_controller.dart';
import 'package:flutter_task/Global/hex_color.dart';
import 'package:flutter_task/Models/departures_model.dart';
import 'package:flutter_task/Models/directions_model.dart';
import 'package:flutter_task/Models/metro_rail_stations_model.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:swipe_refresh/swipe_refresh.dart';

import '../Controllers/app_settings.dart';
import '../Models/metro_rail_model.dart';

class MetroStopsUi extends StatefulWidget {
  final MetroRailModel metroRailModel;
  final MetroRailStationsModel metroRailStationsModel;
  final DirectionsModel directionsModel;
  final Color color;
  final Color secondColor;
  const MetroStopsUi(
      {super.key,
      required this.metroRailModel,
      required this.color,
      required this.directionsModel,
      required this.secondColor,
      required this.metroRailStationsModel});

  @override
  State<MetroStopsUi> createState() => _MetroStopsUiState();
}

class _MetroStopsUiState extends State<MetroStopsUi> {
  final List _list = [];
  bool _loading = true;
  @override
  // LocationCode
  void initState() {
    super.initState();
    Future.delayed(const Duration(microseconds: 0)).then((value) {
      Provider.of<DeparturesController>(context, listen: false)
          .getDepartures(
              widget.directionsModel.name,
              widget.metroRailStationsModel.code,
              widget.metroRailStationsModel.lineCode1)
          .then((value) {
        setState(() {
          _loading = false;
        });
      });
    });
  }

  final _controller = StreamController<SwipeRefreshState>.broadcast();

  Stream<SwipeRefreshState> get _stream => _controller.stream;
  Stream<SwipeRefreshState> get _stream2 => _controller.stream;

  @override
  Widget build(BuildContext context) {
    final DeparturesController departuresController =
        Provider.of<DeparturesController>(context);
    final AppSettingsController appSettingsController =
        Provider.of<AppSettingsController>(context);
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: appSettingsController.isDark ? null : Colors.white,
        // centerTitle: true,
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
              right: 10,
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
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 10,
            ),
            child: IconButton(
                onPressed: () {
                  showToast('Coming soon',
                      context: context,
                      position:
                          const StyledToastPosition(align: Alignment.center));
                },
                icon: Icon(
                  Icons.favorite_border_outlined,
                  color: appSettingsController.isDark
                      ? Colors.white
                      : Colors.black,
                  size: 24,
                )),
          ),
        ],
        title: Text(
          'Departures',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
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
        bottom: PreferredSize(
            preferredSize: Size(Get.width, 50),
            child: Container(
              color: HexColor(colorPurple80),
              height: 50,
              child: Center(
                child: Text(
                  widget.metroRailStationsModel.name,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(fontSize: 12, color: Colors.white),
                ),
              ),
            )),
      ),
      backgroundColor: appSettingsController.isDark
          ? Theme.of(context).cardColor
          : Colors.white,
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : departuresController.departures.isEmpty
              ? SwipeRefresh.material(
                  stateStream: _stream,
                  onRefresh: () async {
                    await departuresController.getDepartures(
                        widget.directionsModel.name,
                        widget.metroRailStationsModel.code,
                        widget.metroRailStationsModel.lineCode1);
                    _controller.sink.add(SwipeRefreshState.hidden);
                  },
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    SizedBox(
                      height: 100,
                      width: Get.width,

                      // color: Colors.red,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('assets/no_transfer.png'),
                          Text(
                            'Finish update, no data provided\nTry again later ',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: HexColor(colorGrey100)),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              : SwipeRefresh.material(
                  stateStream: _stream2,
                  // refreshTriggerPullDistance: 80.0,
                  // backgroundColor: HexColor(colorPurple),
                  onRefresh: () async {
                    await departuresController.getDepartures(
                        widget.directionsModel.name,
                        widget.metroRailStationsModel.code,
                        widget.metroRailStationsModel.lineCode1);
                    _controller.sink.add(SwipeRefreshState.hidden);
                  },
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: departuresController.departures.length,
                      itemBuilder: (context, index) {
                        // print(departuresController.departures[index].min);
                        print('object');
                        final DeparturesModel departuresModel =
                            departuresController.departures[index];
                        // if(departuresModel.min)
                        return MyCustomExpansionTile(
                          metroRailStationsModel: widget.metroRailModel,
                          color: widget.color,
                          directions: departuresModel,
                          colorSecond: widget.secondColor,
                          metroRailStationsModels:
                              widget.metroRailStationsModel,
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                departuresModel.destinationName ==
                                        'N Carrollton'
                                    ? 'New Carrollton'
                                    : departuresModel.destinationName,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        color: appSettingsController.isDark
                                            ? Colors.white
                                            : HexColor(colorBlack100)),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    departuresModel.min == ''
                                        ? '? min'
                                        : departuresModel.min == 'ARR'
                                            ? 'Arriving'
                                            : departuresModel.min == 'BRD'
                                                ? 'Boarding'
                                                : '${departuresModel.min} min',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: appSettingsController.isDark
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Container(
                                        height: 10,
                                        width: 10,
                                        decoration: BoxDecoration(
                                          color: widget.color,
                                          borderRadius:
                                              BorderRadius.circular(120),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        '${widget.metroRailModel.displayName} Line',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              color:
                                                  appSettingsController.isDark
                                                      ? Colors.white
                                                      : Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                            ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      SvgPicture.asset(
                                        'assets/directions_subway.svg',
                                        color: appSettingsController.isDark
                                            ? Colors.white
                                            : Colors.black,
                                        height: 17,
                                        width: 17,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        widget.metroRailStationsModel.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              color:
                                                  appSettingsController.isDark
                                                      ? Colors.white
                                                      : Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                            ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
    );
  }
}

class MyCustomExpansionTile extends StatefulWidget {
  final Widget title;
  final List<Widget> children;
  final MetroRailModel metroRailStationsModel;
  final Color colorSecond;
  final MetroRailStationsModel metroRailStationsModels;
  final Color color;
  final DeparturesModel directions;
  const MyCustomExpansionTile(
      {super.key,
      required this.title,
      required this.directions,
      required this.children,
      required this.colorSecond,
      required this.metroRailStationsModel,
      required this.metroRailStationsModels,
      required this.color});

  @override
  // ignore: library_private_types_in_public_api
  _MyCustomExpansionTileState createState() => _MyCustomExpansionTileState();
}

class _MyCustomExpansionTileState extends State<MyCustomExpansionTile> {
  bool isExpanded = false;
  int minutes = 0;

  @override
  Widget build(BuildContext context) {
    final AppSettingsController appSettingsController =
        Provider.of<AppSettingsController>(context);
    DateTime now = DateTime.now();
    // print(widget.directions.min + 'dd');
    int minutes = widget.directions.min == ''
        ? 0
        : widget.directions.min == 'ARR'
            ? 0
            : widget.directions.min == 'BRD'
                ? 0
                : int.parse(widget.directions.min);
    print(minutes);
    DateTime futureTime = now.add(Duration(minutes: minutes));
    String formattedTime = DateFormat.jm().format(futureTime);

    return InkWell(
      // onTap: () {
      // Get.to(() => MetroStopsUi(
      //       metroRailModel: widget.metroRailStationsModel,
      //       color: widget.color,
      //       directionsModel: widget.directions,
      //       secondColor: widget.colorSecond,
      //       metroRailStationsModel: widget.metroRailStationsModels,
      //     ));
      // },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: widget.color,
                        borderRadius: BorderRadius.circular(120),
                      ),
                      child: Center(
                        child: Container(
                          height: 28,
                          width: 28,
                          decoration: BoxDecoration(
                            color: widget.colorSecond,
                            borderRadius: BorderRadius.circular(120),
                          ),
                        ),
                      ),
                    ),
                    widget.title,
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      formattedTime,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: appSettingsController.isDark
                                ? Colors.white
                                : HexColor(colorBlack100),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },
                      child: Icon(
                        isExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        size: 21,
                        color: appSettingsController.isDark
                            ? Colors.white
                            : HexColor(colorBlack80),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (isExpanded) ...widget.children,
        ],
      ),
    );
  }
}
