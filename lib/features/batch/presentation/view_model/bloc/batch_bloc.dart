import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:student_management/features/batch/domain/entity/batch_entity.dart';
import 'package:student_management/features/batch/domain/use_case/create_batch_usecase.dart';
import 'package:student_management/features/batch/domain/use_case/delete_batch_usecase.dart';
import 'package:student_management/features/batch/domain/use_case/get_all_batch_usecase.dart';

part 'batch_state.dart';
part 'batch_event.dart';

class BatchBloc extends Bloc<BatchEvent, BatchState> {
  final CreateBatchUseCase _createBatchUseCase;
  final DeleteBatchUseCase _deleteBatchUseCase;
  final GetAllBatchesUseCase _batchesUseCase;
  BatchBloc({
    required CreateBatchUseCase batchUsecase,
    required DeleteBatchUseCase deleteBatches,
    required GetAllBatchesUseCase getbatches,
  }) : _batchesUseCase = getbatches,
       _createBatchUseCase = batchUsecase,
       _deleteBatchUseCase = deleteBatches,
        super(BatchState.initial()) {
    on<CreateBatchEvent>(_onCreateBatch);
    on<DeleteBatch>(_onDeleteBatch);
    on<LoadBatches>(_onLoadBatches);
  }

  Future<void> _onCreateBatch(
      CreateBatchEvent event,
      Emitter<BatchState> emit,
      ) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      await _createBatchUseCase.call(CreateBatchParams(batchName: event.batchName));
      add(LoadBatches());
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onDeleteBatch(
      DeleteBatch event,
      Emitter<BatchState> emit,
      ) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      await _deleteBatchUseCase(event.batchId);
      add(LoadBatches());
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onLoadBatches(
      LoadBatches event,
      Emitter<BatchState> emit,
      ) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final result = await _batchesUseCase();
      result.fold(
            (failure) {
          emit(state.copyWith(
            isLoading: false,
            error: failure.message,
          ));
        },
            (batches) {
          emit(state.copyWith(
            isLoading: false,
            batches: batches,
            error: null
          ));
        },
      );
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

}
