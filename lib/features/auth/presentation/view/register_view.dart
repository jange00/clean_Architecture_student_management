import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:student_management/features/auth/domain/entity/student_entity.dart';
import 'package:student_management/features/auth/presentation/view_model/register_view_model/register_event.dart';
import 'package:student_management/features/auth/presentation/view_model/register_view_model/register_view_model.dart';
import 'package:student_management/features/batch/data/model/batch_hive_model.dart';
import 'package:student_management/features/batch/domain/entity/batch_entity.dart';
import 'package:student_management/features/batch/presentation/view_model/bloc/batch_bloc.dart';
import 'package:student_management/features/course/data/model/course_hive_model.dart';
import 'package:student_management/features/course/domain/entity/course_entity.dart';
import 'package:student_management/features/course/presentation/view_model/course_view_model.dart';
import 'package:student_management/features/course/presentation/view_model/course_event.dart';
import 'package:student_management/features/course/presentation/view_model/course_state.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _gap = const SizedBox(height: 8);
  final _key = GlobalKey<FormState>();

  final _fnameController = TextEditingController(text: 'kiran');
  final _lnameController = TextEditingController(text: 'rana');
  final _phoneController = TextEditingController(text: '123456789');
  final _usernameController = TextEditingController(text: 'kiran');
  final _passwordController = TextEditingController(text: 'kiran123');

  BatchEntity? _selectedBatch;
  List<CourseEntity> _selectedCourses = [];

  @override
  void initState() {
    super.initState();
    context.read<BatchBloc>().add(LoadBatches());
    context.read<CourseViewModel>().add(CourseLoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Form(
              key: _key,
              child: Column(
                children: [
                  _buildProfileImage(),
                  _gap,
                  _buildTextField(_fnameController, 'First Name'),
                  _gap,
                  _buildTextField(_lnameController, 'Last Name'),
                  _gap,
                  _buildTextField(_phoneController, 'Phone No'),
                  _gap,

                  // Batch Dropdown
                  BlocBuilder<BatchBloc, BatchState>(
                    builder: (context, state) {
                      if (state.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state.error != null) {
                        return Text('Error: ${state.error}');
                      } else {
                        return DropdownButtonFormField<BatchEntity>(
                          decoration: const InputDecoration(labelText: 'Select Batch'),
                          value: _selectedBatch,
                          items: state.batches
                              .map((batch) => DropdownMenuItem<BatchEntity>(
                            value: batch,
                            child: Text(batch.batchName),
                          ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedBatch = value;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Please select a batch';
                            }
                            return null;
                          },
                        );
                      }
                    },
                  ),

                  _gap,

                  // Courses Multi-Select
                  BlocBuilder<CourseViewModel, CourseState>(
                    builder: (context, state) {
                      if (state.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }  else {
                        return MultiSelectDialogField<CourseEntity>(
                          items: state.courses
                              .map((course) => MultiSelectItem<CourseEntity>(
                            course,
                            course.courseName,
                          ))
                              .toList(),
                          listType: MultiSelectListType.CHIP,
                          buttonText: const Text('Select Courses'),
                          buttonIcon: const Icon(Icons.school),
                          title: const Text('Courses'),
                          searchable: true,
                          initialValue: _selectedCourses,
                          onConfirm: (values) {
                            setState(() {
                              _selectedCourses = values;
                            });
                          },
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black87),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          validator: (values) {
                            if (values == null || values.isEmpty) {
                              return 'Please select at least one course';
                            }
                            return null;
                          },
                        );
                      }
                    },
                  ),

                  _gap,
                  _buildTextField(_usernameController, 'Username'),
                  _gap,
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'Password'),
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      }
                      return null;
                    }),
                  ),
                  _gap,
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_key.currentState!.validate()) {
                          // Submit logic here
                          final firstName = _fnameController.text.trim();
                          final lastName = _lnameController.text.trim();
                          final phone = _phoneController.text.trim();
                          final username = _usernameController.text.trim();
                          final password = _passwordController.text.trim();
                          if (_selectedBatch == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Please select a batch')),
                            );
                            return;
                          }
                          if (_selectedCourses.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Please select at least one course')),
                            );
                            return;
                          }
                          final newStudent = StudentEntity(
                            firstName: firstName,
                            lastName: lastName,

                            username: username,
                            password: password,
                            batch: BatchHiveModel.fromEntity(_selectedBatch!),
                          phoneNo: phone, lstCources: CourseHiveModel.fromEntityList(_selectedCourses),
                          );
                          context.read<StudentBloc>().add(RegisterStudentEvent(student: newStudent, context: context));

                        }
                      },
                      child: const Text('Register'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Helper Widgets
  Widget _buildProfileImage() {
    return InkWell(
      onTap: () {
        // You can show image picker here
      },
      child: SizedBox(
        height: 200,
        width: 200,
        child: CircleAvatar(
          radius: 50,
          backgroundImage: const AssetImage('assets/images/profile.png'),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      validator: ((value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      }),
    );
  }
}
