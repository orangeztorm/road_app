import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:road_app/cores/__cores.dart';

class UserPotholeListCubit extends Cubit<UserPotholeListFormzState> {
  UserPotholeListCubit() : super(const UserPotholeListFormzState());

  // void getInitialList(UserPotholeListsBloc bloc) {
  //   bloc.add(GetUserPotholeLists(state));
  // }

  // void getMoreList(UserPotholeListsBloc bloc) {
  //   updateCurrentPage(state.currentPage + 1);
  //   bloc.add(GetMoreUserPotholeLists(state));
  // }

  void updateCurrentPage(int page) {
    emit(state.copyWith(currentPage: page));
  }

  void resetPage() {
    emit(const UserPotholeListFormzState());
  }
}

class UserPotholeListFormzState extends RequestParam {
  final int currentPage;

  const UserPotholeListFormzState({
    this.currentPage = 0,
  });

  UserPotholeListFormzState copyWith({
    int? currentPage,
  }) {
    return UserPotholeListFormzState(
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
