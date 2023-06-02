import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_desktop_app/constants/constants.dart';
import 'package:my_desktop_app/models/models.dart';
import 'package:http/http.dart' as http;

class HomeEmployeeProvider extends ChangeNotifier {
  String _lockedOption = listaventanasadmin[0];

  Stream<String> get lockedOption async* {
    yield _lockedOption;
  }

  void onLockedChanged(String newOption) {
    _lockedOption = newOption;
    notifyListeners();
  }

  // -------------------------------------------------

  bool _create = true;

  Stream<bool> get create async* {
    yield _create;
  }

  void isCreate(bool isnewcreate) {
    _create = isnewcreate;
  }

  // -----------------------------------------------------

  String _employeeid = '';

  Stream<String> get employeeid async* {
    yield _employeeid;
  }

  void setEmployeeId(String newEmployeeId) {
    _employeeid = newEmployeeId;
  }

  // -----------------------------------------------------

  String _employeename = '';

  Stream<String> get employeename async* {
    yield _employeename;
  }

  void setEmployeeName(String newEmployeeName) {
    _employeename = newEmployeeName;
  }

  // ----------------------------------------------------
  String _employeedni = '';

  Stream<String> get employeedni async* {
    yield _employeedni;
  }

  void setEmployeeDni(String newEmployeeDni) {
    _employeedni = newEmployeeDni;
  }

  //-----------------------------------------------------
  int _employeecontract = 0;

  Stream<int> get employeecontract async* {
    yield _employeecontract;
  }

  void setEmployeeContract(int newEmployeeContract) {
    _employeecontract = newEmployeeContract;
    notifyListeners();
  }

  // ----------------------------------------------------
  void addAllEmployeeData(String id, String name, String dni, int contract) {
    setEmployeeId(id);
    setEmployeeName(name);
    setEmployeeDni(dni);
    setEmployeeContract(contract);
    notifyListeners();
  }

  void addEmployeeDataPost(String name, String dni, int contract) {
    setEmployeeName(name);
    setEmployeeDni(dni);
    setEmployeeContract(contract);
  }

  void resetEmployeeForm() {
    _employeename = '';
    _employeedni = '';
    _employeecontract = 0;
    notifyListeners();
  }

  // -------------------------------------------

  String _lockedEmployeeView = listavistaempleado[0];

  Stream<String> get lockedEmployeeView async* {
    yield _lockedEmployeeView;
  }

  void onLockedEmployeeViewChanged(String newEmployeeView) {
    _lockedEmployeeView = newEmployeeView;
    notifyListeners();
  }

  // -----------------------------------------
  String _lockedCompany = developercompany;

  Stream<String> get lockedCompany async* {
    yield _lockedCompany;
  }

  void setLockedCompany(String newCompany) {
    _lockedCompany = newCompany;
  }

  // --------------------------------------------
  Stream<List<Employee>> get employeesData async* {
    await Future.delayed(const Duration(milliseconds: 200));
    String validCompany = _lockedCompany.replaceAll(' ', '-');

    var url = Uri.http(baseUrl, 'api/employee/company/$validCompany');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final EmployeeModel employeeModel =
            EmployeeModel.fromJson(response.body);
        yield employeeModel.data;
      } else {
        yield <Employee>[];
      }
    } catch (error) {
      yield [defaultemployee];
    }
  }

  // ---------------------------------------------
  Stream<Company> get companyData async* {
    String validCompany = _lockedCompany.replaceAll(' ', '-');

    var url = Uri.http(baseUrl, 'api/company/name/$validCompany');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final CompanyModel companyModel = CompanyModel.fromJson(response.body);
        yield companyModel.data[0];
      } else {
        yield companydefault;
      }
    } catch (error) {
      yield companydefault;
    }
  }

  // --------------------------------------------
  Future<bool> putAdmin(String id, bool newAdminValue) async {
    var url = Uri.http(baseUrl, 'api/employee/$id');

    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "admin": newAdminValue,
        }),
      );

      return response.statusCode == 200;
    } catch (error) {
      return false;
    }
  }

  //--------------------------------------------
  Future<bool> deleteEmployee(String id) async {
    var url = Uri.http(baseUrl, 'api/employee/$id');

    try {
      final response = await http.delete(url);
      return response.statusCode == 200;
    } catch (error) {
      return false;
    }
  }
}
