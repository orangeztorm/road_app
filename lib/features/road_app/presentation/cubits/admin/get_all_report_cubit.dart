import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:road_app/cores/__cores.dart';

class GetAllReportsCubit extends Cubit<GetAllReportsFormState> {
  GetAllReportsCubit() : super(GetAllReportsFormState.initial());

  void onQueryChanged(String query) {
    emit(
      state.copyWith(
        query: Required.dirty(query),
      ),
    );
  }

  void onPageChanged(num page) {
    emit(
      state.copyWith(
        page: RequiredNum.dirty(page.toDouble()),
      ),
    );
  }

  void reset() {
    emit(GetAllReportsFormState.initial());
  }
}

class GetAllReportsFormState extends RequestParam with FormzMixin {
  final Required query;
  final RequiredNum page;

  const GetAllReportsFormState({
    this.query = const Required.pure(),
    this.page = const RequiredNum.pure(1),
  });

  factory GetAllReportsFormState.initial() {
    return const GetAllReportsFormState();
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      if (query.isValid && query.value.toString().isNotEmpty)
        "search": query.value.toString().replaceAll('+', ''),
      "page": page.value,
      "populate": "vendorId",
    };
  }

  GetAllReportsFormState copyWith({
    Required? query,
    RequiredNum? page,
  }) {
    return GetAllReportsFormState(
      query: query ?? this.query,
      page: page ?? this.page,
    );
  }

  @override
  List<Object?> get props => [
        query,
        page,
      ];

  @override
  List<FormzInput> get inputs => [
        query,
        page,
      ];
}
