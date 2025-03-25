import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:road_app/cores/__cores.dart';
import 'package:road_app/features/road_app/presentation/blocs/admin/all_admin_bloc/all_admin_bloc.dart';
// import 'package:road_app/features/__features.dart';

class AllAdminsListCubit extends Cubit<AllAdminsListFormzState> {
  AllAdminsListCubit() : super(const AllAdminsListFormzState());

  void getInitialList(AllAdminBloc bloc) {
    resetPage();
    bloc.add(FetchAllAdmins(state));
  }

  void getMoreList(AllAdminBloc bloc) {
    updateCurrentPage(state.currentPage + 1);
    bloc.add(FetchMoreAllAdmins(state));
  }

  void updateCurrentPage(int page) {
    emit(state.copyWith(currentPage: page));
  }

  void resetPage() {
    emit(const AllAdminsListFormzState());
  }
}

class AllAdminsListFormzState extends RequestParam {
  final int currentPage;

  const AllAdminsListFormzState({
    this.currentPage = 1,
  });

  AllAdminsListFormzState copyWith({
    int? currentPage,
  }) {
    return AllAdminsListFormzState(
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
