import 'dart:developer' as dev;

import 'package:deshi_ponno/core/errors/failures.dart';
import 'package:deshi_ponno/core/usecases/usecase.dart';
import 'package:deshi_ponno/features/auth/domain/usecases/check_user_logged_in.dart';
import 'package:deshi_ponno/features/auth/presentation/bloc/auth_events.dart';
import 'package:deshi_ponno/features/auth/presentation/bloc/auth_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/user.dart';
import '../../domain/usecases/login.dart';
import '../../domain/usecases/signup.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Login login;
  final Signup signup;
  final CheckUserLoggedIn checkUserLoggedIn;

  AuthBloc({
    required this.login,
    required this.signup,
    required this.checkUserLoggedIn,
  }) : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      final failureOrUser = await login(LoginParams(
        email: event.email,
        password: event.password,
      ));
      emit(failureOrUser.fold(
        (failure) {
          final errorMessage = _mapFailureToMessage(failure);
          dev.log('Login Error: $errorMessage'); // Logging for debugging
          return AuthError(message: errorMessage);
        },
        (user) => Authenticated(user: user),
      ));
    });

    on<SignupEvent>((event, emit) async {
      emit(AuthLoading());
      final failureOrUser = await signup(SignupParams(
        email: event.email,
        password: event.password,
      ));
      emit(failureOrUser.fold(
        (failure) {
          final errorMessage = _mapFailureToMessage(failure);
          dev.log('Signup Error: $errorMessage'); // Logging for debugging
          return AuthError(message: errorMessage);
        },
        (user) => Authenticated(user: user),
      ));
    });

    on<CheckUserLoggedInEvent>((event, emit) async {
      final failureOrLoggedIn = await checkUserLoggedIn(NoParams());
      emit(failureOrLoggedIn.fold(
        (failure) {
          final errorMessage = _mapFailureToMessage(failure);
          return AuthError(message: errorMessage);
        },
        (isLoggedIn) => isLoggedIn
            ? Authenticated(user: User(id: 'unknown', email: ''))
            : AuthInitial(),
      ));
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case const (ServerFailure):
        return 'Server Failure';
      default:
        return 'Unexpected error';
    }
  }
}
