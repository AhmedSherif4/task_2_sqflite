import 'package:flutter/material.dart';

import '../../managers/icons_manager.dart';
import '../../managers/string_manager.dart';
import '../../managers/value_manager.dart';

PreferredSizeWidget appBarTask() {
  return AppBar(
    leading: const Icon(AppIcons.translate),
    actions: const [
      Icon(AppIcons.output),
      SizedBox(width: AppSize.s12),
    ],
    title: const Text(
      AppStrings.mainAppBar,
    ),
  );
}
