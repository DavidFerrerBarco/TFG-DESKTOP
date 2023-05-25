import 'package:flutter/material.dart';
import 'package:my_desktop_app/theme/app_theme.dart';

class HomeContent extends StatelessWidget {

  final String lockedOption;

  const HomeContent({
    super.key, 
    required this.lockedOption
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          lockedOption, 
          style: const TextStyle(
            color: AppTheme.primary,
            fontSize: 60
          ),
        ),
      ],
    );
  }
}