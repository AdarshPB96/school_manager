import 'package:flutter/material.dart';
import 'package:school_manager/constants/size_color/colors.dart';
import 'package:school_manager/constants/size_color/size.dart';
import 'package:school_manager/constants/widgets/alert_dialog_widget.dart';
import 'package:school_manager/features/providers/students_provider.dart';
import 'package:school_manager/models/students_data_model.dart';

class StudentsScreen extends StatelessWidget {
  const StudentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    StudentsProvider provider = StudentsProvider();
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Students',
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
              )),
        ),
        body: FutureBuilder(
          future: provider.fetchData(),
          builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
              return  Center(child: CircularProgressIndicator(color: mainBlue,));
            } else if (snapshot.hasError) {
              return Center(child: Text('Error loading data'));
            }
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    final student = provider.studentsDataList[index];
                    return InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDIalogForStudentDetails(
                                student: student);
                          },
                        );
                      },
                      child: Container(
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
                          student.name,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        )),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return tSized20;
                  },
                  itemCount: provider.studentsDataList.length),
            );
          },
        ));
  }
}



class StudentInformationTextWidget extends StatelessWidget {
  final String text;
  const StudentInformationTextWidget(
      {super.key,  required this.text});

  // final StudentsData student;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    );
  }
}
