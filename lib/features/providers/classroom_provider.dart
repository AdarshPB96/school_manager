import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:school_manager/constants/apiUrls/apiurls.dart';
import 'package:school_manager/models/class_rooms_data.dart';
import 'package:http/http.dart' as http;

class ClassroomsProvider extends ChangeNotifier {
  final apiUrls = ApiUrls();
  List<ClassRoomsData> classroomsDataList = [];

  Future<void> fetchData() async {
    final url = apiUrls.basePath + apiUrls.classRooms + apiUrls.apiKey;
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> responseData =
          json.decode(response.body)['classrooms'];

      classroomsDataList = responseData
          .map((dynamic data) => ClassRoomsData.fromJson(data))
          .toList();

      notifyListeners();
      print(classroomsDataList);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<Map<String, dynamic>> getClassroomSubjectDetails(int id) async {
    final String apiUrl =
        apiUrls.basePath + apiUrls.classRooms + '$id' + apiUrls.apiKey;

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        log(response.body);
        return result;
      } else {
        throw Exception(
            'Failed to load classroom details. Status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
}
