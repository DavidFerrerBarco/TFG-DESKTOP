import 'package:flutter/material.dart';
import 'package:my_desktop_app/theme/app_theme.dart';

class CustomErrorMessage extends StatelessWidget {
  const CustomErrorMessage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'ERROR EN LA RED :(',
        style: TextStyle(
          color: AppTheme.primary,
          fontSize: 30,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
