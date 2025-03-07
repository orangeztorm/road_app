import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:road_app/cores/__cores.dart';
import 'package:road_app/features/__features.dart';

class PotholeListCubit extends Cubit<PotholeListFormzState> {
  PotholeListCubit() : super(const PotholeListFormzState());

  void getInitialList(PotholeListBloc bloc) {
    resetPage();
    bloc.add(GetPotholes(state));
  }

  void getMoreList(PotholeListBloc bloc) {
    updateCurrentPage(state.currentPage + 1);
    bloc.add(GetMorePotholes(state));
  }

  void updateCurrentPage(int page) {
    emit(state.copyWith(currentPage: page));
  }

  void resetPage() {
    emit(const PotholeListFormzState());
  }
}

class PotholeListFormzState extends RequestParam {
  final int currentPage;

  const PotholeListFormzState({
    this.currentPage = 1,
  });

  PotholeListFormzState copyWith({
    int? currentPage,
  }) {
    return PotholeListFormzState(
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
