import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_desktop_app/constants/constants.dart';
import 'package:my_desktop_app/models/models.dart';

class RequestProvider extends ChangeNotifier {
  String _vistaSolicitud = listavistasolicitudes[0];

  Stream<String> get vistaSolicitud async* {
    yield _vistaSolicitud;
  }

  void onLockedChanged(String newRequestOption) {
    _vistaSolicitud = newRequestOption;
    notifyListeners();
  }

  // -------------------------------------------------

  String _requesttitle = '';

  Stream<String> get requesttitle async* {
    yield _requesttitle;
  }

  void addRequestTitle(String anothertitle) {
    _requesttitle = anothertitle;
  }

  // -------------------------------------------------

  String _requestcontent = '';

  Stream<String> get requestcontent async* {
    yield _requestcontent;
  }

  void addRequestContent(String anothercontent) {
    _requestcontent = anothercontent;
  }

  // -------------------------------------------------

  void setData(String title, String content) {
    addRequestTitle(title);
    addRequestContent(content);
    notifyListeners();
  }

  // -------------------------------------------------
  Stream<List<Request>> requestData(String company) async* {
    await Future.delayed(const Duration(milliseconds: 200));
    String validCompany = company.replaceAll(' ', '-');
    var url = Uri.http(baseUrl, 'api/request/company/$validCompany');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final RequestModel requestModel = RequestModel.fromJson(response.body);
        yield requestModel.data;
      } else {
        yield <Request>[];
      }
    } catch (error) {
      yield [defaultrequest];
    }
  }

  // --------------------------------------------------
  Future<bool> deleteRequest(String id) async {
    var url = Uri.http(baseUrl, 'api/request/$id');
    try {
      final response = await http.delete(url);
      return response.statusCode == 200;
    } catch (error) {
      return false;
    }
  }
}
