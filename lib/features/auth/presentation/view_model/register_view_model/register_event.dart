import 'package:flutter/material.dart';
import 'package:student_management/features/auth/domain/entity/student_entity.dart';

@immutable
sealed class RegisterEvent {}

class RegisterStudentEvent extends RegisterEvent {
  final BuildContext context;
  final StudentEntity student;

  RegisterStudentEvent({
    required this.context,
    required this.student,
  });
}
class LoadStudentsEvent extends RegisterEvent {}

class DeleteStudentEvent extends RegisterEvent {
  final String studentId;
  DeleteStudentEvent({required this.studentId});
}
