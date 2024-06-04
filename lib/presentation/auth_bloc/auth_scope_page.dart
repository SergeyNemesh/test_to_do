import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_to_do/presentation/auth_bloc/auth_bloc.dart';
import 'package:test_to_do/presentation/auth_bloc/auth_state.dart';
import 'package:test_to_do/presentation/autorized/home/home_page.dart';
import 'package:test_to_do/presentation/unautorized/login/login_page.dart';
import 'package:test_to_do/presentation/unautorized/splash/splash_page.dart';

class AuthScopePage extends StatelessWidget {
  const AuthScopePage({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthorizedState) {
            return const HomePage();
          } else if (state is UnauthorizedState) {
            return const LoginPage();
          } else {
            return const SplashPage();
          }
        },
      );
}
