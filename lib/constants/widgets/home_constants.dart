import 'package:flutter/material.dart';
import 'package:school_manager/constants/size_color/colors.dart';

class ConstText extends StatelessWidget {
  final String text;
  const ConstText({
    super.key,required this.text
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:
          TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: mainBlue),
    );
  }
}
