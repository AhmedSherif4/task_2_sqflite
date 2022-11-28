import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_2_sqflite/ui/bloc/department_cubit.dart';

import '../../../data/models/department_model.dart';
import '../../widgets/details_widgets/details_form_widget.dart';

class DetailsPage extends StatelessWidget {
  final DepartmentModel department;

  const DetailsPage({
    Key? key,
    required this.department,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) => AppBar(
        title: const Text("Details' Department"),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              BlocProvider.of<DepartmentCubit>(context)
                  .deleteDepartment(department.id!);
            },
            icon: const Icon(Icons.delete_rounded),
          ),
        ],
      );

  Widget _buildBody(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: DetailsFormWidget(
          department: department,
        ),
      ),
    );
  }
}
