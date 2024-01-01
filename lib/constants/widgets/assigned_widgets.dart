import 'package:flutter/material.dart';

PreferredSizeWidget appBar1({required BuildContext context, required String text}) {
  return AppBar(
    title:  Text(
      text,
      style: const TextStyle(color: Colors.white),
    ),
    leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Colors.white,
        )),
  );
}
