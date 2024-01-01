import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:school_manager/constants/apiUrls/apiurls.dart';
import 'package:http/http.dart' as http;
import 'package:school_manager/models/subject_data_model.dart';

class SubjectsProvider extends ChangeNotifier {
  final apiUrls = ApiUrls();
  List<SubjectData> subjectDataList = [];

  Future<void> fetchData() async {
    final url = apiUrls.basePath + apiUrls.subjects + apiUrls.apiKey;
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body)['subjects'];

      subjectDataList = responseData
          .map((dynamic data) => SubjectData.fromJson(data))
          .toList();

      notifyListeners();
      print(subjectDataList);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> assignSubjectToClassroom(int classroomId, int subjectId) async {
    final apiUrls = ApiUrls();
    final assignUrl =
        apiUrls.basePath + '/$classroomId/assign_subject' + apiUrls.apiKey;
    log(assignUrl);
    try {
      final http.Response response = await http.patch(
        Uri.parse(assignUrl),
        // body: {'subject': subjectId.toString()},
      );

      if (response.statusCode == 200) {
        print('Subject assigned successfully to classroom $classroomId!');
      } else {
        print('Failed to assign subject. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }


}
