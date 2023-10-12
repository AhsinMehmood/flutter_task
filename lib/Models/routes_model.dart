class RouteModel {
  final String routeID;
  final String name;
  final String lineDescription;

  RouteModel({
    required this.routeID,
    required this.name,
    required this.lineDescription,
  });

  factory RouteModel.fromJson(Map<String, dynamic> json) {
    return RouteModel(
      routeID: json['RouteID'],
      name: json['Name'],
      lineDescription: json['LineDescription'] ?? '',
    );
  }
}
