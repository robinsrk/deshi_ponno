import 'package:dartz/dartz.dart';
import 'package:deshi_ponno/core/usecases/usecase.dart';
import 'package:deshi_ponno/features/welcome/domain/usecases/check_welcome.dart';
import 'package:deshi_ponno/features/welcome/domain/usecases/complete_welcome.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WelcomeCubit extends Cubit<bool> {
  final CheckWelcomeCompleted checkWelcomeCompleted;
  final CompleteWelcome completeWelcome;

  WelcomeCubit({
    required this.checkWelcomeCompleted,
    required this.completeWelcome,
  }) : super(false);

  Future<void> checkWelcomeStatus() async {
    final result = await checkWelcomeCompleted(NoParams());
    result.fold(
          (failure) => emit(false),
          (completed) => emit(completed),
    );
  }

  Future<void> finishWelcome() async {
    await completeWelcome(NoParams());
    emit(true);
  }
}
