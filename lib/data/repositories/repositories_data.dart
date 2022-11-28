import 'package:dartz/dartz.dart';
import 'package:task_2_sqflite/data/models/department_model.dart';

import '../../core/failure.dart';
import '../data_sources/local_data_source.dart';

abstract class DepartmentRepository {
  Future<Either<Failure, List<DepartmentModel>>> readDepartments();
  Future<Either<Failure, int>> deleteDepartment(int id);
  Future<Either<Failure, int>> updateDepartment(
      int id, String newTitle, String newBody);
  Future<Either<Failure, int>> addDepartment(DepartmentModel department);
}

class DepartmentRepositoryImpl implements DepartmentRepository {
  final SQLDatabase sqlDatabase;

  DepartmentRepositoryImpl(this.sqlDatabase);

  @override
  Future<Either<Failure, int>> addDepartment(DepartmentModel department) async {
    try {
      return Right(await sqlDatabase.insertDatabase(department));
    } catch (error) {
      return Left(ServerFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> deleteDepartment(int id) async {
    try {
      return Right(await sqlDatabase.deleteDatabase(id));
    } catch (error) {
      return Left(ServerFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, List<DepartmentModel>>> readDepartments() async {
    try {
      return Right(await sqlDatabase.readDatabase());
    } catch (error) {
      return Left(ServerFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> updateDepartment(
      int id, String newTitle, String newBody) async {
    try {
      return Right(await sqlDatabase.updateDatabase(id, newTitle, newBody));
    } catch (error) {
      return Left(ServerFailure(message: error.toString()));
    }
  }
}
