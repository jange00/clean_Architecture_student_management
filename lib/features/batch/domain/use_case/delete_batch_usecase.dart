import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:student_management/app/use_case/usecase.dart';
import 'package:student_management/core/error/failure.dart';
import 'package:student_management/features/batch/domain/repository/batch_repository.dart';

class DeleteBatchParams extends Equatable{
  final String id;
  const DeleteBatchParams({required this.id});

  const DeleteBatchParams.empty():id="_empty.string";

  @override
  List<Object?> get props => [id];

}

class DeleteBatchUseCase implements UseCaseWithParams<void,String>{
  final IBatchRepository batchRepository;
  const DeleteBatchUseCase({
    required this.batchRepository
});
  @override
  Future<Either<Failure, void>> call(String params) async{
    return batchRepository.deleteBatch(params);
  }

}
