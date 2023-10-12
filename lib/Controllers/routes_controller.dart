import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_task/Api/routes_data.dart';
import 'package:flutter_task/Models/buses_model.dart';
import 'package:flutter_task/Models/poly_route_model.dart';
import 'package:flutter_task/Models/routes_model.dart';
import 'package:flutter_task/Widgets/map_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:ui' as ui;

import '../Widgets/custom_info_windo.dart';
import '../ui/select_multi_routes_ui.dart';

class RoutesController with ChangeNotifier {
  List<RouteModel> _routes = [];
  late GoogleMapController _mapController;
  GoogleMapController get mapController {
    return _mapController!;
  }

  initMapController(GoogleMapController controller) {
    _mapController = controller;
    notifyListeners();
  }

  late Uint8List markerArrowUp;
  late Uint8List markerArrowRight;
  late Uint8List markerArrowDown;
  late Uint8List markerArrowLeft;
  late Uint8List onTapArrowUp;
  late Uint8List onTapArrowRight;
  late Uint8List onTapArrowDown;
  late Uint8List onTapArrowLeft;
  int _selectedRouteOption = 3;
  int get selectedRouteOption {
    return _selectedRouteOption;
  }

  int _countdownValue = 30;
  bool _isCountingDown = false;
  Timer? _countdownTimer;
  bool _loading = false;
  bool get loading => _loading;
  changeLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  int get countdownValue => _countdownValue;
  bool get isCountingDown => _isCountingDown;
  int _lastUpdate = 0;
  int get lastUpdate => _lastUpdate;
  double get countdownPercentage => _countdownValue / 30.0;
  void startCountdown() async {
    if (!_isCountingDown) {
      _isCountingDown = true;
      _countdownTimer =
          Timer.periodic(const Duration(milliseconds: 1000), (timer) async {
        _lastUpdate++;
        if (_countdownValue > 1) {
          _countdownValue--;

          // 042111865865
        } else {
          _isCountingDown = false;
          getBuses(isRefresh: true);
          Fluttertoast.showToast(
              msg: "Update!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);

          // nyWMW5nw
          stopCountdown();
          // _countdownValue = 30;
        }
        notifyListeners();
      });
    }
  }

  void stopCountdown() {
    _isCountingDown = false;
    _countdownValue = 30;
    _countdownTimer?.cancel();
    notifyListeners();
  }

  final List _selectedRoutesIds = [];
  List get selectedRoutesIds {
    return [..._selectedRoutesIds];
  }

  filterBusesByMultiRoutes(List<BusesModel> busList,
      {splash = false, isRefresh = false}) {
    List<BusesModel> bbb = [];

    try {
      bbb = busList
          .where((element2) => _selectedRoutesIds.contains(element2.routeID))
          .toList();
      addMarkers(bbb);
      _buses = bbb;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
    if (!splash) {
      if (!isRefresh) {
        _mapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(bbb.first.lat, bbb.first.lon), zoom: 10)));
      }
    }
    notifyListeners();
  }

  filterSingleRoute(List<BusesModel> busList,
      {splash = false, isRefresh = false}) {
    List<BusesModel> bbb = [];
    bbb = busList
        .where((element) =>
            element.routeID == _selectedSingleRoute.split('-').first.trim())
        .toList();
    addMarkers(bbb);
    _buses = bbb;
    if (!splash) {
      if (!isRefresh) {
        _mapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(_buses.first.lat, _buses.first.lon), zoom: 11)));
      }
    }
    notifyListeners();
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  changeSelectedRouteOption(int value) {
    _selectedRouteOption = value;
    notifyListeners();
  }

  final List<Marker> _markers = [];
  List<Marker> get markers {
    return [..._markers];
  }

  String _polyGoneRouteId = '';
  String get polyGoneRouteId => _polyGoneRouteId;
  DateTime _updatedTime = DateTime.now();
  DateTime get updatedTime => _updatedTime;
  changePolyGoneRouteId(String routeId) {
    _polyGoneRouteId = routeId;

    notifyListeners();
  }

  Marker? _selectedMarker;

  Marker? get selectedMarker => _selectedMarker;
  final CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();
  CustomInfoWindowController get customInfoWindow =>
      _customInfoWindowController;
  void selectMarker(Marker marker) {
    _selectedMarker = marker;
    notifyListeners();
  }

  clearPolyLines() {
    _polylines.clear();
    // _customInfoWindowController.hideInfoWindow!();
    _polyGoneRouteId = '';
    notifyListeners();
  }

  void updateMarkerIcon(List<BusesModel> busesModel) {
    addMarkers(busesModel);
  }

  addMarkers(List<BusesModel> busesModel) {
    _markers.clear();

    for (BusesModel busModel in busesModel) {
      _markers.add(
        Marker(
            markerId: MarkerId(busModel.vehicleID + busModel.routeID),
            position: LatLng(
              busModel.lat,
              busModel.lon,
            ),
            onTap: () {
              _polylines.clear();
              if (_polyGoneRouteId == busModel.vehicleID + busModel.routeID) {
                // changePolyGoneRouteId('');
                _polyGoneRouteId = '';
                // _polylines.clear();
                _customInfoWindowController.hideInfoWindow!();
              } else {
                getRoutePolyData(busModel.routeID);
                // changePolyGoneRouteId(busModel.vehicleID + busModel.routeID);
                _polyGoneRouteId = busModel.vehicleID + busModel.routeID;
                _customInfoWindowController.addInfoWindow!(
                  Column(
                    children: [
                      Expanded(
                        child: CustomInfo(
                          busModel: busModel,
                        ),
                      ),
                      Triangle.isosceles(
                        edge: Edge.BOTTOM,
                        child: Container(
                          color: Colors.white,
                          width: 20.0,
                          height: 10.0,
                        ),
                      ),
                    ],
                  ),
                  LatLng(
                    busModel.lat,
                    busModel.lon,
                  ),
                );
              }
              updateMarkerIcon(busesModel);
            },
            icon: _polyGoneRouteId != busModel.vehicleID + busModel.routeID
                ? BitmapDescriptor.fromBytes(busModel.directionText == 'NORTH'
                    ? markerArrowUp
                    : busModel.directionText == 'EAST'
                        ? markerArrowRight
                        : busModel.directionText == 'SOUTH'
                            ? markerArrowDown
                            : busModel.directionText == 'WEST'
                                ? markerArrowLeft
                                : markerArrowUp)
                : BitmapDescriptor.fromBytes(busModel.directionText == 'NORTH'
                    ? onTapArrowUp
                    : busModel.directionText == 'EAST'
                        ? onTapArrowRight
                        : busModel.directionText == 'SOUTH'
                            ? onTapArrowDown
                            : busModel.directionText == 'WEST'
                                ? onTapArrowLeft
                                : onTapArrowLeft)),
      );
    }

    notifyListeners();
  }

  generateCustomMarker() async {
    markerArrowUp = await getBytesFromAsset(
        'assets/marker_arrow_up.png', Platform.isIOS ? 60 : 40);

    ///
    markerArrowRight = await getBytesFromAsset(
        'assets/marker_arrow_right.png', Platform.isIOS ? 60 : 40);
    markerArrowDown = await getBytesFromAsset(
        'assets/marker_arrow_down.png', Platform.isIOS ? 60 : 40);

    ///
    markerArrowLeft = await getBytesFromAsset(
        'assets/marker_arrow_left.png', Platform.isIOS ? 60 : 40);
    onTapArrowUp = await getBytesFromAsset(
        'assets/on_tap_arrow_up.png', Platform.isIOS ? 60 : 40);

    ///
    onTapArrowRight = await getBytesFromAsset(
        'assets/on_tap_arrow_right.png', Platform.isIOS ? 60 : 40);
    onTapArrowDown = await getBytesFromAsset(
        'assets/on_tap_arrow_down.png', Platform.isIOS ? 60 : 40);

    ///
    onTapArrowLeft = await getBytesFromAsset(
        'assets/on_tap_arrow_left.png', Platform.isIOS ? 60 : 40);
    notifyListeners();
  }

  List<BusesModel> _buses = [];
  List<BusesModel> get buses {
    return [..._buses];
  }

  List<RouteModel> _selectedRoutes = [];
  List<RouteModel> get selectedRoutes {
    return [..._selectedRoutes];
  }

  List<RouteModel> get routes {
    return [..._routes];
  }

  String _selectedSingleRoute = '';
  String get selectedSingleRoute {
    return _selectedSingleRoute;
  }

  changeSelectedSingleRoute(String routeId) {
    if (_selectedSingleRoute == routeId) {
      _selectedSingleRoute = '';
    } else {
      _selectedSingleRoute = routeId;
    }

    notifyListeners();
  }

  getBuses({splash = false, isFilter = false, isRefresh = false}) async {
    stopCountdown();
    changeLoading(true);
    if (!splash) {
      _customInfoWindowController.onCameraMove!();
    }
    try {
      List<BusesModel> busList = [];
      // if (!isFilter) {
      Uri uri = Uri.parse(
          'https://transit.jonathancelestin.com/transit/wmata_live.json');
      http.Response response = await http.get(uri);
      final json = jsonDecode(response.body);

      List jsonData = json['BusPositions'];
      for (var element in jsonData) {
        busList.add(BusesModel.fromJson(element));
      }
      // } else {
      //   busList = _buses;
      // }

      if (_selectedRouteOption == 1) {
        addMarkers(busList);
        _buses = busList;

        if (!splash) {
          if (!isRefresh) {
            _mapController.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(
                    target: LatLng(busList.first.lat, busList.first.lon),
                    zoom: 10)));
          }
        }
      } else if (_selectedRouteOption == 2) {
        filterBusesByMultiRoutes(busList, splash: splash, isRefresh: isRefresh);
      } else if (_selectedRouteOption == 3) {
        filterSingleRoute(busList, splash: splash, isRefresh: isRefresh);
      }
      if (splash) {
      } else {
        _countdownValue = 30;
        startCountdown();
      }

      _updatedTime = DateTime.now();
      _lastUpdate = 0;
      if (_selectedSingleRoute.isEmpty) {
        changeSelectedSingleRoute(_routes.first.name);
      }

      changeLoading(false);
      notifyListeners();
    } catch (e) {
      // print(e);
      changeLoading(false);
      if (splash) {
      } else {
        _countdownValue = 30;
        startCountdown();
        _updatedTime = DateTime.now();
        _lastUpdate = 0;
      }
    }
  }

  getRoutes() {
    List<RouteModel> routesList = [];
    // _selectedRoutes.clear();
    for (var element in routesData) {
      if (element['RouteID'].contains('*')) {
      } else if (element['RouteID'].contains('/')) {
      } else {
        routesList.add(RouteModel.fromJson(element));
      }
    }
    _routes = routesList;
    notifyListeners();
  }

  selectRoutes(RouteModel routeModel) {
    if (_selectedRoutes.contains(routeModel)) {
      _selectedRoutes.remove(routeModel);
      _selectedRoutesIds.remove(routeModel.name.split('-').first.trim());
    } else {
      if (_selectedRoutesIds.length >= 10) {
        Get.dialog(const ErrorDialoge2());
      } else {
        _selectedRoutes.add(routeModel);
        _selectedRoutesIds.add(routeModel.name.split('-').first.trim());
      }
    }

    notifyListeners();
  }

  late RouteData _routeData;
  RouteData get routePolyData {
    return _routeData;
  }

  getRoutePolyData(String routeId) async {
    http.Response response = await http.get(Uri.parse(
        'https://api.wmata.com/Bus.svc/json/jRouteDetails?api_key=844c2a6f10e4430c992d3188f8d591d9&RouteID=$routeId'));

    final json = jsonDecode(response.body);
    // print(json);
    Map<String, dynamic> polyLineData = json;
    RouteData route = RouteData.fromJson(polyLineData);
    _routeData = route;
    displayRoute(route);
    notifyListeners();
  }

  Set<Polyline> _polylines = {};
  Set<Polyline> get polyLines => _polylines;
  void displayRoute(RouteData routeData) async {
    List<LatLng> routeCoordinates = [];

// ignore: unused_local_variable
    for (Coordinate polyLinePoints in routeData.direction0.shape) {
      routeCoordinates.add(LatLng(polyLinePoints.lat, polyLinePoints.lon));
    }
    // Extract the route coordinates

    // Create a Polyline to display the route
    final Polyline routePolyline = Polyline(
      polylineId: PolylineId(routeData.routeID),
      width: 5,
      color: Colors.grey,
      points: routeCoordinates,
    );

    // Update the GoogleMap widget to include the route
    // setState(() {
    _polylines.add(routePolyline);
    notifyListeners();
    // _polylines(routePolyline);
    // });
  }
}
