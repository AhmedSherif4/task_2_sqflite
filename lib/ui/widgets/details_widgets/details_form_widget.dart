import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_2_sqflite/data/models/department_model.dart';
import 'package:task_2_sqflite/ui/bloc/department_cubit.dart';
import 'package:task_2_sqflite/ui/bloc/department_states.dart';
import 'package:task_2_sqflite/ui/widgets/textformfield.dart';

import '../../screens/task_2_screen/task_view.dart';
import '../snackbar_message.dart';

class DetailsFormWidget extends StatelessWidget {
  final DepartmentModel department;

  DetailsFormWidget({
    Key? key,
    required this.department,
  }) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _titleController.text = department.title;
    _bodyController.text = department.body;
    return SingleChildScrollView(
      child: BlocConsumer<DepartmentCubit, DepartmentState>(
        listener: (context, state) {
          if (state is DeleteDepartmentState ||
              state is UpdateDepartmentState) {
            showSnackBar(
                context: context,
                message: 'department added',
                color: Colors.green);
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const TaskView()),
                (route) => false);
          }
          if (state is DeleteDepartmentErrorState ||
              state is DeleteDepartmentErrorState) {
            showSnackBar(
                context: context,
                message: 'something wrong happened, please try again later',
                color: Colors.red);
          }
        },
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    child: showTextFormField(
                      controller: _titleController,
                      isTitle: true,
                      name: 'Title',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    child: showTextFormField(
                      controller: _bodyController,
                      name: 'Body',
                      isTitle: false,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    child: Image.file(File(department.imagePath)),
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.add_rounded),
                    onPressed: () {
                      final isValid = _formKey.currentState!.validate();
                      _formKey.currentState!.save();
                      if (isValid) {
                        print(_titleController.text);
                        print(_bodyController.text);
                        BlocProvider.of<DepartmentCubit>(context)
                            .updateDepartment(
                          department.id!,
                          _titleController.text,
                          _bodyController.text,
                        );
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (_) => const TaskView()),
                            (route) => false);
                      }
                    },
                    label: const Text('Update department'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
