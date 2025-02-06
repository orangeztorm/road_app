import '../../domain/entities/get_nigeria_bank_entity.dart';

class GetNigeriaBankModel extends GetNigeriaBankEntity {
  const GetNigeriaBankModel({
    required super.message,
    required super.banks,
    required super.status,
    required super.state,
  });

  factory GetNigeriaBankModel.fromMap(Map<String, dynamic> json) {
    if (json["data"] is! List?) {
      throw ArgumentError(
        "Missing required field(s) in GetNigeriaBankModel: 'data'",
      );
    }

    return GetNigeriaBankModel(
      message: json["message"] ?? "N/A",
      banks: () {
        if (json["data"] != null) {
          return List<NigeriaBankModel>.from(
            json["data"].map((x) => NigeriaBankModel.fromMap(x)),
          );
        }

        return <NigeriaBankModel>[];
      }(),
      status: json["status"] ?? 0,
      state: json["state"] ?? "N/A",
    );
  }
}

class NigeriaBankModel extends NigeriaBankEntity {
  const NigeriaBankModel({
    required super.bankName,
    required super.bankCode,
    required super.image,
  });

  factory NigeriaBankModel.fromMap(Map<String, dynamic> json) {
    return NigeriaBankModel(
      bankName: json["bankName"] ?? "N/A",
      bankCode: json["bankCode"] ?? "N/A",
      image: json["image"] ?? "N/A",
    );
  }

  Map<String, dynamic> toMap() {
    return {"bankName": bankName, "bankCode": bankCode, "image": image};
  }
}
