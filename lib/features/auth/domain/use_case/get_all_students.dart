import 'package:dartz/dartz.dart';
import 'package:student_management/core/error/failure.dart';
import 'package:student_management/app/use_case/usecase.dart';
import 'package:student_management/features/auth/domain/entity/student_entity.dart';
import 'package:student_management/features/auth/domain/repository/student_repository.dart';

class GetStudentsUseCase implements UseCaseWithOutParams<List<StudentEntity>> {
  final IStudentRepository studentRepository;

  GetStudentsUseCase({required this.studentRepository});

  @override
  Future<Either<Failure, List<StudentEntity>>> call() async {
    return studentRepository.getStudents();
  }
}
