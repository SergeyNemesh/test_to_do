import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_to_do/data/repositories/auth_repository.dart';
import 'package:test_to_do/presentation/auth_bloc/auth_bloc.dart';
import 'package:test_to_do/presentation/unautorized/login/bloc/login_bloc.dart';
import 'package:test_to_do/presentation/unautorized/login/bloc/login_state.dart';
import 'package:test_to_do/widgets/input_field.dart';
import 'package:test_to_do/widgets/loading_button.dart';
import 'package:test_to_do/widgets/notification_dialogs.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginBloc _loginBloc;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loginBloc = LoginBloc(RepositoryProvider.of<AuthRepository>(context));
  }

  @override
  Widget build(BuildContext context) => BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) async {
          if (state.networkError != null) {
            await showNotificationDialog(context, 'Oops!', 'Something went wrong. Try again');
            return;
          }
          if (state.isSuccess) {
            await showNotificationDialog(context, 'Success!', 'User created!');
            context.read<AuthBloc>().userWasCreated();
          }
        },
        bloc: _loginBloc,
        builder: (context, state) => Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InputField(
                  label: 'Email',
                  controller: emailController,
                  errorText: state.emailError,
                  onChange: (email)=> _loginBloc.onEmailChange(email),
                ),
                SizedBox(height: 10.h),
                InputField(
                  label: 'Password',
                  controller: passwordController,
                  errorText: state.passwordError,
                  isPassword: true,
                  onChange: (password)=>_loginBloc.onPasswordChange(password),
                ),
                SizedBox(height: 20.h),
                LoadingButton(
                  title: 'Login as new user',
                  isLoading: state.isLoading,
                  onTap: () => _loginBloc.addUser(emailController.text, passwordController.text),
                ),
              ],
            ),
          ),
        ),
      );
}
