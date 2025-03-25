part of 'all_teams_bloc.dart';

enum AllTeamsStatus {
  initial,
  loading,
  loadMore,
  success,
  failure;

  bool get isInitial => this == AllTeamsStatus.initial;
  bool get isLoading => this == AllTeamsStatus.loading;
  bool get isLoadMore => this == AllTeamsStatus.loadMore;
  bool get isSuccess => this == AllTeamsStatus.success;
  bool get isFailure => this == AllTeamsStatus.failure;
}

class AllTeamsState extends Equatable {
  const AllTeamsState({
    this.status = AllTeamsStatus.initial,
    this.teams = const <AllTeamDocModel>[],
    this.hasReachedMax = false,
    this.failures,
  });

  final AllTeamsStatus status;
  final List<AllTeamDocModel> teams;
  final bool hasReachedMax;
  final Failures? failures;

  factory AllTeamsState.initial() => const AllTeamsState();

  AllTeamsState copyWith({
    AllTeamsStatus? status,
    List<AllTeamDocModel>? teams,
    bool? hasReachedMax,
    Failures? failures,
  }) {
    return AllTeamsState(
      status: status ?? this.status,
      teams: teams ?? this.teams,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      failures: failures,
    );
  }

  List<AllTeamDocModel> get loadingList => List.generate(
        5,
        (index) => AllTeamDocModel.empty(),
      );

  @override
  List<Object?> get props => [
        status,
        teams,
        hasReachedMax,
        failures,
      ];
}
