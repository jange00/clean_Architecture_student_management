import 'package:dartz/dartz.dart';
import 'package:student_management/core/error/failure.dart';
import 'package:student_management/features/batch/data/data_source/remote_datasource/batch_remote_data_source.dart';
import 'package:student_management/features/batch/domain/entity/batch_entity.dart';
import 'package:student_management/features/batch/domain/repository/batch_repository.dart';

class BatchRemoteRepository implements IBatchRepository{
  final BatchRemoteDatasource _datasource;
  BatchRemoteRepository({required BatchRemoteDatasource batchRemoteDataSource}):_datasource=batchRemoteDataSource;

  @override
  Future<Either<Failure, void>> createBatch(BatchEntity entity) async {
    try{
      await _datasource.createBatch(entity);
      return Right(null);

    }catch(e){
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteBatch(String id) async{
    try {
      await _datasource.deleteBatch(id);
      return const Right(null);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BatchEntity>>> getBatched() async{
    try {
      final batches = await _datasource.getBatched();
      return Right(batches);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

}