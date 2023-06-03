import 'package:flutter/material.dart';
import 'package:my_desktop_app/constants/constants.dart';
import 'package:my_desktop_app/provider/announcement_provider.dart';
import 'package:my_desktop_app/widgets/home/content/announcement/content_announcement_add_put.dart';
import 'package:my_desktop_app/widgets/home/content/announcement/content_announcement_data.dart';
import 'package:provider/provider.dart';

class ContentAnnouncement extends StatelessWidget {
  const ContentAnnouncement({super.key});

  @override
  Widget build(BuildContext context) {
    final AnnouncementProvider announcementProvider =
        Provider.of<AnnouncementProvider>(context);

    void onAnnouncementChanged(String newAnouncementOption) {
      announcementProvider.onLockedAnnouncementChanged(newAnouncementOption);
    }

    Widget announcementViews(String vista) {
      if (vista == listavistaanuncios[0]) {
        return ContentAnnouncementData(
          announcementProvider: announcementProvider,
          onOptionChanged: onAnnouncementChanged,
        );
      } else if (vista == listavistaanuncios[1]) {
        return ContentAnnouncementAddPut(
          announcementProvider: announcementProvider,
          onOptionChanged: onAnnouncementChanged,
        );
      } else {
        return Container();
      }
    }

    return StreamBuilder(
      stream: announcementProvider.vistaAnuncios,
      initialData: listavistaanuncios[0],
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(child: announcementViews(snapshot.data!));
        } else {
          return Container();
        }
      },
    );
  }
}
