import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_task/Models/directions_model.dart';
import 'package:flutter_task/Models/metro_rail_stations_model.dart';
import 'package:http/http.dart' as http;

class DirectionsController with ChangeNotifier {
  List<DirectionsModel> _directions = [];
  List<DirectionsModel> get directions {
    return [..._directions];
  }

  Future getDirections(
      MetroRailStationsModel metroStation, String directionHeadingTo) async {
    final List stations = metroStation.directions.reversed.toList();

    // List<DirectionsModel> dd = railStations
    //     .where((element) => int.tryParse(element.min)! <= 7)
    //     .toList();

    List<DirectionsModel> railStations = [];
    for (var element in stations) {
      railStations.add(DirectionsModel.fromJson(element));
    }
    _directions = railStations.reversed.toList();
    notifyListeners();
  }
}
