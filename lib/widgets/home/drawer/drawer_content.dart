import 'package:flutter/material.dart';
import 'package:my_desktop_app/theme/app_theme.dart';
import '../../widget.dart';

class HomeDrawerContent extends StatelessWidget {
  final String lockedOption;
  final Function onLockedChange;
  final List<String> listaOptiones;
  const HomeDrawerContent({
    super.key,
    required this.lockedOption,
    required this.onLockedChange,
    required this.listaOptiones,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const HomeDrawerProfileData(),
          const SizedBox(height: 20),
          SingleChildScrollView(
            child: Flex(
              direction: Axis.vertical,
              children: [
                ListView.separated(
                  itemCount: listaOptiones.length - 1,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 20);
                  },
                  itemBuilder: (context, index) {
                    return HomeDrawerItem(
                      content: listaOptiones[index],
                      color: AppTheme.primary,
                      borderColor: AppTheme.shadowGreen,
                      lockedOption: lockedOption,
                      onLockedChange: onLockedChange,
                      offsetX: 6,
                      offsetY: -6,
                    );
                  },
                )
              ],
            ),
          ),
          const Spacer(),
          HomeDrawerItem(
            content: listaOptiones.last,
            color: AppTheme.redColor,
            borderColor: AppTheme.redColor,
            lockedOption: lockedOption,
            onLockedChange: onLockedChange,
            offsetX: 6,
            offsetY: -6,
          ),
        ],
      ),
    );
  }
}
