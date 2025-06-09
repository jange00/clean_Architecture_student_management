import 'package:get_it/get_it.dart';
import 'package:student_management/core/network/hive_service.dart';
import 'package:student_management/features/auth/data/data_source/local_datasource/student_local_datasource.dart';
import 'package:student_management/features/auth/data/repository/student_repository_impl.dart';
import 'package:student_management/features/auth/domain/repository/student_repository.dart';
import 'package:student_management/features/auth/domain/use_case/add_students_usecase.dart';
import 'package:student_management/features/auth/domain/use_case/delete_stundets.dart';
import 'package:student_management/features/auth/domain/use_case/get_all_students.dart';
import 'package:student_management/features/auth/presentation/view_model/login_view_model/login_view_model.dart';
import 'package:student_management/features/auth/presentation/view_model/register_view_model/register_view_model.dart';
import 'package:student_management/features/batch/data/data_source/local_datasource/batch_local_data_source.dart';
import 'package:student_management/features/batch/data/model/batch_hive_model.dart';
import 'package:student_management/features/batch/data/repository/local_repository/batch_local_repository.dart';
import 'package:student_management/features/batch/domain/repository/batch_repository.dart';
import 'package:student_management/features/batch/domain/use_case/create_batch_usecase.dart';
import 'package:student_management/features/batch/domain/use_case/delete_batch_usecase.dart';
import 'package:student_management/features/batch/domain/use_case/get_all_batch_usecase.dart';
import 'package:student_management/features/batch/presentation/view_model/batch_view_model.dart';
import 'package:student_management/features/batch/presentation/view_model/bloc/batch_bloc.dart';
import 'package:student_management/features/course/data/data_source/local_datasource/course_local_datasource.dart';
import 'package:student_management/features/course/data/repository/local_repository/course_local_repository.dart';
import 'package:student_management/features/course/domain/use_case/create_course_usecase.dart';
import 'package:student_management/features/course/domain/use_case/delete_course_usecase.dart';
import 'package:student_management/features/course/domain/use_case/get_all_courses_usecase.dart';
import 'package:student_management/features/course/presentation/view_model/course_view_model.dart';
import 'package:student_management/features/home/presentation/view_model/home_view_model.dart';
import 'package:student_management/features/splash/presentation/view_model/splash_view_model.dart';

final serviceLocator = GetIt.instance;

Future initDependencies() async {
  await _initCourseModule();
  await _initBatchModule();
  await _initHomeModule();
  await _initAuthModule();
  await _initSplashModule();
}

Future _initCourseModule() async {
  serviceLocator.registerFactory<CourseLocalDataSource>(
        () => CourseLocalDataSource(hiveService: serviceLocator<HiveService>()),
  );

  // Repository
  serviceLocator.registerFactory(
        () => CourseLocalRepository(
      courseLocalDataSource: serviceLocator<CourseLocalDataSource>(),
    ),
  );

  // Use cases
  serviceLocator.registerFactory(
        () => GetAllCourseUsecase(
      courseRepository: serviceLocator<CourseLocalRepository>(),
    ),
  );

  serviceLocator.registerFactory(
        () => CreateCourseUsecase(
      courseRepository: serviceLocator<CourseLocalRepository>(),
    ),
  );

  serviceLocator.registerFactory(
        () => DeleteCourseUsecase(
      courseRepository: serviceLocator<CourseLocalRepository>(),
    ),
  );

  // View Model
  serviceLocator.registerFactory(
        () => CourseViewModel(
      getAllCourseUsecase: serviceLocator<GetAllCourseUsecase>(),
      createCourseUsecase: serviceLocator<CreateCourseUsecase>(),
      deleteCourseUsecase: serviceLocator<DeleteCourseUsecase>(),
    ),
  );
}

Future _initBatchModule() async {
  serviceLocator.registerFactory(() => BatchViewModel());

  serviceLocator.registerLazySingleton<HiveService>(() => HiveService());
  serviceLocator.registerLazySingleton<BatchLocalDataSource>(() => BatchLocalDataSource(
    batchHiveModel: BatchHiveModel(batchName: ''),
    hiveService: serviceLocator(),
  ));
  serviceLocator.registerLazySingleton<IBatchRepository>(() => BatchLocalRepository(
    batchDataSource: serviceLocator(),
  ));
  serviceLocator.registerLazySingleton(() => CreateBatchUseCase(batchRepository: serviceLocator()));
  serviceLocator.registerLazySingleton(() => DeleteBatchUseCase(batchRepository: serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetAllBatchesUseCase(batchRepository: serviceLocator()));
  serviceLocator.registerFactory(() => BatchBloc(
    batchUsecase: serviceLocator(),
    deleteBatches: serviceLocator(),
    getbatches: serviceLocator(),
  ));
}

Future _initHomeModule() async {
  serviceLocator.registerLazySingleton(() => HomeViewModel());
}

Future _initAuthModule() async {
  serviceLocator.registerFactory(() => LoginViewModel());
  // serviceLocator.registerLazySingleton<HiveService>(() => HiveService());
  serviceLocator.registerLazySingleton<StudentLocalDataSource>(()=>StudentLocalDataSource(hiveService: serviceLocator()));

  serviceLocator.registerLazySingleton<IStudentRepository>(
        () => StudentLocalRepository(studentDataSource: serviceLocator()
    ),
  );

  // Register UseCases
  serviceLocator.registerLazySingleton(() => AddStudentUseCase(
      studentRepository: serviceLocator<IStudentRepository>()));

  serviceLocator.registerLazySingleton(() => DeleteStudentUseCase(
      studentRepository: serviceLocator<IStudentRepository>()));

  serviceLocator.registerLazySingleton(() => GetStudentsUseCase(
      studentRepository: serviceLocator<IStudentRepository>()));

  // // Register ViewModels with injected use cases
  // serviceLocator.registerFactory(() => LoginViewModel(
  //
  // ));

  serviceLocator.registerFactory(() => StudentBloc(
    createStudentUseCase: serviceLocator<AddStudentUseCase>(), getAllStudentsUseCase:serviceLocator<GetStudentsUseCase>(), deleteStudentUseCase: serviceLocator<DeleteStudentUseCase>(),
  ));
}

Future _initSplashModule() async {
  serviceLocator.registerFactory(() => SplashViewModel());
}