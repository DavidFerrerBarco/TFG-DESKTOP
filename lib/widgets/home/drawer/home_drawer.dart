import 'package:flutter/material.dart';
import 'package:my_desktop_app/theme/app_theme.dart';

import '../../widget.dart';

class HomeDrawer extends StatelessWidget {
  final String lockedOption;
  final Function onLockedChange;
  const HomeDrawer({
    super.key, 
    required this.lockedOption, 
    required this.onLockedChange,
  });

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    double radius = 40;
    return Container(
      width: size.width/5,
      height: size.height,
      decoration: BoxDecoration(
        color: AppTheme.primary,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: const [
          BoxShadow(
            offset: Offset(-13,10),
            color: AppTheme.shadowGreen,
          ),
          BoxShadow(
            offset: Offset(-10,9),
            color: AppTheme.shadowGreen,
          ),
          BoxShadow(
            offset: Offset(-8,8),
            color: AppTheme.shadowGreen,
          ),
          BoxShadow(
            offset: Offset(-13,3),
            color: AppTheme.shadowGreen,
          ),
        ],
      ),
      child: HomeDrawerContent(
        lockedOption: lockedOption,
        onLockedChange: onLockedChange,
      ),
    );
        
  }
}
