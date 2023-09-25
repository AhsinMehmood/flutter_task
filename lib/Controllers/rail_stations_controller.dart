import 'package:flutter/material.dart';
import 'package:flutter_task/Models/metro_rail_stations_model.dart';

class MetroRailStationsController with ChangeNotifier {
  List<MetroRailStationsModel> _metroRailStations = [];
  List<MetroRailStationsModel> get metroRailStations {
    return [..._metroRailStations];
  }

  Future getMetroRailStations(
      {required List stationsList,
      required List stationsCustomOrderList}) async {
    final List stations = stationsList;

    List<MetroRailStationsModel> railStations = [];
    for (var element in stations) {
      railStations.add(MetroRailStationsModel.fromJson(element));
      // print(element);
    }

    List<MetroRailStationsModel> filterdList = railStations;

    // filterdList.sort((a, b) {
    //   final String nameA = a.name;
    //   final String nameB = b.name;
    //   final int indexA = stationsCustomOrderList.indexOf(nameA);
    //   final int indexB = stationsCustomOrderList.indexOf(nameB);

    //   return indexA.compareTo(indexB);
    // });
    _metroRailStations = filterdList;
    notifyListeners();
  }
}
