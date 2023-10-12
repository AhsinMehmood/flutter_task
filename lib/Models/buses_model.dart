class BusesModel {
  final String vehicleID;
  final double lat;
  final double lon;
  final double deviation;
  bool isSelected = false;
  final String dateTime;
  final String tripID;
  final String routeID;
  final int directionNum;
  final String directionText;
  final String tripHeadsign;
  final String tripStartTime;
  final String tripEndTime;
  final String blockNumber;

  BusesModel({
    required this.vehicleID,
    required this.lat,
    required this.lon,
    required this.deviation,
    required this.dateTime,
    required this.tripID,
    required this.routeID,
    required this.directionNum,
    required this.directionText,
    required this.tripHeadsign,
    required this.tripStartTime,
    required this.tripEndTime,
    required this.blockNumber,
  });

  factory BusesModel.fromJson(Map<String, dynamic> json) {
    return BusesModel(
      vehicleID: json['VehicleID'] ?? '',
      lat: json['Lat'] ?? 0.0,
      lon: json['Lon'] ?? 0.0,
      deviation: json['Deviation'] ?? 0.0,
      dateTime: json['DateTime'] ?? '',
      tripID: json['TripID'] ?? '',
      routeID: json['RouteID'] ?? '',
      directionNum: json['DirectionNum'] ?? 0,
      directionText: json['DirectionText'] ?? '',
      tripHeadsign: json['TripHeadsign'] ?? '',
      tripStartTime: json['TripStartTime'] ?? '',
      tripEndTime: json['TripEndTime'] ?? '',
      blockNumber: json['BlockNumber'] ?? '',
    );
  }
}
