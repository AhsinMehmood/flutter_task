import 'dart:convert';
import 'dart:io';
// import 'package:file_saver/file_saver.dart';
import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';

Future<List<String>> fetchRouteIDs() async {
  final response = await http.get(
    Uri.parse(
        "https://api.wmata.com/Bus.svc/json/jRoutes?api_key=844c2a6f10e4430c992d3188f8d591d9"),
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    final List<String> routeIDs = [];
    for (var route in data['Routes']) {
      if (route['RouteID'].contains('*')) {
        print('object');
      } else if (route['RouteID'].contains('/')) {
      } else {
        routeIDs.add(route['RouteID']);
      }
    }
    return routeIDs;
  } else {
    throw Exception('Failed to fetch route IDs');
  }
}

Future<void> fetchAndSaveRouteDetails(List<String> routeIDs) async {
  try {
    // final directory = await getApplicationDocumentsDirectory();
    for (var routeID in routeIDs) {
      final response = await http.get(
        Uri.parse(
            "https://api.wmata.com/Bus.svc/json/jRouteDetails?api_key=844c2a6f10e4430c992d3188f8d591d9&RouteID=$routeID"),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final fileName = 'route_$routeID.json';
        final filePath = '/Users/a1APPLE/Downloads/bnc_routes/$fileName';

        final file = File(filePath);
        await file.writeAsString(json.encode(data), flush: true);
        print(file.path);
        // await FileSaver.instance.saveAs(
        //     name: fileName,
        //     file: file,
        //     filePath: filePath,
        //     ext: 'json',
        //     mimeType: MimeType.json);
      } else {
        print('Failed to fetch route details for route $routeID');
      }
    }
  } catch (e) {
    print(e);
  }
}
