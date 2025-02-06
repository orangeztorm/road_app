import 'package:road_app/cores/__cores.dart';

class ConvertCurrencyModel {
  ConvertCurrencyModel({
    required this.status,
    required this.message,
    required this.data,
    required this.state,
  });

  final int status;
  final String message;
  final ConvertCurrencyData data;
  final String state;

  factory ConvertCurrencyModel.fromMap(Map<String, dynamic> json) =>
      ConvertCurrencyModel(
        status: json["status"],
        message: json["message"],
        data: ConvertCurrencyData.fromMap(json["data"]),
        state: json["state"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
        "state": state,
      };
}

class ConvertCurrencyData extends ConvertCurrencyEntity {
  const ConvertCurrencyData({
    required super.rate,
    required super.destinationAmount,
  });

  factory ConvertCurrencyData.fromMap(Map<String, dynamic> json) =>
      ConvertCurrencyData(
        rate: json["rate"],
        destinationAmount: json["destinationAmount"],
      );

  Map<String, dynamic> toJson() => {
        "rate": rate,
        "destinationAmount": destinationAmount,
      };
}
