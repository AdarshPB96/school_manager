import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_manager/constants/size_color/colors.dart';
import 'package:school_manager/constants/size_color/size.dart';
import 'package:school_manager/constants/widgets/assigned_widgets.dart';
import 'package:school_manager/features/providers/classroom_provider.dart';
import 'package:school_manager/features/providers/subjects_provider.dart';

class ClassroomLayout {
  int numberOfStudents;
  int id;

  ClassroomLayout({
    required this.numberOfStudents,
    required this.id,
  });
}

class ClassroomScreen extends StatefulWidget {
  final ClassroomLayout classroomLayout;
  final bool conferenceLayout;

  ClassroomScreen(
      {required this.classroomLayout, required this.conferenceLayout});

  @override
  State<ClassroomScreen> createState() => _ClassroomScreenState();
}

class _ClassroomScreenState extends State<ClassroomScreen> {
  @override
  void initState() {
    Provider.of<SubjectsProvider>(context, listen: false).fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final subProvider = Provider.of<SubjectsProvider>(context);
    return Scaffold(
      appBar: appBar1(context: context, text: 'Classroom Details'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Room Size: ${widget.classroomLayout.numberOfStudents}'),
            // Text('classroom id: ${classroomLayout.id}'),
            const SizedBox(height: 16),
            !widget.conferenceLayout
                ? buildClassroomLayout(widget.classroomLayout.numberOfStudents,
                    widget.classroomLayout.id, subProvider)
                : ConferenceHallLayout(
                    totalStudents: widget.classroomLayout.numberOfStudents,
                    subProvider: subProvider,
                  )
          ],
        ),
      ),
    );
  }

  Widget buildClassroomLayout(
      int numberOfStudents, int id, SubjectsProvider subProvider) {
    int seatsPerColumn = 4;

    List<Widget> rows = [];
    int remainingStudents = numberOfStudents;
    ClassroomsProvider provider = ClassroomsProvider();

    while (remainingStudents > 0) {
      int seatsInRow = remainingStudents >= seatsPerColumn
          ? seatsPerColumn
          : remainingStudents;
      List<Widget> seats = [];

      for (int j = 0; j < seatsInRow; j++) {
        seats.add(const CircleAvatar(
            backgroundColor: Colors.blue,
            radius: 20,
            child: Text('S', style: TextStyle(fontSize: 20))));
        seats.add(SizedBox(
          width: 20,
        ));
      }

      rows.add(Column(
        children: [Row(children: seats), tSized10],
      ));
      remainingStudents -= seatsInRow;
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: mainBlue, width: 2),
      ),
      child: Column(
        children: [
          tSized10,
          Row(
            children: [
              width20,
              FutureBuilder(
                future: provider.getClassroomSubjectDetails(id),
                builder: (context, snapshot) {
                  if (!snapshot.hasData || snapshot.data == null) {
                    return const SizedBox();
                  }
                  return snapshot.data?['subject'] == ""
                      ? InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                log("Subject Data List Length: ${subProvider.subjectDataList.length}");
                                return AlertDialog(
                                    title: const Text('Subjects'),
                                    content: Container(
                                      height: 300,
                                      width: 200,
                                      child: ListView.separated(
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            final subject = subProvider
                                                .subjectDataList[index];

                                            return ListTile(
                                              title: Text(subject.name),
                                              subtitle: Text(
                                                'Teacher: ${subject.teacher}',
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            );
                                          },
                                          separatorBuilder: (context, index) {
                                            return Divider();
                                          },
                                          itemCount: subProvider
                                              .subjectDataList.length),
                                    ));
                              },
                            );
                          },
                          child: const CircleAvatar(
                              backgroundColor: Colors.blue,
                              radius: 20,
                              child: Text('T', style: TextStyle(fontSize: 20))),
                        )
                      : const CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.green,
                          child: Text('T', style: TextStyle(fontSize: 20)));
                },
              ),
              width30,
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: rows),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildConferenceLayout(int numberOfStudents, int id) {
    int seatsPerColumn = numberOfStudents;

    List<Widget> rows = [];
    int remainingStudents = numberOfStudents;
    ClassroomsProvider provider = ClassroomsProvider();

    while (remainingStudents > 0) {
      int seatsInRow = remainingStudents >= seatsPerColumn
          ? seatsPerColumn
          : remainingStudents;
      List<Widget> seats = [];

      for (int j = 0; j < seatsInRow; j++) {
        seats.add(const CircleAvatar(
            radius: 20, child: Text('S', style: TextStyle(fontSize: 20))));
        seats.add(SizedBox(
          width: 20,
        ));
      }

      rows.add(Column(
        children: [Row(children: seats), tSized10],
      ));
      remainingStudents -= seatsInRow;
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: mainBlue, width: 2),
      ),
      child: Column(
        children: [
          tSized10,
          Row(
            children: [
              width20,
              FutureBuilder(
                future: provider.getClassroomSubjectDetails(id),
                builder: (context, snapshot) {
                  if (!snapshot.hasData || snapshot.data == null) {
                    return const SizedBox();
                  }
                  return snapshot.data?['subject'] == ""
                      ? const CircleAvatar(
                          radius: 20,
                          child: Text('T', style: TextStyle(fontSize: 20)))
                      : const CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.green,
                          child: Text('T', style: TextStyle(fontSize: 20)));
                },
              ),
              width30,
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: rows),
            ],
          ),
        ],
      ),
    );
  }
}

class ConferenceHallLayout extends StatelessWidget {
  final int totalStudents;
  final SubjectsProvider subProvider;
  ConferenceHallLayout(
      {required this.totalStudents, required this.subProvider});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(20),
            border: Border.all(color: mainBlue, width: 2)),
        child: buildCentralContainer(context, subProvider),
      ),
    );
  }

  Widget buildCentralContainer(
      BuildContext context, SubjectsProvider subProvider) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                log("Subject Data List Length: ${subProvider.subjectDataList.length}");
                return AlertDialog(
                    title: const Text('Subjects'),
                    content: Container(
                      height: 300,
                      width: 200,
                      child: ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final subject = subProvider.subjectDataList[index];

                            return ListTile(
                              title: Text(subject.name),
                              subtitle: Text(
                                'Teacher: ${subject.teacher}',
                                overflow: TextOverflow.ellipsis,
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Divider();
                          },
                          itemCount: subProvider.subjectDataList.length),
                    ));
              },
            );
          },
          child: const CircleAvatar(
            backgroundColor: Colors.blue,
            child: Text(
              'T',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Center(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    totalStudents ~/ 2,
                    (index) => const Expanded(
                      child: CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: Text(
                          'S',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Colors.grey.withOpacity(0.4),
                  height: 100,
                  width: double.infinity,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    totalStudents - totalStudents ~/ 2,
                    (index) => const Expanded(
                      child: CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: Text(
                          'S',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
