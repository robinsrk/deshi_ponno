// lib/features/welcome/data/repositories/welcome_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:deshi_ponno/core/errors/exceptions.dart';
import 'package:deshi_ponno/core/errors/failures.dart';
import 'package:deshi_ponno/features/welcome/data/datasources/local/welcome_local_data_source.dart';
import 'package:deshi_ponno/features/welcome/domain/repositories/welcome_repository.dart';

class WelcomeRepositoryImpl implements WelcomeRepository {
  final WelcomeLocalDataSource localDataSource;

  WelcomeRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, bool>> isWelcomeCompleted() async {
    try {
      final result = await localDataSource.isWelcomeCompleted();
      return Right(result);
    } catch (e) {
      return Left(CacheFailure(""));
    }
  }

  @override
  Future<Either<Failure, void>> completeWelcome() async {
    try {
      await localDataSource.completeWelcome();
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(""));
    }
  }
}
