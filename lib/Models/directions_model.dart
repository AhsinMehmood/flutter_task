class DirectionsModel {
  final String name;
  final String number;

  DirectionsModel({
    required this.name,
    required this.number,
  });

  factory DirectionsModel.fromJson(Map<String, dynamic> json) {
    return DirectionsModel(
      name: json['name'],
      number: json['number'],
    );
  }
}
