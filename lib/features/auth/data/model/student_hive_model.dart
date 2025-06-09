import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:student_management/app/constant/hive_table_const.dart';
import 'package:student_management/features/auth/domain/entity/student_entity.dart';
import 'package:student_management/features/batch/data/model/batch_hive_model.dart';
import 'package:student_management/features/course/data/model/course_hive_model.dart';
import 'package:uuid/uuid.dart';

part 'student_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.studentTableId)
class StudentHiveModel extends Equatable {
  @HiveField(0)
  final String studentId;

  @HiveField(1)
  final String firstName;

  @HiveField(2)
  final String lastName;

  @HiveField(3)
  final String phoneNo;
  @HiveField(4)
  final BatchHiveModel batch;
  @HiveField(5)
  final List<CourseHiveModel> lstCourse;

  @HiveField(6)
  final String username;

  @HiveField(7)
  final String password;

  StudentHiveModel({
    String? studentId,
    required this.firstName,
    required this.lastName,
    required this.phoneNo,
    required this.batch,
    required this.lstCourse,
    required this.username,
    required this.password,
  }) : studentId = studentId ?? const Uuid().v4();

  const StudentHiveModel.initial(this.batch, this.lstCourse)
      : studentId = '',
        firstName = '',
        lastName = '',
        phoneNo = '',
        username = '',
        password = '';

  factory StudentHiveModel.fromEntity(StudentEntity entity) {
    return StudentHiveModel(
      studentId: entity.studentId,
      firstName: entity.firstName,
      lastName: entity.lastName,
      phoneNo: entity.phoneNo,
      batch: entity.batch,
      lstCourse: entity.lstCources,
      username: entity.username,
      password: entity.password,
    );
  }

  StudentEntity toEntity() {
    return StudentEntity(
      studentId: studentId,
      firstName: firstName,
      lastName: lastName,
      phoneNo: phoneNo,
      username: username,
      password: password, batch: batch, lstCources: lstCourse,
    );
  }

  static List<StudentHiveModel> fromEntityList(List<StudentEntity> entityList) {
    return entityList.map((entity) => StudentHiveModel.fromEntity(entity)).toList();
  }

  @override
  List<Object?> get props => [
    studentId,
    firstName,
    lastName,
    phoneNo,
    batch,
    lstCourse,
    username,
    password,
  ];
}
