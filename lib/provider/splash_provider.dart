import 'dart:async';

import 'package:flutter/material.dart';

class SplashProvider extends ChangeNotifier{

  Stream<bool> get loading async* {
    await Future.delayed( const Duration( seconds: 2 ) );
    yield true;
  } 
}