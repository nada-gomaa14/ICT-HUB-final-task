abstract class AuthStates {}

class AuthInitialState extends AuthStates {}

class PasswordVisibilityState extends AuthStates {}

class RegisterLoadingState extends AuthStates {}
class RegisterSuccessState extends AuthStates {}
class RegisterErrorState extends AuthStates {
  final String error;

  RegisterErrorState({required this.error});
}

class LoginLoadingState extends AuthStates {}
class LoginSuccessState extends AuthStates {}
class LoginErrorState extends AuthStates {
  final String error;

  LoginErrorState({required this.error});
}

class LogoutLoadingState extends AuthStates {}
class LogoutSuccessState extends AuthStates {}
class LogoutErrorState extends AuthStates {
  final String error;

  LogoutErrorState({required this.error});
}