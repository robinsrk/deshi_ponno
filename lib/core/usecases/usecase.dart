import 'package:dartz/dartz.dart';
import 'package:deshi_ponno/core/errors/failures.dart';
import 'package:equatable/equatable.dart';

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
