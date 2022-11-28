import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_2_sqflite/ui/bloc/department_cubit.dart';
import 'package:task_2_sqflite/ui/bloc/department_states.dart';
import 'package:task_2_sqflite/ui/screens/task_2_screen/task_view.dart';

import '../../widgets/add_widgets/add_form_widget.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/snackbar_message.dart';

class AddDepartmentPage extends StatelessWidget {
  const AddDepartmentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar() => AppBar(
        title: const Text('Add Department'),
        centerTitle: true,
        elevation: 0,
      );

  Widget _buildBody(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocConsumer<DepartmentCubit, DepartmentState>(
          listener: (context, state) {
            if (state is AddDepartmentSuccessState) {
              showSnackBar(
                  context: context,
                  message: 'department added',
                  color: Colors.green);
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const TaskView()),
                  (route) => false);
            }
            if (state is AddDepartmentErrorState) {
              showSnackBar(
                  context: context,
                  message: 'something wrong happened, please try again later',
                  color: Colors.red);
            }
          },
          builder: (context, state) {
            if (state is AddDepartmentLoadingState) {
              return const LoadingWidget();
            }
            return AddFormWidget();
          },
        ),
      ),
    );
  }
}
