import 'package:flutter/material.dart';
import 'package:school_manager/features/screens/students/students_screen.dart';
import 'package:school_manager/models/subject_data_model.dart';

class AlertDIalogForStudentDetails extends StatelessWidget {
  const AlertDIalogForStudentDetails({
    super.key,
    required this.student,
  });

  final dynamic student;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Student Information'),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          StudentInformationTextWidget(text: 'Name : ${student.name}'),
          StudentInformationTextWidget(text: 'Age : ${student.age}'),
          StudentInformationTextWidget(text: 'Email : ${student.email}'),
        ],
      ),
    );
  }
}

class AlertDIalogForSubjectDetails extends StatelessWidget {
  const AlertDIalogForSubjectDetails({
    super.key,
    required this.subject,
  });

  final SubjectData subject;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Subject Information'),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          StudentInformationTextWidget(text: 'Name : ${subject.name}'),
          StudentInformationTextWidget(text: 'Teacher : ${subject.teacher}'),
          StudentInformationTextWidget(text: 'Credits : ${subject.credits}'),
        ],
      ),
    );
  }
}
