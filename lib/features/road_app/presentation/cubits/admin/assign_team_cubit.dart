// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:road_app/cores/__cores.dart';

class AssignTeamCubit extends Cubit<AssignTeamFormzState> {
  AssignTeamCubit() : super(const AssignTeamFormzState());

  void updatePotholeId(String? name) {
    emit(state.copyWith(potholdId: Required.dirty(name ?? '')));
  }

  void updateTeamId(String? val) {
    emit(state.copyWith(teamId: Required.dirty(val ?? '')));
  }

  void reset() {
    emit(const AssignTeamFormzState());
  }
}

class AssignTeamFormzState extends RequestParam {
  final Required potholdId;
  final Required teamId;

  const AssignTeamFormzState({
    this.potholdId = const Required.pure(),
    this.teamId = const Required.pure(),
  });

  @override
  Map<String, dynamic> toMap() {
    return {"teamId": teamId.value};
  }

  bool get isValid => potholdId.isValid && teamId.isValid;

  @override
  List<Object?> get props => [
        potholdId,
        teamId,
      ];

  AssignTeamFormzState copyWith({
    Required? potholdId,
    Required? teamId,
  }) {
    return AssignTeamFormzState(
      potholdId: potholdId ?? this.potholdId,
      teamId: teamId ?? this.teamId,
    );
  }
}
