import 'package:student_management/core/network/hive_service.dart';
import 'package:student_management/features/auth/data/data_source/student_datasource.dart';
import 'package:student_management/features/auth/data/model/student_hive_model.dart';
import 'package:student_management/features/auth/domain/entity/student_entity.dart';

class StudentLocalDataSource implements StudentDataSource {
  final HiveService hiveService;

  const StudentLocalDataSource({
    required this.hiveService,
  });

  @override
  Future<void> addStudents(StudentEntity item) async {
    final studentModel = StudentHiveModel.fromEntity(item);
    await hiveService.addStudent(studentModel);
  }

  @override
  Future<void> deleteStudents(String id) async {
    await hiveService.deleteStudent(id);
  }

  @override
  Future<List<StudentEntity>> getAllStudents() async {
    final studentModels = await hiveService.getAllStudents();
    return studentModels.map((model) => model.toEntity()).toList();
  }
}
