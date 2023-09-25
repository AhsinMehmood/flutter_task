class MetroRailModel {
  final String lineCode;
  final String displayName;
  final String startStationCode;
  final String endStationCode;
  final String internalDestination1;
  final String internalDestination2;
  final List stationsList;
  final List customOrderList;

  MetroRailModel({
    required this.lineCode,
    required this.stationsList,
    required this.customOrderList,
    required this.displayName,
    required this.startStationCode,
    required this.endStationCode,
    required this.internalDestination1,
    required this.internalDestination2,
  });

  factory MetroRailModel.fromJson(Map json) {
    return MetroRailModel(
      lineCode: json['LineCode'] ?? '',
      customOrderList: json['customOrderList'] ?? [],
      stationsList: json['stationsList'] ?? [],
      displayName: json['DisplayName'] ?? '',
      startStationCode: json['StartStationCode'] ?? '',
      endStationCode: json['EndStationCode'] ?? '',
      internalDestination1: json['InternalDestination1'] ?? '',
      internalDestination2: json['InternalDestination2'] ?? '',
    );
  }
}
