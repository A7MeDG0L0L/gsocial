abstract class LoginStates {}
 class InitialLoginState extends LoginStates {}
 class SuccessLoginState extends LoginStates {}
 class ErrorLoginState extends LoginStates {
  final String error;

  ErrorLoginState(this.error);
 }
 class LoadingLoginState extends LoginStates {}