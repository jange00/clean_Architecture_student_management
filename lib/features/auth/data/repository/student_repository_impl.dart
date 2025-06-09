import 'package:dartz/dartz.dart';
import 'package:student_management/core/error/failure.dart';
import 'package:student_management/features/auth/data/data_source/student_datasource.dart';
import 'package:student_management/features/auth/domain/entity/student_entity.dart';
import 'package:student_management/features/auth/domain/repository/student_repository.dart';

class StudentLocalRepository implements IStudentRepository {
  final StudentDataSource _studentDataSource;

  StudentLocalRepository({required StudentDataSource studentDataSource})
      : _studentDataSource = studentDataSource;

  @override
  Future<Either<Failure, void>> createStudent(StudentEntity entity) async {
    try {
      await _studentDataSource.addStudents(entity);
      return Right(null);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteStudent(String id) async {
    try {
      await _studentDataSource.deleteStudents(id);
      return Right(null);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<StudentEntity>>> getStudents() async {
    try {
      final List<StudentEntity> students = await _studentDataSource.getAllStudents();
      return Right(students);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }
}
