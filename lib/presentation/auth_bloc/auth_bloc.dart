import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_to_do/data/models/user.dart';
import 'package:test_to_do/data/repositories/auth_repository.dart';
import 'package:test_to_do/presentation/auth_bloc/auth_state.dart';

class AuthBloc extends Cubit<AuthState> {
  AuthBloc(this._authRepository) : super(const InitialState()) {
    _checkCurrentUser();
  }

  final AuthRepository _authRepository;

  Future<void> _checkCurrentUser() async {
    await Future.delayed(const Duration(seconds: 7));
    final User? user = await _authRepository.getUser();
    if (user == null) {
      emit(const UnauthorizedState());
      return;
    }
    emit(const AuthorizedState());
  }

  void userWasCreated() async {
    emit(const AuthorizedState());
  }

  Future<void> deleteUser() async {
    await _authRepository.deleteUser();
    emit(const UnauthorizedState());
  }
}
