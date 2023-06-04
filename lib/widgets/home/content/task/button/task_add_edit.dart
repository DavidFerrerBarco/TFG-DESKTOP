import 'package:flutter/material.dart';
import 'package:my_desktop_app/provider/provider.dart';
import 'package:my_desktop_app/theme/app_theme.dart';
import 'package:my_desktop_app/widgets/home/content/task/button/task_button.dart';
import 'package:my_desktop_app/widgets/widget.dart';

class ButtonTaskOption extends StatelessWidget {
  final Function onOptionChanged;
  final String content;
  final String option;
  final TaskProvider taskProvider;

  const ButtonTaskOption({
    super.key,
    required this.onOptionChanged,
    required this.content,
    required this.option,
    required this.taskProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      child: Padding(
          padding: const EdgeInsets.all(10),
          child: TaskButton(
            content: content,
            color: AppTheme.primary,
            borderColor: AppTheme.shadowGreen,
            offsetX: -6,
            offsetY: -6,
            width: 250,
            onOptionChanged: onOptionChanged,
            option: option,
            taskProvider: taskProvider,
          )),
    );
  }
}
