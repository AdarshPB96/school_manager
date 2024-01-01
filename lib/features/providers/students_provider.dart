import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:school_manager/constants/apiUrls/apiurls.dart';
import 'package:school_manager/models/class_rooms_data.dart';
import 'package:http/http.dart' as http;
import 'package:school_manager/models/students_data_model.dart';

class StudentsProvider extends ChangeNotifier {
  final apiUrls = ApiUrls();
  List<StudentsData> studentsDataList = [];

  Future<void> fetchData() async {
    final url = apiUrls.basePath + apiUrls.students + apiUrls.apiKey;
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> responseData =
          json.decode(response.body)['students'];

      studentsDataList = responseData
          .map((dynamic data) => StudentsData.fromJson(data))
          .toList();

      notifyListeners();
      print(studentsDataList);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
