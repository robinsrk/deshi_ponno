import 'package:deshi_ponno/features/auth/domain/entities/user.dart';
import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CheckAdminEvent extends AuthEvent {
  final User user;

  CheckAdminEvent({required this.user});

  @override
  List<Object?> get props => [user];
}

class CheckUserLoggedInEvent extends AuthEvent {}

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
