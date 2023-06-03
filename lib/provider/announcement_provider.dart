import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_desktop_app/constants/constants.dart';
import 'package:my_desktop_app/models/models.dart';

import 'package:http/http.dart' as http;

class AnnouncementProvider extends ChangeNotifier {
  String _vistaAnuncios = listavistaanuncios[0];

  Stream<String> get vistaAnuncios async* {
    yield _vistaAnuncios;
  }

  void onLockedAnnouncementChanged(String newAnnouncementOption) {
    _vistaAnuncios = newAnnouncementOption;
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

  String _announcementtitle = '';

  Stream<String> get announcementtitle async* {
    yield _announcementtitle;
  }

  void addAnnouncementTitle(String anothertitle) {
    _announcementtitle = anothertitle;
  }

  // -------------------------------------------------

  String _announcementcontent = '';

  Stream<String> get announcementcontent async* {
    yield _announcementcontent;
  }

  void addAnnouncementContent(String anothercontent) {
    _announcementcontent = anothercontent;
  }

  // -------------------------------------------------

  void addAllAnnouncementData(String id, String title, String content) {
    setId(id);
    addAnnouncementTitle(title);
    addAnnouncementContent(content);
    notifyListeners();
  }

  void addDataPost(String title, String content) {
    addAnnouncementTitle(title);
    addAnnouncementContent(content);
  }

  void resetAnnouncementForm() {
    _announcementtitle = '';
    _announcementcontent = '';
  }

  // --------------------------------------------------

  Stream<List<Announcement>> announcementData(
    String company,
    String token,
  ) async* {
    await Future.delayed(const Duration(milliseconds: 200));
    String validCompany = company.replaceAll(' ', '-');
    var url = Uri.http(baseUrl, 'api/announcement/company/$validCompany');
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final AnnouncementModel announcementModel =
            AnnouncementModel.fromJson(response.body);
        yield announcementModel.data;
      }
    } catch (error) {
      yield [defaultannouncement];
    }
  }
  // --------------------------------------------------

  Future<bool> postAnnouncement(String company) async {
    var url = Uri.http(baseUrl, 'api/announcement');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "title": _announcementtitle,
          "content": _announcementcontent,
          "company": company,
        }),
      );

      return response.statusCode == 201;
    } catch (error) {
      return false;
    }
  }

  // -------------------------------------------------

  Future<bool> putAnnouncement(String company) async {
    var url = Uri.http(baseUrl, 'api/announcement/$_id');

    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "title": _announcementtitle,
          "content": _announcementcontent,
          "company": company,
        }),
      );

      return response.statusCode == 200;
    } catch (error) {
      return false;
    }
  }

  // --------------------------------------------------
  Future<bool> deleteAnnouncement(String id) async {
    var url = Uri.http(baseUrl, 'api/announcement/$id');

    try {
      final response = await http.delete(url);

      return response.statusCode == 200;
    } catch (error) {
      return false;
    }
  }
}
