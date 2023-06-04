import 'package:flutter/material.dart';
import 'package:my_desktop_app/constants/constants.dart';
import 'package:my_desktop_app/models/models.dart';
import 'package:my_desktop_app/provider/provider.dart';
import 'package:my_desktop_app/theme/app_theme.dart';
import 'package:my_desktop_app/widgets/widget.dart';
import 'package:provider/provider.dart';

class ContentTaskData extends StatelessWidget {
  final TaskProvider taskProvider;
  final Function onOptionChanged;
  const ContentTaskData({
    super.key,
    required this.taskProvider,
    required this.onOptionChanged,
  });

  @override
  Widget build(BuildContext context) {
    LoginProvider loginProvider = Provider.of<LoginProvider>(context);

    return StreamBuilder(
      stream: loginProvider.employee,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Employee employeeLogged = snapshot.data!;
          return StreamBuilder(
            stream: taskProvider.taskData(employeeLogged.company),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                if (snapshot.data! == [defaulttask]) {
                  return const CustomErrorMessage();
                } else {
                  TaskDataSource taskDataSource = TaskDataSource(
                    taskData: snapshot.data!,
                    taskProvider: taskProvider,
                    onOptionChanged: onOptionChanged,
                  );

                  return Column(
                    children: [
                      ButtonTaskOption(
                        onOptionChanged: onOptionChanged,
                        content: 'Añadir Tarea',
                        option: listavistahorario[1],
                        taskProvider: taskProvider,
                      ),
                      GridDataTask(
                        taskDataSource: taskDataSource,
                      ),
                    ],
                  );
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppTheme.primary,
                  ),
                );
              }
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}
