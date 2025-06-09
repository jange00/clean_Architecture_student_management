import 'package:dartz/dartz.dart';
import 'package:student_management/core/error/failure.dart';
import 'package:student_management/features/batch/data/data_source/batch_data_source.dart';
import 'package:student_management/features/batch/data/data_source/local_datasource/batch_local_data_source.dart';
import 'package:student_management/features/batch/domain/entity/batch_entity.dart';
import 'package:student_management/features/batch/domain/repository/batch_repository.dart';

class BatchLocalRepository implements IBatchRepository{
  final BatchLocalDataSource _batchLocalDataSource;
  BatchLocalRepository({required BatchLocalDataSource batchDataSource}):_batchLocalDataSource=batchDataSource;

  @override
  Future<Either<Failure, void>> createBatch(BatchEntity entity) {
   try{
     _batchLocalDataSource.createBatch(entity);
     return Future.value(Right(null));
   }catch(e){
     return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
   }
  }

  @override
  Future<Either<Failure, void>> deleteBatch(String id) {
    try{
      _batchLocalDataSource.deleteBatch(id);
      return Future.value(Right(null));

    }catch(e){
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, List<BatchEntity>>> getBatched() async{
    try{
     final List<BatchEntity> batches=await  _batchLocalDataSource.getBatched();
      return Future.value(Right(batches));

    }catch(e){
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }


}