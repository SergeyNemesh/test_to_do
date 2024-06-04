import 'package:equatable/equatable.dart';




class LoginState extends Equatable {
  final String email;
  final String? emailError;
  final String password;
  final String? passwordError;
  final bool isLoading;
  final bool isSuccess;
  final dynamic networkError;

  const LoginState({
    this.email = '',
    this.emailError,
    this.password = '',
    this.passwordError,
    this.isLoading = false,
    this.isSuccess = false,
    this.networkError,
  });

  LoginState copyWith({
    String? email,
    dynamic emailError,
    String? password,
    String? passwordError,
    bool? isLoading,
    final bool? isSuccess,
    dynamic networkError,
  }) {
    return LoginState(
      email: email ?? this.email,
      emailError: email != null ? null : (emailError ?? this.emailError),
      password: password ?? this.password,
      passwordError: password != null ? null : (passwordError ?? this.passwordError),
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      networkError: networkError,
    );
  }

  @override
  List<Object?> get props => [
        email,
        emailError,
        password,
        passwordError,
        isLoading,
        isSuccess,
        networkError,
      ];
}
