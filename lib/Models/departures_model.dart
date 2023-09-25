class DeparturesModel {
  final String car;
  final String destination;
  final String destinationCode;
  final String destinationName;
  final String group;
  final String line;
  final String locationCode;
  final String locationName;
  final String min;

  DeparturesModel({
    required this.car,
    required this.destination,
    required this.destinationCode,
    required this.destinationName,
    required this.group,
    required this.line,
    required this.locationCode,
    required this.locationName,
    required this.min,
  });

  factory DeparturesModel.fromJson(Map<String, dynamic> json) {
    return DeparturesModel(
      car: json['Car'] ?? '',
      destination: json['Destination'] ?? '',
      destinationCode: json['DestinationCode'] ?? '',
      destinationName: json['DestinationName'] ?? '',
      group: json['Group'] ?? '',
      line: json['Line'] ?? '',
      locationCode: json['LocationCode'] ?? '',
      locationName: json['LocationName'] ?? '',
      min: json['Min'] ?? '',
    );
  }
}
