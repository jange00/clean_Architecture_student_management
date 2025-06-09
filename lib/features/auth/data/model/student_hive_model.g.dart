// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudentHiveModelAdapter extends TypeAdapter<StudentHiveModel> {
  @override
  final int typeId = 0;

  @override
  StudentHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StudentHiveModel(
      studentId: fields[0] as String?,
      firstName: fields[1] as String,
      lastName: fields[2] as String,
      phoneNo: fields[3] as String,
      batch: fields[4] as BatchHiveModel,
      lstCourse: (fields[5] as List).cast<CourseHiveModel>(),
      username: fields[6] as String,
      password: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, StudentHiveModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.studentId)
      ..writeByte(1)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.lastName)
      ..writeByte(3)
      ..write(obj.phoneNo)
      ..writeByte(4)
      ..write(obj.batch)
      ..writeByte(5)
      ..write(obj.lstCourse)
      ..writeByte(6)
      ..write(obj.username)
      ..writeByte(7)
      ..write(obj.password);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
