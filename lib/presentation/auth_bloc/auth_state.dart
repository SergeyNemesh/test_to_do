abstract class AuthState {
  const AuthState();
}

class InitialState extends AuthState {
  const InitialState();
}

class AuthorizedState extends AuthState {
  const AuthorizedState();
}

class UnauthorizedState extends AuthState {
  const UnauthorizedState();
}
