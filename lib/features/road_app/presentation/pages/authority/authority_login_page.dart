import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:road_app/app/locator.dart';
import 'package:road_app/cores/__cores.dart';
import 'package:road_app/features/__features.dart';
import 'package:road_app/features/road_app/presentation/pages/authority/cav_schedule_page.dart';

class AuthorityLoginPage extends StatelessWidget {
  static const String routeName = '/authority-login-page';
  const AuthorityLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appBar: AppBar(
        centerTitle: true,
        title: const TextWidget.bold(
          'Authority Login',
          fontSize: 22,
        ),
      ),
      bg: AppColor.colorF2F4F3,
      body: Column(
        children: [
          const VSpace(20),
          Container(
            height: h(150),
            width: w(150),
            decoration: const BoxDecoration(
              color: AppColor.kcBlack,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                '🛣️',
                style: TextStyle(fontSize: 90),
              ),
            ),
          ),
          const VSpace(20),
          const _AdminLoginForm(),
        ],
      ),
    );
  }
}

class _AdminLoginForm extends StatefulWidget {
  const _AdminLoginForm();

  @override
  State<_AdminLoginForm> createState() => __AdminLoginFormState();
}

class __AdminLoginFormState extends State<_AdminLoginForm> {
  final AdminLoginCubit _adminLoginCubit = getIt<AdminLoginCubit>();
  final AdminLoginBloc _adminLoginBloc = getIt<AdminLoginBloc>();

  @override
  void initState() {
    _adminLoginCubit.reset();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminLoginCubit, AdminLoginFormzState>(
      bloc: _adminLoginCubit,
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: w(10), vertical: h(20)),
          decoration: const BoxDecoration(
            color: AppColor.kcWhite,
          ),
          child: Column(
            children: [
              TextFieldWidget(
                hintText: 'Email',
                onChanged: _adminLoginCubit.onEmailChanged,
              ),
              const VSpace(),
              TextFieldWidget(
                hintText: 'Password',
                isPassword: true,
                onChanged: _adminLoginCubit.onPasswordChanged,
              ),
              const VSpace(),
              // Row(
              //   children: [
              //     Row(
              //       children: [
              //         Checkbox(
              //           value: _adminLoginCubit.state.rememberMe,
              //           onChanged: _adminLoginCubit.onRememberMeChanged,
              //           materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              //           visualDensity: VisualDensity.compact,
              //         ),
              //         const HSpace(),
              //         // const TextWidget.bold('Remember me'),
              //       ],
              //     ),
              //     const Spacer(),
              //     // const TextWidget.bold('Forgot Password?'),
              //   ],
              // ),
              const VSpace(50),
              _buildButton(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildButton() {
    return BlocConsumer<AdminLoginBloc, AdminLoginState>(
      bloc: _adminLoginBloc,
      listener: _adminLoginListener,
      builder: (context, state) {
        return state.status.isLoading
            ? const Button.loading()
            : Button(
                active: _adminLoginCubit.state.isValid,
                text: 'Login',
                onTap: () => _adminLoginCubit.adminLoginUser(_adminLoginBloc),
              );
      },
    );
  }

  void _adminLoginListener(BuildContext context, AdminLoginState state) {
    if (state.status == AdminLoginStatus.success) {
      AppRouter.instance.navigateTo(CavSchedulePage.routeName);
    } else if (state.status == AdminLoginStatus.failure) {
      Toast.showError(state.failure?.message ?? AppStrings.somethingWentWrong);
    }
  }
}
