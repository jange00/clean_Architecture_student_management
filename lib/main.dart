import 'package:flutter/cupertino.dart';
import 'package:student_management/app/app.dart';
import 'package:student_management/core/network/hive_service.dart';

import 'app/service_locator/service_locator.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final hiveService = HiveService();
  await hiveService.init();

  await initDependencies();
  runApp(App());
}
