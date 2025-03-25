import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:road_app/app/__app.dart';
import 'package:road_app/cores/__cores.dart';
import 'package:road_app/features/road_app/data/responses/admin/all_teams_model.dart';
import 'package:road_app/features/road_app/presentation/blocs/admin/all_teams_bloc/all_teams_bloc.dart';
import 'package:road_app/features/road_app/presentation/cubits/admin/all_teams_cubit.dart';
import 'package:road_app/features/road_app/presentation/cubits/admin/create_teams_cubit.dart';
import 'package:road_app/features/road_app/presentation/pages/authority/create_team_page.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TeamsPage extends StatefulWidget {
  static const String routeName = '/teams-admins';
  final bool returnBloc;
  final Function(AllTeamDocModel? doc)? onTap;
  const TeamsPage({super.key, this.returnBloc = false, this.onTap});

  @override
  State<TeamsPage> createState() => _TeamsPageState();
}

class _TeamsPageState extends State<TeamsPage> {
  final AllTeamsBloc _allTeamsBloc = getIt<AllTeamsBloc>();
  final AllTeamsListCubit _allTeamsListCubit = getIt<AllTeamsListCubit>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    getInitialData();
    _scrollController.addListener(checkIfEndReached);

    super.initState();
  }

  void checkIfEndReached() {
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels != 0) {
        // We are at the bottom of the list
        _allTeamsListCubit.getMoreList(_allTeamsBloc);
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void getInitialData() {
    _allTeamsListCubit.getInitialList(_allTeamsBloc);
  }

  @override
  Widget build(BuildContext context) {
    return widget.returnBloc == false
        ? ScaffoldWidget(
            appBar: AppBar(
              centerTitle: true,
              automaticallyImplyLeading: true,
              title: const TextWidget.bold(
                'Teams',
                fontSize: 22,
              ),
            ),
            useSingleScroll: false,
            body: _buildChild(),
          )
        : _buildChild();
  }

  Widget _buildChild() {
    return BlocBuilder<AllTeamsBloc, AllTeamsState>(
      bloc: _allTeamsBloc,
      builder: (context, state) {
        final loadingList = state.loadingList;
        final teamList = state.teams;
        return state.status.isLoading
            ? ListView.separated(
                padding: EdgeInsets.only(top: h(15)),
                itemBuilder: (context, index) => Skeletonizer(
                  enabled: state.status.isLoading,
                  child: _buildRow(loadingList[index]),
                ),
                separatorBuilder: (context, index) => const VSpace(10),
                itemCount: loadingList.length,
                shrinkWrap: true,
              )
            : state.status.isSuccess && teamList.isNotEmpty
                ? ListView.separated(
                    controller: _scrollController,
                    padding: EdgeInsets.only(top: h(15)),
                    itemBuilder: (context, index) {
                      if (index < (teamList.length)) {
                        return _buildRow(teamList[index]);
                      } else if (index == teamList.length) {
                        return state.status.isLoadMore
                            ? Padding(
                                padding: EdgeInsets.only(bottom: h(20)),
                                child: const Center(
                                  child: LoadingIndicatorWidget(),
                                ),
                              )
                            : const SizedBox.shrink();
                      } else {
                        return Padding(
                          padding: EdgeInsets.only(bottom: h(20)),
                          child: Center(
                            child: TextWidget(
                              state.status.isFailure
                                  ? state.failures?.message ??
                                      AppStrings.somethingWentWrong
                                  : state.hasReachedMax == false
                                      ? 'Pull To Load More'
                                      : 'No more data',
                              fontSize: 10,
                              textColor: AppColor.kcGrey800,
                            ),
                          ),
                        );
                      }
                    },
                    separatorBuilder: (context, index) => const VSpace(10),
                    itemCount: teamList.length + 2,
                    shrinkWrap: true,
                  )
                : state.status.isFailure
                    ? CustomErrorWidget(
                        callback: getInitialData,
                        useFlex: false,
                        message: state.failures?.message ??
                            AppStrings.somethingWentWrong,
                      )
                    : teamList.isEmpty
                        ? Column(
                            children: [
                              const VSpace(50),
                              const ImageWidget(
                                imageTypes: ImageTypes.asset,
                                imageUrl: "assets/logo.png",
                              ),
                              const VSpace(20),
                              const TextWidget.bold(
                                'No Teams Yet',
                                fontSize: 25,
                              ),
                              const VSpace(20),
                              Button(
                                text: 'Create Team',
                                onTap: () {
                                  getIt<CreateTeamsCubit>().reset();
                                  AppRouter.instance
                                      .navigateTo(CreateTeamPage.routeName);
                                },
                              ),
                            ],
                          )
                        : const SizedBox();
      },
    );
  }

  Widget _buildRow(AllTeamDocModel doc) {
    return InkWell(
      onTap: () {
        if (widget.onTap == null) return;
        widget.onTap?.call(doc);
        AppRouter.instance.goBack();
      },
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          TextWidget.light(doc.name ?? AppStrings.na),
          const Spacer(),
          TextWidget(doc.specialty ?? AppStrings.na)
        ],
      ),
    );
  }
}
