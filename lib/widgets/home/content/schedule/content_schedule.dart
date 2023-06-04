import 'package:flutter/material.dart';
import 'package:my_desktop_app/constants/constants.dart';
import 'package:my_desktop_app/provider/schedule_provider.dart';
import 'package:my_desktop_app/widgets/home/content/schedule/content_schedule_data.dart';
import 'package:my_desktop_app/widgets/widget.dart';
import 'package:provider/provider.dart';

class ContentSchedule extends StatelessWidget {
  const ContentSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    final ScheduleProvider scheduleProvider =
        Provider.of<ScheduleProvider>(context);

    void onScheduleChanged(String newScheduleOption) {
      scheduleProvider.onLockedScheduleChanged(newScheduleOption);
    }

    Widget scheduleView(String vista) {
      if (vista == listavistahorario[0]) {
        return ContentScheduleData(
          scheduleProvider: scheduleProvider,
          onOptionChanged: onScheduleChanged,
        );
      } else if (vista == listavistahorario[1]) {
        return ContentScheduleAddPut(
          scheduleProvider: scheduleProvider,
          onOptionChanged: onScheduleChanged,
        );
      } else {
        return Container();
      }
    }

    return StreamBuilder(
      stream: scheduleProvider.vistaHorario,
      initialData: listavistahorario[0],
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(child: scheduleView(snapshot.data!));
        } else {
          return Container();
        }
      },
    );
  }
}
