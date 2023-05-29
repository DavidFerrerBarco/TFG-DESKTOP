import 'dart:convert';

import '../models/models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_desktop_app/constants/constants.dart';

class HomeProvider extends ChangeNotifier{
  String _lockedOption = listaventanas[0];

  Stream<String> get lockedOption async* {
    yield _lockedOption;
  }

  void onLockedChanged(String newOption){
    _lockedOption = newOption;
    notifyListeners();
  }

  // ------------------------------------------
  String _vistaEmpresas = listavistaempresa[0];

  Stream<String> get vistaEmpresa async* {
    yield _vistaEmpresas;
  }

  void onLockedCompanyChanged(String newCompanyOption){
    _vistaEmpresas = newCompanyOption;
    notifyListeners();
  }
  // ------------------------------------------
  List<int> _listahoras = <int>[];

  Stream<List<int>> get listahoras async* {
    yield _listahoras;
  }

  void addToHourList(String name, String address, int hours){
    addCompanyName(name);
    addCompanyAddress(address);
    _listahoras.add(hours);
    notifyListeners();
  }

  void removeHourToTheList(String name, String address, int hours){
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

  void addCompanyName(String newcompanyname){
    _companyname = newcompanyname;
  }
  // ------------------------------------------
  String _companyaddress = '';

  Stream<String> get companyaddress async* {
    yield _companyaddress;
  }

  void addCompanyAddress(String newcompanyaddres){
    _companyaddress = newcompanyaddres;
  }
  // ------------------------------------------

  void resetCompanyForm(){
    _companyname = '';
    _companyaddress = '';
    _listahoras = <int>[];
  }

  // ------------------------------------------
  Stream<List<Company>> get companiesData async* {
    await Future.delayed(const Duration(milliseconds: 200));
    var url = Uri.http(baseUrl, 'api/company');
    try{
      final response = await http.get(url);
      if(response.statusCode == 200){
        final CompanyModel companyReponse = CompanyModel.fromJson(response.body);
        yield companyReponse.data;

      }else{
        yield <Company>[];
      }
    }catch(error){
      yield companiesDefault;
    }
  }

  // ------------------------------------------
  Future<bool> postCompany( ) async {
    var url = Uri.http(baseUrl, 'api/company');
    try{
      final response = await http.post(
        url,
        headers: {
        'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {
            "name": _companyname,
            "address": _companyaddress,
            "contractTypes": _listahoras
          }
        ),
      );
      return response.statusCode == 201;
    }catch(error){
      return false;
    }
  }
}