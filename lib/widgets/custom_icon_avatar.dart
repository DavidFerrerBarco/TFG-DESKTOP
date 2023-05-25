import 'package:flutter/material.dart';
import 'package:my_desktop_app/theme/app_theme.dart';

class CircleIconAvatar extends StatelessWidget {

  final double radius;

  const CircleIconAvatar({
    super.key, 
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.white,
      child: Text(
        'DF',
        style: TextStyle(
          color: AppTheme.primary,
          fontSize: radius-10,
          shadows: const [
            Shadow(
              color: AppTheme.shadowGreen,
              offset: Offset(-1, 1),
              blurRadius: 1,
            )
          ],
        ),
      ),
    );
  }
}