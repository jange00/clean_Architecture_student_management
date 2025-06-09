import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:student_management/app/constant/hive_table_const.dart';
import 'package:student_management/features/auth/data/model/student_hive_model.dart';
import 'package:student_management/features/batch/data/model/batch_hive_model.dart';
import 'package:student_management/features/course/data/model/course_hive_model.dart';

class HiveService{
  Future<void> init()async{
    // Initialize the database
    var directory=await getApplicationDocumentsDirectory();
    var path="${directory.path}student_management_system.db";
    Hive.init(path);

    Hive.registerAdapter(CourseHiveModelAdapter());
    Hive.registerAdapter(BatchHiveModelAdapter());
    Hive.registerAdapter(StudentHiveModelAdapter());
  }

  Future<void> addBatch(BatchHiveModel model) async{
    var box=await Hive.openBox<BatchHiveModel>(HiveTableConstant.batchBox);
    await box.put(model.batchId, model);
  }
  Future<List<BatchHiveModel>> getAllBatches()async{
    var box=await Hive.openBox<BatchHiveModel>(HiveTableConstant.batchBox);
    var batches=box.values.toList();
    return batches;
  }

  Future<void> deleteBatch(String id)async{
    var box=await Hive.openBox<BatchHiveModel>(HiveTableConstant.batchBox);
    await box.delete(id);
  }

  // ========================== Course Queries ==========================
  Future<void> addCourse(CourseHiveModel course) async {
    var box = await Hive.openBox<CourseHiveModel>(HiveTableConstant.courseBox);
    await box.put(course.courseId, course);
    await box.close();
  }

  Future<List<CourseHiveModel>> getAllCourses() async {
    var box = await Hive.openBox<CourseHiveModel>(HiveTableConstant.courseBox);
    List<CourseHiveModel> courses = box.values.toList();
    await box.close();
    return courses;
  }

  Future<void> deleteCourse(String courseId) async {
    var box = await Hive.openBox<CourseHiveModel>(HiveTableConstant.courseBox);
    await box.delete(courseId);
    await box.close();
  }

  Future<void> addStudent(StudentHiveModel student) async {
    var box = await Hive.openBox<StudentHiveModel>(HiveTableConstant.studentBox);
    await box.put(student.studentId, student);
    await box.close();
  }

  Future<List<StudentHiveModel>> getAllStudents() async {
    var box = await Hive.openBox<StudentHiveModel>(HiveTableConstant.studentBox);
    List<StudentHiveModel> students = box.values.toList();
    await box.close();
    return students;
  }

  Future<void> deleteStudent(String studentId) async {
    var box = await Hive.openBox<StudentHiveModel>(HiveTableConstant.studentBox);
    await box.delete(studentId);
    await box.close();
  }
}