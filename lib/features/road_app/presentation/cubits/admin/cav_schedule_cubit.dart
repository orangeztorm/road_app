import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:road_app/cores/__cores.dart';
import 'package:road_app/features/__features.dart';

class CavScheduleCubit extends Cubit<CavScheduleFormzState> {
  CavScheduleCubit() : super(const CavScheduleFormzState());

  void getInitialList(CavSchedulesBloc bloc) {
    bloc.add(GetCavSchedules(state));
  }

  void getMoreList(CavSchedulesBloc bloc) {
    updateCurrentPage(state.currentPage + 1);
    bloc.add(GetMoreCavSchedules(state));
  }

  void updateCurrentPage(int page) {
    emit(state.copyWith(currentPage: page));
  }

  void resetPage() {
    emit(const CavScheduleFormzState());
  }
}

class CavScheduleFormzState extends RequestParam {
  final int currentPage;

  const CavScheduleFormzState({
    this.currentPage = 1,
  });

  CavScheduleFormzState copyWith({
    int? currentPage,
  }) {
    return CavScheduleFormzState(
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  List<Object> get props => [currentPage];

  @override
  Map<String, dynamic> toMap() {
    return {
      'page': currentPage,
      'populate': 'pothole',
    };
  }
}
