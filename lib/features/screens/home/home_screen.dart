import 'package:flutter/material.dart';
import 'package:school_manager/constants/path/assets.dart';
import 'package:school_manager/constants/size_color/colors.dart';
import 'package:school_manager/constants/size_color/size.dart';
import 'package:school_manager/constants/widgets/clipper_widget.dart';
import 'package:school_manager/constants/widgets/common_extracted.dart';
import 'package:school_manager/constants/widgets/home_constants.dart';
import 'package:school_manager/features/screens/classroom/classrooms_screen.dart';
import 'package:school_manager/features/screens/students/students_screen.dart';
import 'package:school_manager/features/screens/subjects/subject_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    final assets = assetPath();
    final svgs = svgPath();
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipPathContainer(h: h, w: w),
                Positioned(
                    right: w * 0.1,
                    top: h * 0.04,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(90),
                      child: Image.asset(
                        assets.logo,
                        height: h * 0.16,
                      ),
                    ))
              ],
            ),
            tSized40,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ClassRoomsScreen(),
                        ));
                  },
                  child: Column(
                    children: [
                      SizedBox(
                          height: h * 0.14,
                          width: w * 0.3,
                          child: svgImage(svgs.classRoom, fill: true)),
                      tSized20,
                      const ConstText(
                        text: 'classrooms',
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StudentsScreen(),
                        ));
                  },
                  child: Column(
                    children: [
                      SizedBox(
                          height: h * 0.14,
                          width: w * 0.3,
                          child: svgImage(svgs.student, fill: true)),
                      tSized20,
                      const ConstText(
                        text: 'students',
                      )
                    ],
                  ),
                ),
              ],
            ),
            tSized20,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SubjectScreen(),
                        ));
                  },
                  child: Column(
                    children: [
                      SizedBox(
                          height: h * 0.14,
                          width: w * 0.3,
                          child: svgImage(svgs.subjects, fill: true)),
                      const ConstText(
                        text: 'subjects',
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: h * 0.14,
                  width: w * 0.3,
                )
              ],
            ),
          ],
        ),
      )),
    );
  }
}
