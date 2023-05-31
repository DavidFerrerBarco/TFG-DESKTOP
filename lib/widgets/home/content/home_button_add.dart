import 'package:flutter/material.dart';
import 'package:my_desktop_app/provider/provider.dart';
import 'package:my_desktop_app/theme/app_theme.dart';

import '../../widget.dart';

class HomeButtonOption extends StatelessWidget {
  final Function onOptionChanged;
  final String content;
  final String option;
  final HomeProvider homeProvider;

  const HomeButtonOption({
    super.key,
    required this.onOptionChanged,
    required this.content,
    required this.option,
    required this.homeProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      child: Padding(
          padding: const EdgeInsets.all(10),
          child: HomeContentButton(
            content: content,
            color: AppTheme.primary,
            borderColor: AppTheme.shadowGreen,
            offsetX: -6,
            offsetY: -6,
            width: 250,
            onOptionChanged: onOptionChanged,
            option: option,
            homeProvider: homeProvider,
          )),
    );
  }
}
