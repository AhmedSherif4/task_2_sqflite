import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_2_sqflite/data/models/department_model.dart';
import 'package:task_2_sqflite/ui/bloc/department_cubit.dart';
import 'package:task_2_sqflite/ui/widgets/textformfield.dart';

class AddFormWidget extends StatelessWidget {
  AddFormWidget({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: showTextFormField(
                    controller: _titleController, isTitle: true, name: 'Title'),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: showTextFormField(
                  controller: _bodyController,
                  name: 'Body',
                  isTitle: false,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: ElevatedButton.icon(
                  onPressed:
                      BlocProvider.of<DepartmentCubit>(context).fetchImage,
                  icon: const Icon(Icons.photo),
                  label: const Text('Pick Photo From Your Gellery'),
                ),
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.add_rounded),
                onPressed: () {
                  final isValid = _formKey.currentState!.validate();
                  if (isValid) {
                    final DepartmentModel department = DepartmentModel(
                      imagePath: BlocProvider.of<DepartmentCubit>(context)
                          .imagePicked!,
                      title: _titleController.text,
                      body: _bodyController.text,
                      id: null,
                    );
                    BlocProvider.of<DepartmentCubit>(context)
                        .addDepartment(department);
                    print(department);
                  }
                },
                label: const Text('Add department'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
