import 'package:equatable/equatable.dart';
import 'package:task_2_sqflite/data/models/department_model.dart';

abstract class DepartmentState extends Equatable {
  @override
  List<Object> get props => [];
}

class DepartmentInitial extends DepartmentState {}

class GetAllDepartmentLoadingState extends DepartmentState {}

class GetAllDepartmentSuccessState extends DepartmentState {
  final List<DepartmentModel> departments;

  GetAllDepartmentSuccessState({required this.departments});
}

class GetDepartmentSuccessState extends DepartmentState {}

class GetAllDepartmentErrorState extends DepartmentState {}

class AddDepartmentLoadingState extends DepartmentState {}

class AddDepartmentSuccessState extends DepartmentState {}

class AddDepartmentErrorState extends DepartmentState {}

class UpdateDepartmentState extends DepartmentState {}

class UpdateDepartmentErrorState extends DepartmentState {}

class DeleteDepartmentState extends DepartmentState {}

class DeleteDepartmentErrorState extends DepartmentState {}

class ImagePickingState extends DepartmentState {}
