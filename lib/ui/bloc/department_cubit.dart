import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_2_sqflite/ui/bloc/department_states.dart';

import '../../data/models/department_model.dart';
import '../../data/repositories/repositories_data.dart';

class DepartmentCubit extends Cubit<DepartmentState> {
  final DepartmentRepository departmentRepository;

  DepartmentCubit(this.departmentRepository) : super(DepartmentInitial());
  List<DepartmentModel> listOfDepartment = [];

  getDepartments() async {
    listOfDepartment = [];
    emit(GetAllDepartmentLoadingState());
    final result = await departmentRepository.readDepartments();
    result.fold(
      (failure) => emit(GetAllDepartmentErrorState()),
      (departments) {
        listOfDepartment.addAll(departments);
        emit(GetDepartmentSuccessState());
      },
    );
  }

  addDepartment(DepartmentModel departmentModel) async {
    emit(AddDepartmentLoadingState());
    final result = await departmentRepository.addDepartment(departmentModel);
    result.fold(
      (failure) => emit(AddDepartmentErrorState()),
      (departments) {
        getDepartments();
        emit(AddDepartmentSuccessState());
      },
    );
  }

  deleteDepartment(int id) async {
    emit(AddDepartmentLoadingState());
    final result = await departmentRepository.deleteDepartment(id);
    result.fold(
      (failure) => emit(DeleteDepartmentErrorState()),
      (departments) {
        getDepartments();
        emit(DeleteDepartmentState());
      },
    );
  }

  updateDepartment(int id, String newTitle, String newBody) async {
    emit(AddDepartmentLoadingState());
    final result =
        await departmentRepository.updateDepartment(id, newTitle, newBody);
    result.fold(
      (failure) => emit(UpdateDepartmentErrorState()),
      (departments) {
        getDepartments();
        emit(UpdateDepartmentState());
      },
    );
  }

  String? imagePicked;
  Future<String> fetchImage() async {
    final ImagePicker picker = ImagePicker();
    XFile? image;
    image = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 100,
      maxWidth: 100,
    );
    if (image == null) {
      null;
    }
    imagePicked = image!.path;
    return image.path;

    emit(ImagePickingState());
  }
}
