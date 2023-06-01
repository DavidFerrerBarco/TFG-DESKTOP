import 'package:flutter/material.dart';
import 'package:my_desktop_app/constants/constants.dart';

class HomeEmployeeProvider extends ChangeNotifier {
  String _lockedOption = listaventanasadmin[0];

  Stream<String> get lockedOption async* {
    yield _lockedOption;
  }

  void onLockedChanged(String newOption) {
    _lockedOption = newOption;
    notifyListeners();
  }
}
