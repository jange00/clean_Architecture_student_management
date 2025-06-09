import 'package:student_management/features/auth/domain/entity/student_entity.dart';

abstract interface class StudentDataSource{
  Future<void> addStudents(StudentEntity item);
  Future<List<StudentEntity>> getAllStudents();
  Future<void> deleteStudents(String id);
}