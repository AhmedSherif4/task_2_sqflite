import 'package:flutter/material.dart';

import 'application/app.dart';
import 'core/injection_container.dart' as dependency_injection;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dependency_injection.init();
  runApp(MyApp());
}
