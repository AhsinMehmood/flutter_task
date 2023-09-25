import 'package:flutter/material.dart';
import 'package:flutter_task/Controllers/departures_controller.dart';
import 'package:flutter_task/Global/hex_color.dart';
import 'package:flutter_task/Models/departures_model.dart';
import 'package:flutter_task/Models/directions_model.dart';
import 'package:flutter_task/Models/metro_rail_stations_model.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';

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
    Future.delayed(const Duration(microseconds: 10)).then((value) {
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

  @override
  Widget build(BuildContext context) {
    final DeparturesController departuresController =
        Provider.of<DeparturesController>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(10),
            child: Icon(
              Icons.search,
              color: Colors.black,
              size: 24,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Icon(
              Icons.favorite_border_outlined,
              color: Colors.black,
              size: 24,
            ),
          ),
        ],
        title: Text(
          'Departures',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        bottom: PreferredSize(
            preferredSize: Size(Get.width, 50),
            child: Container(
              color: HexColor(colorPurple),
              height: 50,
              child: Center(
                child: Text(
                  widget.metroRailStationsModel.name,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(fontSize: 15, color: Colors.white),
                ),
              ),
            )),
      ),
      backgroundColor: Colors.white,
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : departuresController.departures.isEmpty
              ? LiquidPullToRefresh(
                  backgroundColor: Colors.white,
                  color: HexColor(colorPurple),
                  onRefresh: () async {
                    await departuresController.getDepartures(
                        widget.directionsModel.name,
                        widget.metroRailStationsModel.code,
                        widget.metroRailStationsModel.lineCode1);
                  },
                  child: ListView(
                    // shrinkWrap: true,
                    // physics: NeverScrollableScrollPhysics(),
                    children: [
                      Column(
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
                    ],
                  ),
                )
              : LiquidPullToRefresh(
                  backgroundColor: Colors.white,
                  color: HexColor(colorPurple),
                  showChildOpacityTransition: false,
                  onRefresh: () async {
                    await departuresController.getDepartures(
                        widget.directionsModel.name,
                        widget.metroRailStationsModel.code,
                        widget.metroRailStationsModel.lineCode1);
                  },
                  child: ListView.builder(
                      itemCount: departuresController.departures.length,
                      itemBuilder: (context, index) {
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
                                departuresModel.destinationName,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                        color: Colors.black),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    departuresModel.min == 'ARR'
                                        ? 'Arriving'
                                        : departuresModel.min == 'BRD'
                                            ? 'Boarding'
                                            : '${departuresModel.min} min',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: Colors.black,
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
                                              color: Colors.black,
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
                                      Image.asset(
                                        'assets/directions_subway.png',
                                        color: Colors.black,
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
                                              color: Colors.black,
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
                      }),
                ),
    );
  }

  cardUi(DeparturesModel directions) {
    return InkWell(
      child: Container(
        margin: const EdgeInsets.only(top: 15, left: 10, right: 10),
        child: ExpansionTile(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          collapsedBackgroundColor: Colors.white,
          backgroundColor: Colors.white,
          collapsedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          childrenPadding: const EdgeInsets.all(0),
          title: Text(
            directions.destinationName,
            style: GoogleFonts.nunito(
              color: Colors.black,
              fontSize: 12,
            ),
          ),
          leading: Container(
            height: 45,
            width: 45,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: BorderRadius.circular(120),
            ),
            child: Center(
              child: Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  color: widget.secondColor,
                  borderRadius: BorderRadius.circular(120),
                ),
              ),
            ),
          ),
          subtitle: Text(
            directions.min != 'ARR'
                ? '${directions.min} min'
                : directions.min == 'BRD'
                    ? 'Boarding'
                    : 'Arriving',
            style: GoogleFonts.nunito(
              color: Colors.black,
              fontSize: 12,
            ),
          ),
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 15,
                    ),
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
                            color: Colors.black,
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
                    Image.asset(
                      'assets/directions_subway.png',
                      color: Colors.black,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      directions.locationName,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.black,
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
            )
          ],
        ),
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

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    int minutes = widget.directions.min == 'ARR'
        ? 0
        : widget.directions.min == 'BRD'
            ? 0
            : int.parse(widget.directions.min);
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
                            color: Colors.black,
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
