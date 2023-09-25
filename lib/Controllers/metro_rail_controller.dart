import 'package:flutter/material.dart';
import 'package:flutter_task/Api/blue_line_api.dart';
import 'package:flutter_task/Api/green_line_api.dart';
import 'package:flutter_task/Api/oranage_line_api.dart';
import 'package:flutter_task/Api/red_line_api.dart';
import 'package:flutter_task/Api/silver_line_api.dart';
import 'package:flutter_task/Api/yellow_line_api.dart';
import 'package:flutter_task/Models/metro_rail_model.dart';

class MetroRailController with ChangeNotifier {
  List<MetroRailModel> _metroRails = [];
  List<MetroRailModel> get metroRails {
    return [..._metroRails];
  }

  Future getMetroRails() async {
    List<MetroRailModel> metroRailss = [];

    for (var element in metroLines) {
      metroRailss.add(MetroRailModel.fromJson(element));
    }
    _metroRails = metroRailss;
    notifyListeners();
  }

  List metroLines = [
    {
      "LineCode": "BL",
      "DisplayName": "Blue",
      "StartStationCode": "J03",
      "EndStationCode": "G05",
      "InternalDestination1": "",
      "InternalDestination2": "",
      'stationsList': blueLineStations,
      'customOrderList': blueLineStationsCustomOrder,
    },
    {
      "LineCode": "GR",
      "DisplayName": "Green",
      "StartStationCode": "F11",
      "EndStationCode": "E10",
      "InternalDestination1": "",
      "InternalDestination2": "",
      'stationsList': greenLineStations,
      'customOrderList': greenLineStationsCustomOrderList,
    },
    {
      "LineCode": "OR",
      "DisplayName": "Orange",
      "StartStationCode": "K08",
      "EndStationCode": "D13",
      "InternalDestination1": "",
      "InternalDestination2": "",
      'stationsList': orangeLineStations,
      'customOrderList': orangeLineStationsCustomOrderList,
    },
    {
      "LineCode": "RD",
      "DisplayName": "Red",
      "StartStationCode": "A15",
      "EndStationCode": "B11",
      "InternalDestination1": "A11",
      "InternalDestination2": "B08",
      'stationsList': redLineStations,
      'customOrderList': redLineStationsCustomOrderList,
    },
    {
      "LineCode": "SV",
      "DisplayName": "Silver",
      "StartStationCode": "N06",
      "EndStationCode": "G05",
      "InternalDestination1": "",
      "InternalDestination2": "",
      'stationsList': silverLineStations,
      'customOrderList': silverLineStationsCustomOrderList,
    },
    {
      "LineCode": "YL",
      "DisplayName": "Yellow",
      "StartStationCode": "C15",
      "EndStationCode": "E06",
      "InternalDestination1": "E01",
      "InternalDestination2": "",
      'stationsList': yellowLineStations,
      'customOrderList': yellowLineStationsCustomOrderList,
    },
  ];
}
