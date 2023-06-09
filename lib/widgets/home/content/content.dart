import 'package:flutter/material.dart';
import 'package:my_desktop_app/constants/constants.dart';
import '../../widget.dart';

class HomeContent extends StatelessWidget {
  final String lockedOption;
  final Function onLockedOption;

  const HomeContent({
    super.key,
    required this.lockedOption,
    required this.onLockedOption,
  });

  Widget contentVista() {
    if (lockedOption == listaventanasdeveloper[0]) {
      return ContentCompany(
        onLockedOption: onLockedOption,
      );
    } else if (lockedOption == listaventanasdeveloper[1]) {
      return const ContentNews();
    } else if (lockedOption == listaventanasadmin[0]) {
      return const ContentEmployee();
    } else if (lockedOption == listaventanasadmin[1]) {
      return const ContentAnnouncement();
    } else if (lockedOption == listaventanasadmin[2]) {
      return const ContentSchedule();
    } else if (lockedOption == listaventanasadmin[3]) {
      return const ContentTask();
    } else if (lockedOption == listaventanasadmin[4]) {
      return const ContentRequests();
    } else if (lockedOption == listaventanasadmin[5]) {
      return const ContentStatistics();
    } else {
      return Container(color: Colors.black);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          HomeContentTitle(lockedOption: lockedOption),
          Expanded(
            child: contentVista(),
          ),
        ],
      ),
    );
  }
}
