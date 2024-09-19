import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginEvent extends AuthEvent {
  LoginEvent();

}

class SignupEvent extends AuthEvent {
  final String email;
  final String password;

  SignupEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class CheckUserLoggedInEvent extends AuthEvent {}
