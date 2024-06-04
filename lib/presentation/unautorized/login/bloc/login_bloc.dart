import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_to_do/common/utils.dart';
import 'package:test_to_do/common/validator.dart';
import 'package:test_to_do/data/repositories/auth_repository.dart';
import 'package:test_to_do/presentation/unautorized/login/bloc/login_state.dart';
import 'package:test_to_do/data/models/user.dart';

class LoginBloc extends Cubit<LoginState> {
  LoginBloc(this.authRepository) : super(LoginState());

  final AuthRepository authRepository;

  Future<void> addUser(String email, String password) async {
    emit(state.copyWith(isLoading: true));
    final isValid = _validateFields();
    if (!isValid) {
      return;
    }

    final fakeError = await getErrorWithDelay();
    if (fakeError) {
      emit(state.copyWith(networkError: true, isLoading: false));
      return;
    }
    await authRepository.saveUser(User(email: email, password: password));
    emit(state.copyWith(
      isLoading: false,
      isSuccess: true,
    ));
  }

  bool _validateFields() {
    if (Validator.isEmpty(state.email)) {
      emit(state.copyWith(emailError: 'Email cant be empty!', isLoading: false));
      return false;
    }
    if (!Validator.isEmailCorrect(state.email)) {
      emit(state.copyWith(emailError: 'Seems email is incorrect!', isLoading: false));
      return false;
    }
    if (Validator.isEmpty(state.password)) {
      emit(state.copyWith(passwordError: 'Password cant be empty!', isLoading: false));
      return false;
    }
    return true;
  }

  void onEmailChange(String email) => emit(state.copyWith(email: email));

  void onPasswordChange(String password) => emit(state.copyWith(password: password));
}
