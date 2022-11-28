// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';

class AppData {
  BuildContext context;
  AppData(
    this.context,
  );

  get mediaQueryOf => MediaQuery.of(context);
}
