import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_task/Controllers/directions_controller.dart';

import 'package:flutter_task/Models/metro_rail_model.dart';
import 'package:flutter_task/Models/metro_rail_stations_model.dart';
import 'package:flutter_task/ui/metro_stops_ui.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';

import '../Global/hex_color.dart';
import '../Models/directions_model.dart';

class DirectionsUi extends StatefulWidget {
  final MetroRailModel metroRailStationsModel;
  final Color colorSecond;
  final MetroRailStationsModel metroRailStationsModels;
  final Color color;
  const DirectionsUi(
      {super.key,
      required this.colorSecond,
      required this.metroRailStationsModel,
      required this.metroRailStationsModels,
      required this.color});

  @override
  State<DirectionsUi> createState() => _DirectionsUiState();
}

class _DirectionsUiState extends State<DirectionsUi> {
  bool _loading = true;
  List<DirectionsModel> _directionsFilter = [];

  String search = '';
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1)).then((value) async {
      await Provider.of<DirectionsController>(context, listen: false)
          .getDirections(widget.metroRailStationsModels,
              widget.metroRailStationsModels.name)
          .then((value) {
        setState(() {
          _loading = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final DirectionsController directionsController =
        Provider.of<DirectionsController>(context);
    return Scaffold(
      backgroundColor: Colors.white,
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
            padding: EdgeInsets.only(right: 15),
            child: Icon(
              Icons.search,
              color: Colors.black,
              size: 24,
            ),
          ),
        ],
        centerTitle: true,
        title: Text(
          'Directions',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
        ),
        backgroundColor: Colors.white,
        systemOverlayStyle: const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark,
          // systemNavigationBarDividerColor: null,
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 50,
            margin:
                const EdgeInsets.only(top: 10, bottom: 10, right: 20, left: 20),
            width: Get.width,
            decoration: BoxDecoration(
                color: Colors.white,
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
                    color: HexColor(colorBlack60),
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
                      _directionsFilter = directionsController.directions
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
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(0),
                      hintText: 'Search Metro Rail Directions...',
                      border: InputBorder.none,
                      hintStyle:
                          Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: HexColor(colorGrey80),
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
                          itemCount: _directionsFilter.length,
                          itemBuilder: (context, index) {
                            final directions = _directionsFilter[index];
                            return MyCustomExpansionTile(
                              metroRailStationsModel:
                                  widget.metroRailStationsModel,
                              color: widget.color,
                              directions: directions,
                              colorSecond: widget.colorSecond,
                              metroRailStationsModels:
                                  widget.metroRailStationsModels,
                              title: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      directions.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium!
                                          .copyWith(
                                              fontSize: 15,
                                              color: Colors.black),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
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
                                          '${widget.metroRailStationsModel.displayName} Line',
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
                              ),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
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
                                            widget.metroRailStationsModels.name,
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
                          },
                        )
                      : ListView.builder(
                          itemCount: directionsController.directions.length,
                          itemBuilder: (context, index) {
                            final directions =
                                directionsController.directions[index];
                            return MyCustomExpansionTile(
                              metroRailStationsModel:
                                  widget.metroRailStationsModel,
                              color: widget.color,
                              directions: directions,
                              colorSecond: widget.colorSecond,
                              metroRailStationsModels:
                                  widget.metroRailStationsModels,
                              title: Padding(
                                padding: const EdgeInsets.only(left: 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      directions.name,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium!
                                          .copyWith(
                                              fontSize: 15,
                                              color: Colors.black),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
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
                                          '${widget.metroRailStationsModel.displayName} Line',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
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
                                            widget.metroRailStationsModels.name,
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
                          },
                        ))
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
  final DirectionsModel directions;
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
    return InkWell(
      onTap: () {
        Get.to(() => MetroStopsUi(
              metroRailModel: widget.metroRailStationsModel,
              color: widget.color,
              directionsModel: widget.directions,
              secondColor: widget.colorSecond,
              metroRailStationsModel: widget.metroRailStationsModels,
            ));
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 40,
                      width: 47,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: widget.color,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          widget.directions.number,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                      ),
                    ),
                    widget.title,
                  ],
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
          ),
          if (isExpanded) ...widget.children,
        ],
      ),
    );
  }
}
