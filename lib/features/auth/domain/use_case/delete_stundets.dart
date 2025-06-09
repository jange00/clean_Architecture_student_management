import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:student_management/app/use_case/usecase.dart';
import 'package:student_management/core/error/failure.dart';
import 'package:student_management/features/auth/domain/repository/student_repository.dart';

class DeleteStudentParams extends Equatable {
  final String studentId;
  const DeleteStudentParams({required this.studentId});

  @override
  List<Object?> get props => [studentId];
}

class DeleteStudentUseCase implements UseCaseWithParams<void, DeleteStudentParams> {
  final IStudentRepository studentRepository;

  DeleteStudentUseCase({required this.studentRepository});

  @override
  Future<Either<Failure, void>> call(DeleteStudentParams params) async {
    return studentRepository.deleteStudent(params.studentId);
  }
}