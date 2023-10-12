class RouteData {
  final String routeID;
  final String name;
  final Direction direction0;
  // final Direction direction1;

  RouteData({
    required this.routeID,
    required this.name,
    required this.direction0,
    // required this.direction1,
  });

  factory RouteData.fromJson(Map<String, dynamic> json) {
    // Map<String, dynamic> jsons = json['Direction1'] ?? {};
    return RouteData(
      routeID: json['RouteID'],
      name: json['Name'],
      direction0: Direction.fromJson(json['Direction0']),
      // direction1: Direction.fromJson(jsons),
    );
  }
}

class Direction {
  final String tripHeadsign;
  final String directionText;
  final String directionNum;
  final List<Coordinate> shape;
  final List<Stop> stops;

  Direction({
    required this.tripHeadsign,
    required this.directionText,
    required this.directionNum,
    required this.shape,
    required this.stops,
  });

  factory Direction.fromJson(Map<String, dynamic> json) {
    return Direction(
      tripHeadsign: json['TripHeadsign'] ?? '',
      directionText: json['DirectionText'] ?? '',
      directionNum: json['DirectionNum'] ?? '',
      shape: List<Coordinate>.from(
          json['Shape'].map((x) => Coordinate.fromJson(x))),
      stops: List<Stop>.from(json['Stops'].map((x) => Stop.fromJson(x))),
    );
  }
}

class Coordinate {
  final double lat;
  final double lon;
  final int seqNum;

  Coordinate({
    required this.lat,
    required this.lon,
    required this.seqNum,
  });

  factory Coordinate.fromJson(Map<String, dynamic> json) {
    return Coordinate(
      lat: json['Lat'],
      lon: json['Lon'],
      seqNum: json['SeqNum'],
    );
  }
}

class Stop {
  final String stopID;
  final String name;
  final double lon;
  final double lat;
  final List<String> routes;

  Stop({
    required this.stopID,
    required this.name,
    required this.lon,
    required this.lat,
    required this.routes,
  });

  factory Stop.fromJson(Map<String, dynamic> json) {
    return Stop(
      stopID: json['StopID'],
      name: json['Name'],
      lon: json['Lon'],
      lat: json['Lat'],
      routes: List<String>.from(json['Routes'].map((x) => x)),
    );
  }
}
