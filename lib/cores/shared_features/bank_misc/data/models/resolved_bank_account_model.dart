import '../../domain/entities/resolved_bank_account_entity.dart';

class ResolveBankModel extends ResolveBankEntity {
  const ResolveBankModel({
    required super.message,
    required super.data,
    required super.status,
    required super.state,
  });

  factory ResolveBankModel.fromMap(Map<String, dynamic> json) {
    if (json["data"] is! Map<String, dynamic>) {
      throw ArgumentError("data must be a Map<String, dynamic>");
    }

    return ResolveBankModel(
      message: json["message"] ?? "N/A",
      data: ResolveBankData.fromMap(json["data"]),
      status: json["status"] ?? 0,
      state: json["state"] ?? "N/A",
    );
  }
}

class ResolveBankData extends ResolveBankDataEntity {
  const ResolveBankData({
    required super.accountNumber,
    required super.accountName,
    required super.bankCode,
  });

  factory ResolveBankData.fromMap(Map<String, dynamic> json) {
    return ResolveBankData(
      accountNumber: json["accountNumber"] ?? "N/A",
      accountName: json["accountName"] ?? "N/A",
      bankCode: json["bankCode"] ?? "N/A",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "accountNumber": accountNumber,
      "accountName": accountName,
      "bankCode": bankCode,
    };
  }
}
