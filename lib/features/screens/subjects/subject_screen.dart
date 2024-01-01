import 'package:flutter/material.dart';
import 'package:school_manager/constants/size_color/colors.dart';
import 'package:school_manager/constants/size_color/size.dart';
import 'package:school_manager/constants/widgets/alert_dialog_widget.dart';
import 'package:school_manager/features/providers/subjects_provider.dart';

class SubjectScreen extends StatelessWidget {
  const SubjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    SubjectsProvider provider = SubjectsProvider();
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'subjects',
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
              return const Center(child: Text('Error loading data'));
            }
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    final subject = provider.subjectDataList[index];
                    return InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDIalogForSubjectDetails(
                                subject: subject);
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
                          subject.name,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        )),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return tSized20;
                  },
                  itemCount: provider.subjectDataList.length),
            );
          },
        ));
  }
}
