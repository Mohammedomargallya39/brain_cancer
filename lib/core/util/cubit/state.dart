import 'package:meta/meta.dart';

@immutable
abstract class AppState {}

class Empty extends AppState {}

class Loading extends AppState {}

class Loaded extends AppState {}

class Error extends AppState {}

class ThemeLoaded extends AppState {}

class ChangeModeState extends AppState {}

class ChangeLanguageState extends AppState {}

class LanguageLoaded extends AppState {}

class ChangeLoaded extends AppState {}

class BottomChanged extends AppState {}

class UserChangeLoginSuffixState extends AppState {}

class ChangeSelectGovernment extends AppState {}

class UserLoginLoading extends AppState {}

class UserLoginSuccess extends AppState {
  final String token;

  UserLoginSuccess({
    required this.token,
  });
}

class UserLoginError extends AppState {
  final String message;

  UserLoginError({
    required this.message,
  });
}

class RegisterLoading extends AppState {}

class RegisterSuccess extends AppState {
  final String message ;

  RegisterSuccess({
    required this.message,
  });
}

class RegisterError extends AppState {
  final String message;

  RegisterError({
    required this.message,
  });
}

class ChangeStatus extends AppState {}



