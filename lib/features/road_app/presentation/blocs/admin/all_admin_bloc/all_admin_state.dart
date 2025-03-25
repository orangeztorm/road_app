part of 'all_admin_bloc.dart';

enum AllAdminStatus {
  initial,
  loading,
  loadMore,
  success,
  failure;

  bool get isInitial => this == AllAdminStatus.initial;
  bool get isLoading => this == AllAdminStatus.loading;
  bool get isLoadMore => this == AllAdminStatus.loadMore;
  bool get isSuccess => this == AllAdminStatus.success;
  bool get isFailure => this == AllAdminStatus.failure;
}

class AllAdminState extends Equatable {
  const AllAdminState({
    this.status = AllAdminStatus.initial,
    this.admins = const <AdminDocModel>[],
    this.hasReachedMax = false,
    this.failures,
  });

  final AllAdminStatus status;
  final List<AdminDocModel> admins;
  final bool hasReachedMax;
  final Failures? failures;

  factory AllAdminState.initial() => const AllAdminState();

  List<AdminDocModel> get loadingList => List.generate(
        5,
        (index) => AdminDocModel.empty(),
      );

  AllAdminState copyWith({
    AllAdminStatus? status,
    List<AdminDocModel>? admins,
    bool? hasReachedMax,
    Failures? failures,
  }) {
    return AllAdminState(
      status: status ?? this.status,
      admins: admins ?? this.admins,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      failures: failures,
    );
  }

  @override
  List<Object?> get props => [
        status,
        admins,
        hasReachedMax,
        failures,
      ];
}
