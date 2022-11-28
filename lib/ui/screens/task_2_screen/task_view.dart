import 'package:flutter/material.dart';

import '../../managers/value_manager.dart';
import '../../widgets/task_view_widgets/appbar.dart';
import '../../widgets/task_view_widgets/grid_view_widget.dart';
import '../../widgets/task_view_widgets/slider_ad.dart';
import 'add_screen.dart';

class TaskView extends StatelessWidget {
  const TaskView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    return SafeArea(
      child: Scaffold(
        appBar: appBarTask(),
        body: SingleChildScrollView(
          controller: scrollController,
          physics: const BouncingScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.all(AppSize.s12),
            child: Column(
              children: [
                sliderAD(context),
                const SizedBox(height: 25),
                departmentsShow(context),
              ],
            ),
          ),
        ),
        floatingActionButton: _buildFloatingActionButton(context),
      ),
    );
  }
}

_buildFloatingActionButton(BuildContext context) {
  return FloatingActionButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const AddDepartmentPage(),
        ),
      );
    },
    child: const Icon(Icons.add),
  );
}
