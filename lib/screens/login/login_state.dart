part of '../_screens.dart';

@freezed
abstract class LoginState with _$LoginState {
  factory LoginState({required bool isLogging}) = _LoginState;

  factory LoginState.initial() => _LoginState(isLogging: false);
}

sealed class LoginEvent {}

class LoginFailed extends LoginEvent {}
