import 'package:flutter/material.dart';
import 'package:my_desktop_app/theme/app_theme.dart';

import '../../widget.dart';

class HomeButtonAdd extends StatelessWidget {
  const HomeButtonAdd({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      child: const Padding(
        padding: EdgeInsets.all(10),
        child: HomeContentButton(
          content: 'Añadir Empresa',
          color: AppTheme.primary,
          borderColor: AppTheme.shadowGreen,
          offsetX: -6,
          offsetY: -6,
          width: 250,
        )
      ),
    );
  }
}