import 'package:dartz/dartz.dart';
import 'package:student_management/app/use_case/usecase.dart';
import 'package:student_management/core/error/failure.dart';
import 'package:student_management/features/batch/domain/entity/batch_entity.dart';

import '../repository/batch_repository.dart';

class GetAllBatchesUseCase implements UseCaseWithOutParams<List<BatchEntity>>{
  final IBatchRepository batchRepository;
  const GetAllBatchesUseCase({
    required this.batchRepository
});

  @override
  Future<Either<Failure, List<BatchEntity>>> call() {
    return batchRepository.getBatched();
  }

}