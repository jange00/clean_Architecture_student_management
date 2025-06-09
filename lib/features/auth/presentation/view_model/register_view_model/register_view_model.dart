import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_management/features/auth/domain/entity/student_entity.dart';
import 'package:student_management/features/auth/domain/use_case/add_students_usecase.dart';
import 'package:student_management/features/auth/domain/use_case/delete_stundets.dart';
import 'package:student_management/features/auth/domain/use_case/get_all_students.dart';
import 'package:student_management/features/auth/presentation/view_model/register_view_model/register_event.dart';
import 'package:student_management/features/auth/presentation/view_model/register_view_model/register_state.dart';
class StudentBloc extends Bloc<RegisterEvent, StudentState> {
  final AddStudentUseCase createStudentUseCase;
  final GetStudentsUseCase getAllStudentsUseCase;
  final DeleteStudentUseCase deleteStudentUseCase;

  StudentBloc({
    required this.createStudentUseCase,
    required this.getAllStudentsUseCase,
    required this.deleteStudentUseCase,
  }) : super(const StudentState.initial()) {
    on<RegisterStudentEvent>(_onRegisterStudent);
    on<LoadStudentsEvent>(_onLoadStudents);
    on<DeleteStudentEvent>(_onDeleteStudent);
  }

  Future<void> _onRegisterStudent(
      RegisterStudentEvent event,
      Emitter<StudentState> emit,
      ) async {
    emit(state.copyWith(isLoading: true, isSuccess: false, errorMessage: null));
    final result =
    await createStudentUseCase.call(AddStudentParams(student: event.student));

    result.fold(
          (failure) {
        emit(state.copyWith(
            isLoading: false, isSuccess: false, errorMessage: failure.message));
      },
          (_) async {
        emit(state.copyWith(isLoading: false, isSuccess: true, errorMessage: null));

        add(LoadStudentsEvent());
      },
    );
  }

  Future<void> _onLoadStudents(
      LoadStudentsEvent event,
      Emitter<StudentState> emit,
      ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    final  result= await getAllStudentsUseCase.call();

    result.fold(
          (failure) {
        emit(state.copyWith(
            isLoading: false, isSuccess: false, errorMessage: failure.message));
      },
          (students) {
        emit(state.copyWith(
            isLoading: false, isSuccess: true, students: students));
      },
    );
  }

  Future<void> _onDeleteStudent(
      DeleteStudentEvent event,
      Emitter<StudentState> emit,
      ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    final result = await deleteStudentUseCase(DeleteStudentParams(studentId: event.studentId));

    result.fold(
          (failure) {
        emit(state.copyWith(
            isLoading: false, isSuccess: false, errorMessage: failure.message));
      },
          (_) {
        emit(state.copyWith(isLoading: false, isSuccess: true, errorMessage: null));

        add(LoadStudentsEvent());
      },
    );
  }
}
