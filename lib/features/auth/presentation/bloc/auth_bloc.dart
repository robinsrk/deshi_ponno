// import 'package:deshi_ponno/core/errors/failures.dart';
// import 'package:deshi_ponno/features/auth/presentation/bloc/auth_events.dart';
// import 'package:deshi_ponno/features/auth/presentation/bloc/auth_states.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../domain/usecases/login.dart';
// import '../../domain/usecases/signup.dart';
//
// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   final Login login;
//   final Signup signup;
//
//   AuthBloc({required this.login, required this.signup}) : super(AuthInitial()) {
//     on<LoginEvent>((event, emit) async {
//       emit(AuthLoading());
//       final failureOrUser = await login(LoginParams(
//         email: event.email,
//         password: event.password,
//       ));
//       emit(failureOrUser.fold(
//         (failure) => AuthError(message: _mapFailureToMessage(failure)),
//         (user) => Authenticated(user: user),
//       ));
//     });
//
//     on<SignupEvent>((event, emit) async {
//       emit(AuthLoading());
//       final failureOrUser = await signup(SignupParams(
//         email: event.email,
//         password: event.password,
//       ));
//       emit(failureOrUser.fold(
//         (failure) => AuthError(message: _mapFailureToMessage(failure)),
//         (user) => Authenticated(user: user),
//       ));
//     });
//   }
//
//   String _mapFailureToMessage(Failure failure) {
//     switch (failure.runtimeType) {
//       case ServerFailure:
//         return 'Server Failure';
//       default:
//         return 'Unexpected error';
//     }
//   }
// }
import 'package:deshi_ponno/core/errors/failures.dart';
import 'package:deshi_ponno/features/auth/presentation/bloc/auth_events.dart';
import 'package:deshi_ponno/features/auth/presentation/bloc/auth_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/login.dart';
import '../../domain/usecases/signup.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Login login;
  final Signup signup;

  AuthBloc({required this.login, required this.signup}) : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      final failureOrUser = await login(LoginParams(
        email: event.email,
        password: event.password,
      ));
      emit(failureOrUser.fold(
        (failure) {
          final errorMessage = _mapFailureToMessage(failure);
          print('Login Error: $errorMessage'); // Logging for debugging
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
          print('Signup Error: $errorMessage'); // Logging for debugging
          return AuthError(message: errorMessage);
        },
        (user) => Authenticated(user: user),
      ));
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server Failure';
      default:
        return 'Unexpected error';
    }
  }
}
