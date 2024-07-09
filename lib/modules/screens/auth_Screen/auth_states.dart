abstract class AuthStates{}
class AuthInitialState extends AuthStates{}


class RegisterLoadingState extends AuthStates{}
class RegisterSuccessState extends AuthStates{}
class RegisterfailedState extends AuthStates{
  String message;
  RegisterfailedState({required this.message});
}


//login states

class LoginLoading extends AuthStates{}
class LoginFailed extends AuthStates{
  final String Message;
  LoginFailed({required this.Message});
}
class LoginSuccess extends AuthStates{

}

