import 'package:flutter/material.dart';
import 'package:my_desktop_app/theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [ 
          Text('HOME')
        ], 
        backgroundColor: AppTheme.primary,
      ),
    );
  }
}