import 'package:flutter/material.dart';
import 'package:my_desktop_app/constants/constants.dart';
import 'package:my_desktop_app/provider/tasks_provider.dart';
import 'package:my_desktop_app/widgets/widget.dart';
import 'package:provider/provider.dart';

class ContentTask extends StatelessWidget {
  const ContentTask({super.key});

  @override
  Widget build(BuildContext context) {
    final TaskProvider taskProvider = Provider.of<TaskProvider>(context);

    void onTaskChanged(String newTaskOption) {
      taskProvider.onLockedTaskChanged(newTaskOption);
    }

    Widget taskView(String vista) {
      if (vista == listavistatareas[0]) {
        return ContentTaskData(
          taskProvider: taskProvider,
          onOptionChanged: onTaskChanged,
        );
      } else if (vista == listavistatareas[1]) {
        return ContentTaskAddPut(
          taskProvider: taskProvider,
          onOptionChanged: onTaskChanged,
        );
      } else {
        return Container();
      }
    }

    return StreamBuilder(
      stream: taskProvider.vistaTareas,
      initialData: listavistatareas[0],
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(child: taskView(snapshot.data!));
        } else {
          return Container();
        }
      },
    );
  }
}
