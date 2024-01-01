import 'package:flutter/material.dart';
import 'package:school_manager/constants/size_color/colors.dart';
import 'package:school_manager/constants/size_color/size.dart';
import 'package:school_manager/constants/widgets/assigned_widgets.dart';
import 'package:school_manager/constants/widgets/classroom_constwidget.dart';
import 'package:school_manager/features/providers/classroom_provider.dart';

class ClassRoomsScreen extends StatelessWidget {
  const ClassRoomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    ClassroomsProvider provider = ClassroomsProvider();

    return Scaffold(
        appBar: appBar1(context: context, text: 'Classrooms'),
        body: FutureBuilder(
          future: provider.fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(
                color: mainBlue,
              ));
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error loading data'));
            }
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    final classroom = provider.classroomsDataList[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ClassroomScreen(
                                  conferenceLayout:
                                      classroom.layout == 'conference'
                                          ? true
                                          : false,
                                  classroomLayout: ClassroomLayout(
                                      numberOfStudents: classroom.size,
                                      id: classroom.id)),
                            ));
                      },
                      child: Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 3,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            height: h * 0.1,
                            child: Center(
                                child: Text(
                              classroom.name,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            )),
                          ),
                          Positioned(
                              right: 40,
                              top: 10,
                              child: Text(
                                classroom.layout,
                                style: TextStyle(
                                    color: classroom.layout == 'conference'
                                        ? mainBlue
                                        : Colors.green,
                                    fontWeight: FontWeight.w600),
                              ))
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return tSized20;
                  },
                  itemCount: provider.classroomsDataList.length),
            );
          },
        ));
  }
}
