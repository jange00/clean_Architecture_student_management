import 'package:json_annotation/json_annotation.dart';
import 'package:student_management/features/batch/data/model/batch_api_model.dart';

// dart run build_runner build -d 
part 'get_all_batch_dto.g.dart';

@JsonSerializable()
class GetAllBatchDTO{
  final bool success;
  final int count;
  final List<BatchApiModel> data;

  GetAllBatchDTO({
    required this.data,
    required this.count,
    required this.success
  });

  Map<String,dynamic> toJson()=> _$GetAllBatchDTOToJson(this);

  factory GetAllBatchDTO.fromJson(Map<String,dynamic> json)=>
      _$GetAllBatchDTOFromJson(json);

}