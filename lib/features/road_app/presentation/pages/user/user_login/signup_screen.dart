import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:road_app/app/__app.dart';
import 'package:road_app/cores/__cores.dart';
import 'package:road_app/features/__features.dart';

class SignUpScreen extends StatelessWidget {
  static const String routeName = '/signin_screen';
  const SignUpScreen({super.key});

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
            child: const SignupForm(),
          )
        ],
      ),
    );
  }
}

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final UserSignupBloc _userSignupBloc = getIt<UserSignupBloc>();
  final UserSignUpCubit _userSignupCubit = getIt<UserSignUpCubit>();

  @override
  void initState() {
    super.initState();
    _userSignupCubit.reset();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserSignUpCubit, UserSignUpFormzState>(
      bloc: _userSignupCubit,
      builder: (context, state) {
        return Column(
          children: [
            TextFieldWidget(
              hintText: 'First Name',
              onChanged: _userSignupCubit.onFirstnameChanged,
            ),
            const VSpace(),
            TextFieldWidget(
              hintText: 'Last Name',
              onChanged: _userSignupCubit.onLastnameChanged,
            ),
            const VSpace(),
            TextFieldWidget(
              hintText: 'Email',
              onChanged: _userSignupCubit.onEmailChanged,
            ),
            const VSpace(),
            TextFieldWidget(
              hintText: 'Password',
              onChanged: _userSignupCubit.onPasswordChanged,
            ),
            const VSpace(),
            const VSpace(50),
            _buildButton(),
          ],
        );
      },
    );
  }

  Widget _buildButton() {
    return BlocConsumer<UserSignupBloc, UserSignupState>(
      bloc: _userSignupBloc,
      listener: _signupListener,
      builder: (context, state) {
        return state.status.isLoading
            ? const Button.loading()
            : Button(
                text: 'SignUp',
                active: _userSignupCubit.state.isValid,
                onTap: () =>
                    _userSignupBloc.add(UserSignUp(_userSignupCubit.state)),
              );
      },
    );
  }

  void _signupListener(BuildContext context, UserSignupState state) {
    if (state.status.isFailure) {
      Toast.showError(state.failure?.message ?? 'An error occured');
    } else if (state.status.isSuccess) {
      BottomSheetHelper.show(
        context: context,
        child: SuccessBottomSheet(
          title: 'Success',
          message: 'You have successfully signed up',
          onContinue: () {
            AppRouter.instance.navigateToAndReplace(WelcomePage.routeName);
          },
        ),
      );
    }
  }
}

class SuccessBottomSheet extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onContinue;

  const SuccessBottomSheet({
    super.key,
    required this.title,
    required this.message,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(w(20)),
      decoration: const BoxDecoration(
        color: AppColor.kcWhite,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: h(60),
            width: h(60),
            decoration: const BoxDecoration(
              color: AppColor.kcSuccessColor,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check,
              color: AppColor.kcWhite,
              size: 30,
            ),
          ),
          VSpace(h(20)),
          Text(
            title,
            style: TextStyle(
              fontSize: sp(18),
              fontWeight: FontWeight.w600,
            ),
          ),
          VSpace(h(10)),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: sp(14),
              color: AppColor.kcGrey600,
            ),
          ),
          VSpace(h(30)),
          Button(
            text: 'Continue',
            onTap: () {
              Navigator.pop(context);
              onContinue();
            },
          ),
          VSpace(h(20)),
        ],
      ),
    );
  }
}
