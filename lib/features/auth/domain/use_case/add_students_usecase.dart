
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:student_management/app/use_case/usecase.dart';
import 'package:student_management/core/error/failure.dart';
import 'package:student_management/features/auth/domain/entity/student_entity.dart';
import 'package:student_management/features/auth/domain/repository/student_repository.dart';

class AddStudentParams extends Equatable {
  final StudentEntity student;
  const AddStudentParams({required this.student});

  @override
  List<Object?> get props => [student];
}

class AddStudentUseCase implements UseCaseWithParams<void, AddStudentParams> {
  final IStudentRepository studentRepository;

  AddStudentUseCase({required this.studentRepository});

  @override
  Future<Either<Failure, void>> call(AddStudentParams params) async {
    return studentRepository.createStudent(params.student);
  }
}