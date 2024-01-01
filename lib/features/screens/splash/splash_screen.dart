import 'package:flutter/material.dart';
import 'package:school_manager/features/screens/home/home_screen.dart';

class SplahScreen extends StatelessWidget {
  const SplahScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
        const Duration(
          seconds: 3,
        ), () async {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    });
    return Scaffold(
        body: Center(
          child: Image.asset(
                    "assets/images/logo.png",
                    fit: BoxFit.fill,
                  ),
        ));
  }
}
