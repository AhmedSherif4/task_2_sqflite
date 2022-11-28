import 'dart:async';

import 'package:flutter/material.dart';

import '../../managers/assets_manager.dart';
import '../../managers/color_manager.dart';
import '../../managers/constance_manager.dart';
import '../../managers/route_manager.dart';
import '../../managers/value_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;
  _startDelay() => _timer =
      Timer(const Duration(seconds: AppConstance.splashDelay), _goNext);

  _goNext() => Navigator.pushReplacementNamed(context, Routes.taskRoute);

  @override
  void initState() {
    _startDelay();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      backgroundColor: ColorManager.primary,
      body: const Center(
        child: SizedBox(
          height: AppSize.s130,
          width: AppSize.s130,
          child: Image(
            image: AssetImage(ImageAssets.splashLogo),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
