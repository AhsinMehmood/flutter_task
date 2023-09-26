import 'package:flutter/material.dart';
import 'package:flutter_task/Models/departures_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DeparturesController with ChangeNotifier {
  List<DeparturesModel> _departures = [];
  List<DeparturesModel> get departures {
    return [..._departures];
  }

  Future getDepartures(
      String startStationCode, String destinationCode, String line) async {
    print(line);
    print(startStationCode);
    String url =
        'https://api.wmata.com/StationPrediction.svc/json/GetPrediction/$destinationCode?api_key=844c2a6f10e4430c992d3188f8d591d9';
    print(url);
    try {
      http.Response response = await http.get(Uri.parse(url));
      print(response.body);
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final List stations = jsonResponse['Trains'];
        List<DeparturesModel> railStations = [];
        // Create a Set to store unique "Min" values
        Set<String> uniqueMinValues = {};

        // Filter the data to show only unique "Min" values
        List filteredData = [];

        Map<String, Map<String, dynamic>> uniqueItems = {};
        for (var item in stations) {
          final key = '${item['DestinationName']}-${item['Min']}';
          uniqueItems[key] = item;
        }

        List result = uniqueItems.values.toList();

        for (final item in result) {
          print(item['Min']);
          // if (item['Min'] == '') {}
          if (startStationCode == 'New Carrollton') {
            if (item['DestinationName'] == 'N Carrollton' ||
                item['DestinationName'] == 'New Carrollton' &&
                    item['Line'] == line) {
              railStations.add(DeparturesModel.fromJson(item));
              // }
            }
          } else if (startStationCode ==
              'Mt Vernon Sq 7th St-Convention Center') {
            if (item['DestinationName'] == 'Mt Vern Sq' ||
                item['DestinationName'] ==
                        'Mt Vernon Sq 7th St-Convention Center' &&
                    item['Line'] == line) {
              railStations.add(DeparturesModel.fromJson(item));
              // }
            }
          } else {
            if (item['DestinationName'] == startStationCode &&
                item['Line'] == line) {
              railStations.add(DeparturesModel.fromJson(item));
              // }
            }
          }
        }
        railStations.removeWhere((element) => element.min == '');
        // print(railStations.length);
        _departures = railStations;
        uniqueMinValues.clear();
        // print(_departures.length);
        // List<DeparturesModel> filterMinute = dep
        //     .where((element) => element.destinationName == destination)
        //     .toList();
        // print(destination);
        // _departures = dep;
        notifyListeners();
      }
    } catch (e) {
      print('object $e');
    }
  }
}
