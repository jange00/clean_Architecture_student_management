import 'package:student_management/core/network/hive_service.dart';
import 'package:student_management/features/batch/data/data_source/batch_data_source.dart';
import 'package:student_management/features/batch/data/model/batch_hive_model.dart';
import 'package:student_management/features/batch/domain/entity/batch_entity.dart';

class BatchLocalDataSource implements IBatchDataSource{
  final HiveService hiveService;
  final BatchHiveModel batchHiveModel;

  BatchLocalDataSource({
    required this.batchHiveModel,
    required this.hiveService
});
  @override
  Future<void> createBatch(BatchEntity entity) async{
   try{
     await hiveService.addBatch(BatchHiveModel.fromEntity(entity));
   }catch(e){
     throw Exception("failed to add batch:$e");
   }
  }

  @override
  Future<void> deleteBatch(String id) async{
    try{
      await hiveService.deleteBatch(id);
    }catch(e){
      throw Exception("failed to add batch:$e");
    }
  }

  @override
  Future<List<BatchEntity>> getBatched() async{
    try{
      final List<BatchEntity> batches= BatchHiveModel.toEntityList( await hiveService.getAllBatches());
      return batches;

    }catch(e){
      throw Exception("failed to add batch:$e");
    }
  }
  
}