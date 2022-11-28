import 'package:get_it/get_it.dart';
import 'package:task_2_sqflite/data/repositories/repositories_data.dart';
import 'package:task_2_sqflite/ui/bloc/department_cubit.dart';

import '../data/data_sources/local_data_source.dart';

final getIt = GetIt.instance;
Future init() async {
  getIt.registerFactory(() => DepartmentCubit(getIt()));
  getIt.registerLazySingleton<DepartmentRepository>(
      () => DepartmentRepositoryImpl(getIt()));
  getIt.registerLazySingleton(() => SQLDatabase());
}
