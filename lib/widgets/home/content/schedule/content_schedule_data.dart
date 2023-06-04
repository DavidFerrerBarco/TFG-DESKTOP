import 'package:flutter/material.dart';
import 'package:my_desktop_app/constants/constants.dart';
import 'package:my_desktop_app/models/employee.dart';
import 'package:my_desktop_app/provider/provider.dart';
import 'package:my_desktop_app/theme/app_theme.dart';
import 'package:my_desktop_app/widgets/widget.dart';
import 'package:provider/provider.dart';

class ContentScheduleData extends StatelessWidget {
  final ScheduleProvider scheduleProvider;
  final Function onOptionChanged;

  const ContentScheduleData({
    super.key,
    required this.scheduleProvider,
    required this.onOptionChanged,
  });

  @override
  Widget build(BuildContext context) {
    LoginProvider loginProvider = Provider.of<LoginProvider>(context);

    return StreamBuilder<Employee>(
      stream: loginProvider.employee,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Employee employeeLogged = snapshot.data!;
          return StreamBuilder(
            stream: scheduleProvider.scheduleData(employeeLogged.company),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                if (snapshot.data! == [defaultschedule]) {
                  return const CustomErrorMessage();
                } else {
                  ScheduleDataSource scheduleDataSource = ScheduleDataSource(
                    scheduleData: snapshot.data!,
                    scheduleProvider: scheduleProvider,
                    onOptionChanged: onOptionChanged,
                  );

                  return Column(
                    children: [
                      ButtonScheduleOption(
                        onOptionChanged: onOptionChanged,
                        content: 'Añadir Horario',
                        option: listavistahorario[1],
                        scheduleProvider: scheduleProvider,
                      ),
                      GridDataSchedule(
                        scheduleDataSource: scheduleDataSource,
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
