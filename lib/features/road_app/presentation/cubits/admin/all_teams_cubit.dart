import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:road_app/cores/__cores.dart';
import 'package:road_app/features/road_app/presentation/blocs/admin/all_teams_bloc/all_teams_bloc.dart';
// import 'package:road_app/features/__features.dart';

class AllTeamsListCubit extends Cubit<AllTeamsListFormzState> {
  AllTeamsListCubit() : super(const AllTeamsListFormzState());

  void getInitialList(AllTeamsBloc bloc) {
    resetPage();
    bloc.add(FetchAllTeams(state));
  }

  void getMoreList(AllTeamsBloc bloc) {
    updateCurrentPage(state.currentPage + 1);
    bloc.add(FetchMoreAllTeams(state));
  }

  void updateCurrentPage(int page) {
    emit(state.copyWith(currentPage: page));
  }

  void resetPage() {
    emit(const AllTeamsListFormzState());
  }
}

class AllTeamsListFormzState extends RequestParam {
  final int currentPage;

  const AllTeamsListFormzState({
    this.currentPage = 1,
  });

  AllTeamsListFormzState copyWith({
    int? currentPage,
  }) {
    return AllTeamsListFormzState(
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  List<Object> get props => [currentPage];

  @override
  Map<String, dynamic> toMap() {
    return {
      'page': currentPage,
    };
  }
}
