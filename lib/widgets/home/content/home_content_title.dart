import 'package:flutter/material.dart';
import 'package:my_desktop_app/theme/app_theme.dart';

class HomeContentTitle extends StatelessWidget {
  const HomeContentTitle({
    super.key,
    required this.lockedOption,
  });

  final String lockedOption;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.bottomLeft,
          height: 100,
          child: Padding(
            padding: const EdgeInsets.only(left: 80),
            child: Text(
              lockedOption, 
              style: const TextStyle(
                color: AppTheme.primary,
                fontSize: 60,
                letterSpacing: 15,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    color: AppTheme.shadowGreen,
                    offset: Offset(-3, 3),
                    blurRadius: 1,
                  )
                ]
              ),
            ),
          ),
        ),
        const Divider(
          color: AppTheme.primary, 
          thickness: 3,
          height: 2,
        ),
      ],
    );
  }
}