part of 'auth_bloc.dart';

abstract class AuthEvent {
  const AuthEvent();
}

class GoogleSignInRequested extends AuthEvent {}

class MobileInRequested extends AuthEvent {
  final String mobile;

  const MobileInRequested(this.mobile);
}

class FacebookSignInRequested extends AuthEvent {}

class EmailSignInRequested extends AuthEvent {
  final String email;
  const EmailSignInRequested(this.email);
}
