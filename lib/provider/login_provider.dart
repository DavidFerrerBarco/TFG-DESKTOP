import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_desktop_app/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:my_desktop_app/models/models.dart';

class LoginProvider extends ChangeNotifier {
  CustomError _error = defaulterror;

  Stream<CustomError> get error async* {
    yield _error;
  }

  void setError(CustomError newError) {
    _error = newError;
    notifyListeners();
  }

  void resetError() {
    _error = defaulterror;
  }

  // ----------------------------------------------------------

  Employee _employee = defaultemployee;

  Stream<Employee> get employee async* {
    yield _employee;
  }

  void setEmployee(Employee newEmployee) {
    _employee = newEmployee;
    notifyListeners();
  }

  // ----------------------------------------------------------

  Future<bool> loginAdmin(String dni, String password) async {
    var url = Uri.http(baseUrl, 'api/employee/login/admin');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "DNI": dni,
          "password": password,
        }),
      );
      if (response.statusCode != 200) {
        final ErrorModel errorResponse = ErrorModel.fromJson(response.body);
        setError(errorResponse.data[0]);
        return false;
      } else {
        final EmployeeModel employeeResponse =
            EmployeeModel.fromJson(response.body);
        resetError();
        setEmployee(employeeResponse.data[0]);
        return true;
      }
    } catch (error) {
      return false;
    }
  }
}
