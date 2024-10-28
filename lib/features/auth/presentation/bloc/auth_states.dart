import 'package:equatable/equatable.dart';

import '../../domain/entities/user.dart';

class Authenticated extends AuthState {
  final User user;
  final bool isAdmin;

  Authenticated({required this.user, this.isAdmin = false});

  @override
  List<Object?> get props => [user];
}

class AuthError extends AuthState {
  final String message;

  AuthError({required this.message});

  @override
  List<Object?> get props => [message];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}
