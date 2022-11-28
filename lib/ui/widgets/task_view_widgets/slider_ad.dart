import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../application/app_data.dart';
import '../../managers/assets_manager.dart';
import '../../managers/color_manager.dart';
import '../../managers/value_manager.dart';

List listOfImagesSlider = [
  ImageAssets.slider1,
  ImageAssets.slider2,
  ImageAssets.slider3,
  ImageAssets.slider4,
];

CarouselSlider sliderAD(BuildContext context) {
  double ifItVertical = AppData(context).mediaQueryOf.size.height / 2.5;
  double ifItHorizontal = AppData(context).mediaQueryOf.size.height / 6;
  var orientation = AppData(context).mediaQueryOf.orientation;
  return CarouselSlider(
    options: CarouselOptions(
        viewportFraction: orientation == Orientation.landscape ? 0.6 : 0.8,
        height: orientation == Orientation.landscape
            ? ifItVertical
            : ifItHorizontal,
        autoPlay: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.easeInOutCubic),
    items: listOfImagesSlider.map((image) {
      return Builder(
        builder: (BuildContext context) {
          return Container(
            width: orientation == Orientation.landscape
                ? AppData(context).mediaQueryOf.size.width / 2
                : AppData(context).mediaQueryOf.size.width,
            margin: const EdgeInsets.symmetric(horizontal: 5.0),
            decoration: BoxDecoration(
              color: ColorManager.primary,
              borderRadius: BorderRadius.circular(AppSize.s14),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppSize.s14),
              child: Image(
                image: AssetImage(image),
                fit: BoxFit.fill,
              ),
            ),
          );
        },
      );
    }).toList(),
  );
}
