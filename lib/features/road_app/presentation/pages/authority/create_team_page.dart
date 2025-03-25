import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:road_app/app/__app.dart';
import 'package:road_app/cores/__cores.dart';
import 'package:road_app/features/road_app/presentation/blocs/admin/all_teams_bloc/all_teams_bloc.dart';
import 'package:road_app/features/road_app/presentation/blocs/admin/create_team_bloc/create_team_bloc.dart';
import 'package:road_app/features/road_app/presentation/cubits/admin/all_teams_cubit.dart';
import 'package:road_app/features/road_app/presentation/cubits/admin/create_teams_cubit.dart';
import 'package:road_app/features/road_app/presentation/pages/authority/all_admins_page.dart';

class CreateTeamPage extends StatelessWidget {
  static const String routeName = '/create-team-page';
  const CreateTeamPage({super.key});

  static CreateTeamsCubit get createTeamsCubit => getIt<CreateTeamsCubit>();
  static CreateTeamBloc get createTeamBloc => getIt<CreateTeamBloc>();

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appBar: AppBar(
        centerTitle: true,
        title: const TextWidget.bold(
          'Create Team',
          fontSize: 22,
        ),
      ),
      body: BlocBuilder<CreateTeamsCubit, CreateTeamsFormzState>(
        bloc: createTeamsCubit,
        builder: (context, state) {
          return Column(
            children: [
              const VSpace(20),
              TextFieldWidget(
                hintText: 'Name',
                title: 'Team name',
                onChanged: createTeamsCubit.updateName,
              ),
              const VSpace(15),
              TextFieldWidget(
                hintText: 'Speciality',
                title: 'Team Speciality',
                onChanged: createTeamsCubit.updateSpeciality,
              ),
              const VSpace(16),
              TextFieldWidget(
                hintText: 'Region',
                title: 'Assigned Region',
                onChanged: createTeamsCubit.updateAssignedRegion,
              ),
              const VSpace(16),
              InkWell(
                onTap: () {
                  BottomSheetHelper.show(
                    context: context,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: sh(60),
                        minWidth: sw(100),
                      ),
                      child: const AllAdminsPage(),
                    ),
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.add),
                    const HSpace(),
                    TextWidget.bold(state.members.isEmpty
                        ? 'Select members'
                        : '${state.members.length} Members ${state.members.length > 1 ? '\'s' : ''} Selected'),
                  ],
                ),
              ),
              const VSpace(30),
              _buildButton(state.isValid),
            ],
          );
        },
      ),
    );
  }

  Widget _buildButton(active) {
    return BlocConsumer<CreateTeamBloc, CreateTeamState>(
      bloc: createTeamBloc,
      listener: _createTeamListener,
      builder: (context, state) {
        return state.status.isLoading
            ? const Button.loading()
            : Button(
                active: active,
                text: 'Create Team',
                onTap: () {
                  createTeamBloc.add(CreateTeam(createTeamsCubit.state));
                },
              );
      },
    );
  }

  void _createTeamListener(_, CreateTeamState state) {
    if (state.status.isFailure) {
      Toast.showError(state.failures?.message ?? AppStrings.somethingWentWrong);
    } else if (state.status.isSuccess) {
      Toast.showInfo('Team Created');
      final AllTeamsBloc allTeamsBloc = getIt<AllTeamsBloc>();
      final AllTeamsListCubit allTeamsListCubit = getIt<AllTeamsListCubit>();
      allTeamsListCubit.resetPage();
      allTeamsBloc.add(FetchAllTeams(allTeamsListCubit.state));
      createTeamsCubit.reset();
      AppRouter.instance.goBack();
    }
  }
}
