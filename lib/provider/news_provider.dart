import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_desktop_app/constants/constants.dart';
import 'package:my_desktop_app/models/new_model.dart';
import 'package:my_desktop_app/models/news.dart';

import 'package:http/http.dart' as http;

class NewsProvider extends ChangeNotifier {
  String _vistaNoticias = listavistanoticias[0];

  Stream<String> get vistaNoticias async* {
    yield _vistaNoticias;
  }

  void onLockedNewsChanged(String newNewsOption) {
    _vistaNoticias = newNewsOption;
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

  // -------------------------------------------------

  String _id = '';

  Stream<String> get id async* {
    yield _id;
  }

  void setId(String newId) {
    _id = newId;
  }

  // -------------------------------------------------

  String _newtitle = '';

  Stream<String> get newtitle async* {
    yield _newtitle;
  }

  void addNewTitle(String anothertitle) {
    _newtitle = anothertitle;
  }

  // -------------------------------------------------

  String _newcontent = '';

  Stream<String> get newcontent async* {
    yield _newcontent;
  }

  void addNewContent(String anothercontent) {
    _newcontent = anothercontent;
  }

  // -------------------------------------------------

  void addAllNewData(String id, String title, String content) {
    setId(id);
    addNewTitle(title);
    addNewContent(content);
    notifyListeners();
  }

  void addDataPost(String title, String content) {
    addNewTitle(title);
    addNewContent(content);
  }

  void resetNewForm() {
    _newtitle = '';
    _newcontent = '';
  }

  // -------------------------------------------------
  Stream<List<News>> get newsData async* {
    await Future.delayed(const Duration(milliseconds: 200));
    var url = Uri.http(baseUrl, 'api/news');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final NewsModel newsModel = NewsModel.fromJson(response.body);
        yield newsModel.data;
      } else {
        yield <News>[];
      }
    } catch (error) {
      yield newsDefault;
    }
  }

  // -------------------------------------------------
  Future<bool> postNew() async {
    var url = Uri.http(baseUrl, 'api/news');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "title": _newtitle,
          "content": _newcontent,
        }),
      );
      return response.statusCode == 201;
    } catch (error) {
      return false;
    }
  }

  // -------------------------------------------------
  Future<bool> putNew() async {
    var url = Uri.http(baseUrl, 'api/news/$_id');

    try {
      final reponse = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "title": _newtitle,
          "content": _newcontent,
        }),
      );

      return reponse.statusCode == 200;
    } catch (error) {
      return false;
    }
  }

  // -------------------------------------------------
  Future<bool> deleteNew(String id) async {
    var url = Uri.http(baseUrl, 'api/news/$id');

    try {
      final response = await http.delete(url);

      return response.statusCode == 200;
    } catch (error) {
      return false;
    }
  }
}
