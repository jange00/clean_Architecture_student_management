import 'package:student_management/features/batch/domain/entity/batch_entity.dart';

abstract interface class IBatchDataSource{
  Future<List<BatchEntity>> getBatched();
  Future<void> createBatch(BatchEntity entity);
  Future<void> deleteBatch(String id);
}