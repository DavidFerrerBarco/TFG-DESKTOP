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
}