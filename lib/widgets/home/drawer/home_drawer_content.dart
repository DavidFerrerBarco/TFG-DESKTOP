import 'package:flutter/material.dart';
import 'package:my_desktop_app/theme/app_theme.dart';
import '../../widget.dart';

class HomeDrawerContent extends StatelessWidget {

  final String lockedOption;
  final Function onLockedChange;
  const HomeDrawerContent({
    super.key, 
    required this.lockedOption, 
    required this.onLockedChange, 
  });


  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const HomeDrawerProfileData(),
          const SizedBox(height: 30),
          SingleChildScrollView(
            child: Flex(
              direction: Axis.vertical,
              children: [
                HomeDrawerItem(
                  content: 'EMPRESAS', 
                  color: AppTheme.primary,
                  borderColor: AppTheme.shadowGreen,
                  lockedOption: lockedOption,
                  onLockedChange: onLockedChange,
                ),
                const SizedBox(height: 30),
                HomeDrawerItem(
                  content: 'NOTICIAS', 
                  color: AppTheme.primary,
                  borderColor: AppTheme.shadowGreen,
                  lockedOption: lockedOption,
                  onLockedChange: onLockedChange,
                ),
                const SizedBox(height: 30),
                HomeDrawerItem(
                  content: 'ESTADÍSTICAS', 
                  color: AppTheme.primary,
                  borderColor: AppTheme.shadowGreen,
                  lockedOption: lockedOption,
                  onLockedChange: onLockedChange,
                ),
              ],
            ),
          ),
          const Spacer(),
          HomeDrawerItem(
            content: 'CERRAR SESIÓN', 
            color: AppTheme.redColor,
            borderColor: AppTheme.redColor,
            lockedOption: lockedOption,
            onLockedChange: onLockedChange,
          ),
        ],
      ),
    );
  }
}
