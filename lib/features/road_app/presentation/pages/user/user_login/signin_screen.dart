import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:road_app/app/__app.dart';
import 'package:road_app/cores/__cores.dart';
import 'package:road_app/features/__features.dart';
import 'package:road_app/features/road_app/presentation/pages/user/notification_page.dart';

class SignInScreen extends StatelessWidget {
  static const String routeName = '/signin_screen';
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
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
          Container(
              padding: EdgeInsets.symmetric(horizontal: w(10), vertical: h(20)),
              decoration: const BoxDecoration(
                color: AppColor.kcWhite,
              ),
              child: const SignInForm())
        ],
      ),
    );
  }
}

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final UserSigninBloc _userSignInBloc = getIt<UserSigninBloc>();
  final UserSignInCubit _userSignInCubit = getIt<UserSignInCubit>();

  @override
  void initState() {
    _userSignInCubit.reset();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserSignInCubit, UserSignInFormzState>(
      bloc: _userSignInCubit,
      builder: (context, state) {
        return Column(
          children: [
            TextFieldWidget(
              hintText: 'Email',
              onChanged: _userSignInCubit.onEmailChanged,
            ),
            const VSpace(),
            TextFieldWidget(
              hintText: 'Password',
              onChanged: _userSignInCubit.onPasswordChanged,
              isPassword: true,
            ),
            const VSpace(),
            const Row(
              children: [
                // Row(
                //   children: [
                //     Checkbox(
                //       value: true,
                //       onChanged: (value) {},
                //       materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                //       visualDensity: VisualDensity.compact,
                //     ),
                //     const HSpace(),
                //     const TextWidget.bold('Remember me'),
                //   ],
                // ),
                Spacer(),
                // TextWidget.bold('Forgot Password?'),
              ],
            ),
            const VSpace(50),
            _buuildButton(),
          ],
        );
      },
    );
  }

  Widget _buuildButton() {
    return BlocConsumer<UserSigninBloc, UserSigninState>(
      bloc: _userSignInBloc,
      listener: _signupListener,
      builder: (context, state) {
        return state.status.isLoading
            ? const Button.loading()
            : Button(
                text: 'Login',
                active: _userSignInCubit.state.isValid,
                onTap: () {
                  _userSignInBloc.add(UserSignIn(_userSignInCubit.state));
                },
              );
      },
    );
  }

  void _signupListener(BuildContext context, UserSigninState state) {
    if (state.status.isSuccess) {
      AppRouter.instance.navigateTo(NotificationPage.routeName);
    } else if (state.status.isFailure) {
      Toast.showError(state.failure?.message ?? 'An error occured');
    }
  }
}
