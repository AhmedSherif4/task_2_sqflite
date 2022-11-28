import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_2_sqflite/data/models/department_model.dart';
import 'package:task_2_sqflite/ui/widgets/snackbar_message.dart';

import '../../../../application/app_data.dart';
import '../../bloc/department_cubit.dart';
import '../../bloc/department_states.dart';
import '../../managers/color_manager.dart';
import '../../managers/string_manager.dart';
import '../../screens/task_2_screen/details_screen.dart';
import '../loading_widget.dart';

Widget departmentsShow(BuildContext context) {
  return BlocConsumer<DepartmentCubit, DepartmentState>(
    listener: (context, state) {
      if (state is GetAllDepartmentErrorState) {
        showSnackBar(
            context: context,
            message: 'something wrong happened, please try again later',
            color: Colors.red);
      }
    },
    builder: (context, state) {
      if (state is GetAllDepartmentLoadingState) {
        return const LoadingWidget();
      } else {
        print('success list of departments');
        var departments =
            BlocProvider.of<DepartmentCubit>(context).listOfDepartment;

        return departments.isNotEmpty
            ? gridViewWidget(context, departments)
            : SizedBox(
                height: AppData(context).mediaQueryOf.size.height / 3,
                child: Center(
                  child: Text(
                    AppStrings.noDataFound,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              );
      }
    },
  );
}

Widget gridViewWidget(BuildContext context, List<DepartmentModel> list) {
  return GridView.count(
    mainAxisSpacing: 10,
    crossAxisSpacing: 10,
    childAspectRatio:
        AppData(context).mediaQueryOf.orientation == Orientation.landscape
            ? 3 / 2
            : 1,
    crossAxisCount:
        AppData(context).mediaQueryOf.orientation == Orientation.landscape
            ? 3
            : 2,
    padding: const EdgeInsets.all(10),
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    children: [
      ...list.map((department) {
        print('atgridview.count the department is $department');
        print(department.id);
        return bottomShowDepartments(department: department, context: context);
      }).toList(),
    ],
  );
}

Widget bottomShowDepartments(
    {required department, required BuildContext context}) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => DetailsPage(
            department: department,
          ),
        ),
      );
    },
    child: Center(
      child: Container(
        margin: const EdgeInsets.all(15),
        height: 130,
        width: 130,
        child: shapeOfBottom(department, context),
      ),
    ),
  );
}

Widget shapeOfBottom(DepartmentModel department, BuildContext context) {
  return Stack(
    alignment: Alignment.bottomLeft,
    children: [
      Positioned(
        left: 110,
        bottom: 110,
        child: Container(
            transform: Matrix4.rotationZ(20),
            child: Icon(
              Icons.star,
              size: 15,
              color: ColorManager.primary,
            )),
      ),
      Positioned(
        left: 100,
        bottom: 100,
        child: Container(
            transform: Matrix4.rotationZ(15),
            child: Icon(
              Icons.star,
              size: 17,
              color: ColorManager.primary,
            )),
      ),
      Positioned(
        left: 88,
        bottom: 88,
        child: Icon(
          Icons.star,
          size: 18,
          color: ColorManager.primary,
        ),
      ),
      Container(
        margin: const EdgeInsets.all(6),
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: ColorManager.primary, width: 3),
          color: ColorManager.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: CircleAvatar(
                child: Image.file(File(department.imagePath)),
              ),
            ),
            Center(
                child: Text(
              department.title,
              style: Theme.of(context).textTheme.bodyLarge,
            )),
          ],
        ),
      ),
    ],
  );
}
