import 'dart:convert';

import '../models/models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_desktop_app/constants/constants.dart';

class HomeCompanyProvider extends ChangeNotifier {
  String _lockedOption = listaventanasdeveloper[0];

  Stream<String> get lockedOption async* {
    yield _lockedOption;
  }

  void onLockedChanged(String newOption) {
    _lockedOption = newOption;
    notifyListeners();
  }

  // ------------------------------------------
  String _vistaEmpresas = listavistaempresa[0];

  Stream<String> get vistaEmpresa async* {
    yield _vistaEmpresas;
  }

  void onLockedCompanyChanged(String newCompanyOption) {
    _vistaEmpresas = newCompanyOption;
    notifyListeners();
  }

  // -----------------------------------------
  bool _create = true;

  Stream<bool> get create async* {
    yield _create;
  }

  void isCreate(bool isnewcreate) {
    _create = isnewcreate;
  }

  // -----------------------------------------
  String _id = "";

  Stream<String> get id async* {
    yield _id;
  }

  void setId(String newId) {
    _id = newId;
  }

  // ------------------------------------------
  List<int> _listahoras = <int>[];

  Stream<List<int>> get listahoras async* {
    yield _listahoras;
  }

  void addToHourList(String name, String address, int hours) {
    addCompanyName(name);
    addCompanyAddress(address);
    _listahoras.add(hours);
    notifyListeners();
  }

  void addAnHourList(List<int> newHourList) {
    _listahoras = newHourList;
    notifyListeners();
  }

  void removeHourToTheList(String name, String address, int hours) {
    addCompanyName(name);
    addCompanyAddress(address);
    _listahoras.removeAt(_listahoras.indexOf(hours));
    notifyListeners();
  }

  // ------------------------------------------
  String _companyname = '';

  Stream<String> get companyname async* {
    yield _companyname;
  }

  void addCompanyName(String newcompanyname) {
    _companyname = newcompanyname;
  }

  // ------------------------------------------
  String _companyaddress = '';

  Stream<String> get companyaddress async* {
    yield _companyaddress;
  }

  void addCompanyAddress(String newcompanyaddres) {
    _companyaddress = newcompanyaddres;
  }
  // ------------------------------------------

  void resetCompanyForm() {
    _companyname = '';
    _companyaddress = '';
    _listahoras = <int>[];
  }

  // ------------------------------------------
  Stream<List<Company>> get companiesData async* {
    await Future.delayed(const Duration(milliseconds: 200));
    var url = Uri.http(baseUrl, 'api/company');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final CompanyModel companyReponse =
            CompanyModel.fromJson(response.body);
        yield companyReponse.data;
      } else {
        yield <Company>[];
      }
    } catch (error) {
      yield companiesDefault;
    }
  }

  // ------------------------------------------

  Future<bool> postCompany() async {
    var url = Uri.http(baseUrl, 'api/company');
    try {
      if (_listahoras.isNotEmpty) {
        final response = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            "name": _companyname,
            "address": _companyaddress,
            "contractTypes": _listahoras
          }),
        );
        return response.statusCode == 201;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }

  // ------------------------------------------

  Future<bool> deleteCompany(String id) async {
    var url = Uri.http(baseUrl, 'api/company/$id');

    try {
      final response = await http.delete(url);

      return response.statusCode == 200;
    } catch (error) {
      return false;
    }
  }

  // ------------------------------------------

  Future<bool> putCompany() async {
    var url = Uri.http(baseUrl, 'api/company/$_id');

    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "name": _companyname,
          "address": _companyaddress,
          "contractTypes": _listahoras
        }),
      );

      return response.statusCode == 200;
    } catch (error) {
      return false;
    }
  }
}
