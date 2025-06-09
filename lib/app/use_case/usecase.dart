import 'package:dartz/dartz.dart';
import 'package:student_management/core/error/failure.dart';

abstract interface class UseCaseWithParams<SuccessType,Params>{
  Future<Either<Failure,SuccessType>> call(Params params);
}


abstract interface class UseCaseWithOutParams<SuccessType>{
  Future<Either<Failure,SuccessType>> call();
}