class MetroRailStationsModel {
  final String code;
  final String name;
  final String stationTogether1;
  final String stationTogether2;
  final String lineCode1;
  final String lineCode2;
  final String lineCode3;
  final String? lineCode4;
  final double lat;
  final double lon;
  final Address address;
  final List directions;

  MetroRailStationsModel({
    required this.code,
    required this.name,
    required this.stationTogether1,
    required this.stationTogether2,
    required this.lineCode1,
    required this.directions,
    required this.lineCode2,
    required this.lineCode3,
    this.lineCode4,
    required this.lat,
    required this.lon,
    required this.address,
  });

  factory MetroRailStationsModel.fromJson(Map<String, dynamic> json) {
    return MetroRailStationsModel(
      code: json['Code'] ?? '',
      name: json['Name'] ?? '',
      directions: json['directions'] ?? [],
      stationTogether1: json['StationTogether1'] ?? '',
      stationTogether2: json['StationTogether2'] ?? '',
      lineCode1: json['LineCode1'] ?? '',
      lineCode2: json['LineCode2'] ?? '',
      lineCode3: json['LineCode3'] ?? '',
      lineCode4: json['LineCode4'],
      lat: json['Lat']?.toDouble() ?? 0.0,
      lon: json['Lon']?.toDouble() ?? 0.0,
      address: Address.fromJson(json['Address'] ?? {}),
    );
  }
}

class Address {
  final String street;
  final String city;
  final String state;
  final String zip;

  Address({
    required this.street,
    required this.city,
    required this.state,
    required this.zip,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['Street'] ?? '',
      city: json['City'] ?? '',
      state: json['State'] ?? '',
      zip: json['Zip'] ?? '',
    );
  }
}
