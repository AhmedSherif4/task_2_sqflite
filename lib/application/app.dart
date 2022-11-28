import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_2_sqflite/data/data_sources/local_data_source.dart';
import 'package:task_2_sqflite/ui/bloc/department_cubit.dart';

import '/core/injection_container.dart' as dependency_injection;
import '../ui/managers/route_manager.dart';
import '../ui/managers/theme_manager.dart';

class MyApp extends StatelessWidget {
  //const MyApp({Key? key}) : super(key: key); // Default constructor

  const MyApp._internal(); // Named constructor

  static const MyApp _instance = MyApp._internal(); // singleton pattern

  factory MyApp() => _instance; // factory for singleton

  @override
  Widget build(BuildContext context) {
    SQLDatabase sqlDatabase = SQLDatabase();
    return BlocProvider(
      create: (_) =>
          dependency_injection.getIt<DepartmentCubit>()..getDepartments(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.getRoute,
        initialRoute: Routes.splashRoute,
        theme: getApplicationTheme(),
      ),
    );
  }
}
