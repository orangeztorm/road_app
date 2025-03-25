import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:road_app/cores/__cores.dart';
import 'package:road_app/features/road_app/data/responses/admin/all_admin_model.dart';

class CreateTeamsCubit extends Cubit<CreateTeamsFormzState> {
  CreateTeamsCubit() : super(const CreateTeamsFormzState());

  void updateName(String? name) {
    emit(state.copyWith(name: Required.dirty(name ?? '')));
  }

  void updateAssignedRegion(String? val) {
    emit(state.copyWith(assignedRegion: Required.dirty(val ?? '')));
  }

  void updateSpeciality(String? val) {
    emit(state.copyWith(specialty: Required.dirty(val ?? '')));
  }

  void addOrRemoveMember(AdminDocModel id) {
    final List<AdminDocModel> list =
        List<AdminDocModel>.from(state.members); // Create a modifiable copy

    if (state.containAdmin(id)) {
      list.removeWhere((member) => member == id);
    } else {
      list.add(id);
    }

    emit(state.copyWith(members: list)); // Emit the new list
  }

  void reset() {
    emit(const CreateTeamsFormzState());
  }
}

class CreateTeamsFormzState extends RequestParam {
  final Required name;
  final Required specialty;
  final Required assignedRegion;
  final List<AdminDocModel> members;

  const CreateTeamsFormzState({
    this.name = const Required.pure(),
    this.specialty = const Required.pure(),
    this.assignedRegion = const Required.pure(),
    this.members = const [],
  });

  CreateTeamsFormzState copyWith({
    Required? name,
    Required? specialty,
    Required? assignedRegion,
    List<AdminDocModel>? members,
  }) {
    return CreateTeamsFormzState(
      name: name ?? this.name,
      specialty: specialty ?? this.specialty,
      assignedRegion: assignedRegion ?? this.assignedRegion,
      members: members ?? this.members,
    );
  }

  bool get isValid {
    return name.isValid &&
        specialty.isValid &&
        assignedRegion.isValid &&
        members.isNotEmpty;
  }

  bool containAdmin(AdminDocModel doc) {
    return members.any(
      (element) => element.id == doc.id,
    );
  }

  @override
  String toString() {
    return 'CreateTeamsFormzState(name: $name, specialty: $specialty, assignedRegion: $assignedRegion, members: $members)';
  }

  @override
  List<Object?> get props => [name, specialty, members, assignedRegion];

  @override
  Map<String, dynamic> toMap() {
    return {
      "name": name.value,
      "specialty": specialty.value,
      "assigned_region": assignedRegion.value,
      "members": members.map((e) => e.id).toList()
    };
  }
}
