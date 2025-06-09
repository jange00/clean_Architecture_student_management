import 'package:student_management/features/auth/domain/entity/student_entity.dart';

class StudentState {
  final bool isLoading;
  final bool isSuccess;
  final List<StudentEntity>? students;
  final String? errorMessage;

  const StudentState({
    required this.isLoading,
    required this.isSuccess,
    this.students,
    this.errorMessage,
  });

  const StudentState.initial()
      : isLoading = false,
        isSuccess = false,
        students = null,
        errorMessage = null;

  StudentState copyWith({
    bool? isLoading,
    bool? isSuccess,
    List<StudentEntity>? students,
    String? errorMessage,
  }) {
    return StudentState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      students: students ?? this.students,
      errorMessage: errorMessage,
    );
  }
}