import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_management/features/course/domain/use_case/create_course_usecase.dart';
import 'package:student_management/features/course/domain/use_case/delete_course_usecase.dart';
import 'package:student_management/features/course/domain/use_case/get_all_courses_usecase.dart';
import 'package:student_management/features/course/presentation/view_model/course_event.dart';
import 'package:student_management/features/course/presentation/view_model/course_state.dart';

class CourseViewModel extends Bloc<CourseEvent, CourseState> {
  final GetAllCourseUsecase _getAllCourseUsecase;
  final CreateCourseUsecase _createCourseUsecase;
  final DeleteCourseUsecase _deleteCourseUsecase;
  CourseViewModel({
    required GetAllCourseUsecase getAllCourseUsecase,
    required CreateCourseUsecase createCourseUsecase,
    required DeleteCourseUsecase deleteCourseUsecase,
  }) : _getAllCourseUsecase = getAllCourseUsecase,
        _createCourseUsecase = createCourseUsecase,
        _deleteCourseUsecase = deleteCourseUsecase,
        super(CourseState.initial()) {
    on<CourseLoadEvent>(_onCourseLoad);
    on<CreateCourseEvent>(_onCreateCourse);
    on<DeleteCourseEvent>(_onDeleteCourse);

    add(CourseLoadEvent());
  }


  Future<void> _onCourseLoad(
      CourseLoadEvent event,
      Emitter<CourseState> emit,
      ) async {
    emit(state.copyWith(isLoading: true));

    final result = await _getAllCourseUsecase();
    print("bloc: $result");
    result.fold(
          (failure) =>
          emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
          (courses) => emit(state.copyWith(isLoading: false, courses: courses,errorMessage: null)),
    );
  }

  Future<void> _onCreateCourse(
      CreateCourseEvent event,
      Emitter<CourseState> emit,
      ) async {
    emit(state.copyWith(isLoading: true));
    // Wait for 1 second to simulate a delay
    await Future.delayed(const Duration(seconds: 1));
    final result = await _createCourseUsecase(
      CreateCourseParams(courseName: event.courseName),
    );
    result.fold(
          (failure) =>
          emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
          (_) {
        emit(state.copyWith(isLoading: false));
        add(CourseLoadEvent());
      },
    );
  }

  Future<void> _onDeleteCourse(
      DeleteCourseEvent event,
      Emitter<CourseState> emit,
      ) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(const Duration(seconds: 1));

    final result = await _deleteCourseUsecase(
      DeleteCourseParams(id: event.courseId),
    );
    result.fold(
          (failure) =>
          emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
          (_) {
        emit(state.copyWith(isLoading: false));
        add(CourseLoadEvent());
      },
    );
  }
}