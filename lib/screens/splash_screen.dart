import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_desktop_app/theme/app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Timer(const Duration(milliseconds: 2500), () {
      Navigator.pushReplacementNamed(context, 'home');
    } );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: AppTheme.primary,
        ),
      ),
    );
  }
}