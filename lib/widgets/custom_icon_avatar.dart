import 'package:flutter/material.dart';
import 'package:my_desktop_app/theme/app_theme.dart';

class CircleIconAvatar extends StatelessWidget {
  final double radius;

  const CircleIconAvatar({
    super.key,
    required this.radius,
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    String letters = name.split(' ').length > 1
        ? '${name.split(' ')[0].substring(0, 1)}${name.split(' ')[1].substring(0, 1)}'
        : name.split(' ')[0].substring(0, 1);
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.white,
      child: Text(
        letters,
        style: TextStyle(
          color: AppTheme.primary,
          fontSize: radius - 10,
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
