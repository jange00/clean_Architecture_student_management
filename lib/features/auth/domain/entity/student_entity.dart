import 'package:equatable/equatable.dart';
import 'package:student_management/features/batch/data/model/batch_hive_model.dart';
import 'package:student_management/features/course/data/model/course_hive_model.dart';

class StudentEntity extends Equatable {
  final String? studentId;
  final String firstName;
  final String lastName;
  final String phoneNo;
  final BatchHiveModel batch;
  final List<CourseHiveModel> lstCources;
  final String username;
  final String password;

  const StudentEntity({
    this.studentId,
    required this.firstName,
    required this.lastName,
    required this.phoneNo,
    required this.batch,
    required this.lstCources,
    required this.username,
    required this.password,
  });

  @override
  List<Object?> get props => [
    studentId,
    firstName,
    lastName,
    phoneNo,
    batch,
    lstCources,
    username,
    password,
  ];

}
