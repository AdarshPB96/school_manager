import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

SvgPicture svgImage(path, {bool fill = false, double? height, double? width}) {
  return SvgPicture.asset(
    path,
    alignment: Alignment.center,
    fit: fill ? BoxFit.fill : BoxFit.contain,
    height: height,
    width: width,
  );
}