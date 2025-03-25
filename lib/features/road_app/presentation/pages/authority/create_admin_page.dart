import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:road_app/app/__app.dart';
import 'package:road_app/cores/__cores.dart';
import 'package:road_app/features/road_app/presentation/blocs/admin/create_admin_bloc/create_admin_bloc.dart';
import 'package:road_app/features/road_app/presentation/cubits/admin/create_admin_cubit.dart';

class CreateAdminPage extends StatelessWidget {
  const CreateAdminPage({super.key});

  static get createAdminCubit => getIt<CreateAdminCubit>();
  static get createAdminBloc => getIt<CreateAdminBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateAdminCubit, CreateAdminFormzState>(
      bloc: createAdminCubit,
      builder: (context, state) {
        print('fistname ${state.firstName.isValid}');
        print('lastname ${state.lastName.isValid}');
        print('email ${state.email.isValid}');
        print('password ${state.password.isValid}');
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const VSpace(20),
            const TextWidget.bold('Create Admin'),
            TextFieldWidget(
              hintText: 'First Name',
              title: 'First name',
              onChanged: createAdminCubit.updateFirstName,
            ),
            const VSpace(15),
            TextFieldWidget(
              hintText: 'Last Name',
              title: 'Last Name',
              onChanged: createAdminCubit.updatelastName,
            ),
            const VSpace(16),
            TextFieldWidget(
              hintText: 'Email',
              title: 'Email',
              onChanged: createAdminCubit.updateEmail,
            ),
            const VSpace(16),
            TextFieldWidget(
              hintText: 'Password',
              title: 'pasword',
              onChanged: createAdminCubit.updatePassword,
            ),
            const VSpace(30),
            _buildButton(state.isValid),
            const VSpace(30)
          ],
        );
      },
    );
  }

  Widget _buildButton(active) {
    return BlocConsumer<CreateAdminBloc, CreateAdminState>(
      bloc: createAdminBloc,
      listener: _createTeamListener,
      builder: (context, state) {
        return state.status.isLoading
            ? const Button.loading()
            : Button(
                active: active,
                text: 'Create Admin',
                onTap: () {
                  createAdminBloc.add(CreateAdmin(createAdminCubit.state));
                },
              );
      },
    );
  }

  void _createTeamListener(context, CreateAdminState state) {
    if (state.status.isFailure) {
      Toast.useContext(
          context: context,
          message: state.failures?.message ?? AppStrings.somethingWentWrong);
    } else if (state.status.isSuccess) {
      Toast.showInfo('Admin Created');
      createAdminCubit.reset();
      AppRouter.instance.goBack();
    }
  }
}
