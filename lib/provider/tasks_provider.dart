import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:my_desktop_app/constants/constants.dart';
import 'package:my_desktop_app/models/models.dart';

class TaskProvider extends ChangeNotifier {
  String _vistaTareas = listavistatareas[0];

  Stream<String> get vistaTareas async* {
    yield _vistaTareas;
  }

  void onLockedTaskChanged(String newTaskOption) {
    _vistaTareas = newTaskOption;
    notifyListeners();
  }

  // -----------------------------------------------------

  bool _create = true;

  Stream<bool> get create async* {
    yield _create;
  }

  void isCreate(bool isnewcreate) {
    _create = isnewcreate;
  }

  // -------------------------------------------------

  String _id = '';

  Stream<String> get id async* {
    yield _id;
  }

  void setId(String newId) {
    _id = newId;
  }

  // --------------------------------------------------------

  String _taskEmployee = '';

  Stream<String> get taskEmployee async* {
    yield _taskEmployee;
  }

  void setNewEmployee(String newEmployee) {
    _taskEmployee = newEmployee;
    notifyListeners();
  }

  // -------------------------------------------------------

  String _taskDay = '';

  Stream<String> get taskDay async* {
    yield _taskDay;
  }

  void setNewDay(String newDay) {
    _taskDay = newDay;
    notifyListeners();
  }

  // -------------------------------------------------------
  String _tasktitle = '';

  Stream<String> get taskTitle async* {
    yield _tasktitle;
  }

  void setNewTitle(String newTitle) {
    _tasktitle = newTitle;
  }

  // -------------------------------------------------------
  String _taskcontent = '';

  Stream<String> get taskContent async* {
    yield _taskcontent;
  }

  void setNewContent(String newContent) {
    _taskcontent = newContent;
  }

  // -------------------------------------------------------
  void resetTaskForm() {
    _taskDay = '';
    _taskEmployee = '';
    setNewTitle('');
    setNewContent('');
  }

  void setAllData(String title, String content, String employee) {
    setNewTitle(title);
    setNewContent(content);
    setNewEmployee(employee);
  }

  // -------------------------------------------------------
  Stream<List<Task>> taskData(String company) async* {
    await Future.delayed(const Duration(milliseconds: 200));
    String validCompany = company.replaceAll(' ', '-');
    var url = Uri.http(baseUrl, 'api/task/company/$validCompany');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final TaskModel taskModel = TaskModel.fromJson(response.body);
        yield taskModel.data;
      } else {
        yield <Task>[];
      }
    } catch (error) {
      yield [defaulttask];
    }
  }

  // ----------------------------------------------------------
  Future<bool> postTask(String dniEmpleado) async {
    var url = Uri.http(baseUrl, 'api/task');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "employee": dniEmpleado,
          "day": _taskDay,
          "title": _tasktitle,
          "content": _taskcontent,
          "status": "Pendiente"
        }),
      );
      return response.statusCode == 201;
    } catch (error) {
      return false;
    }
  }

  // ----------------------------------------------------------
  Future<bool> putTask(String dniEmpleado) async {
    var url = Uri.http(baseUrl, 'api/task/$_id');
    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: dniEmpleado != ''
            ? jsonEncode({
                "employee": dniEmpleado,
                "day": _taskDay,
                "title": _tasktitle,
                "content": _taskcontent,
              })
            : jsonEncode({
                "day": _taskDay,
                "title": _tasktitle,
                "content": _taskcontent,
              }),
      );
      return response.statusCode == 200;
    } catch (error) {
      return false;
    }
  }

  // ----------------------------------------------------------
  Future<bool> deleteTask(String id) async {
    var url = Uri.http(baseUrl, 'api/task/$id');
    try {
      final response = await http.delete(url);
      return response.statusCode == 200;
    } catch (error) {
      return false;
    }
  }
}
