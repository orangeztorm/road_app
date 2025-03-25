import 'package:road_app/cores/__cores.dart';

class AssignTeamParam extends RequestParam {
  final String id;
  final String teamId;

  const AssignTeamParam(
    this.id,
    this.teamId,
  );

  @override
  Map<String, dynamic> toMap() {
    return {
      'potholeId': id,
      'teamId': teamId,
      "status": "Scheduled",
    };
  }

  @override
  List<Object?> get props => [
        id,
      ];
}
