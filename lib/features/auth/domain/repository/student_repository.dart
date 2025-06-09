import 'package:dartz/dartz.dart';
import 'package:student_management/core/error/failure.dart';
import 'package:student_management/features/auth/domain/entity/student_entity.dart';

abstract interface class IStudentRepository {
  Future<Either<Failure, List<StudentEntity>>> getStudents();
  Future<Either<Failure, void>> createStudent(StudentEntity entity);
  Future<Either<Failure, void>> deleteStudent(String id);
}
