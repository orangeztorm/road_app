import 'package:road_app/cores/__cores.dart';

class AssignTeamParam extends RequestParam {
  final String id;

  const AssignTeamParam(
    this.id,
  );

  @override
  Map<String, dynamic> toMap() {
    return {
      'potholeId': id,
      "status": "Scheduled",
    };
  }

  @override
  List<Object?> get props => [
        id,
      ];
}
