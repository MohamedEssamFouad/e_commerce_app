abstract class AuthStates{}
class AuthInitialState extends AuthStates{}


class RegisterLoadingState extends AuthStates{}
class RegisterSuccessState extends AuthStates{}
class RegisterfailedState extends AuthStates{
  String message;
  RegisterfailedState({required this.message});
}

