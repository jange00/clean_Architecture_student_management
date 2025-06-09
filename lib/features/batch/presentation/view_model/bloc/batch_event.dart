
part of 'batch_bloc.dart';


sealed class BatchEvent extends Equatable{
  @override
  List<Object?> get props => [];



}
class LoadBatches extends BatchEvent{}

class CreateBatchEvent extends BatchEvent{
  final String batchName;
  CreateBatchEvent({required  this.batchName});
  @override
  List<Object?> get props => [batchName];


}
class DeleteBatch extends BatchEvent{
  final String batchId;
  DeleteBatch({
    required this.batchId
});
  @override
  List<Object?> get props => [batchId];

}
