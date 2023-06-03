import 'package:flutter/material.dart';
import 'package:my_desktop_app/constants/constants.dart';
import 'package:my_desktop_app/models/employee.dart';
import 'package:my_desktop_app/provider/announcement_provider.dart';
import 'package:my_desktop_app/provider/login_provider.dart';
import 'package:my_desktop_app/theme/app_theme.dart';
import 'package:my_desktop_app/widgets/widget.dart';
import 'package:provider/provider.dart';

class ContentAnnouncementData extends StatelessWidget {
  final AnnouncementProvider announcementProvider;
  final Function onOptionChanged;

  const ContentAnnouncementData({
    super.key,
    required this.announcementProvider,
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
            stream: announcementProvider.announcementData(
              employeeLogged.company,
              employeeLogged.token!,
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                if (snapshot.data! == [defaultannouncement]) {
                  return const CustomErrorMessage();
                } else {
                  AnnouncementDataSource announcementDataSource =
                      AnnouncementDataSource(
                    announcementData: snapshot.data!,
                    announcementProvider: announcementProvider,
                    onOptionChanged: onOptionChanged,
                  );

                  return Column(
                    children: [
                      ButtonAnnouncementOption(
                        announcementProvider: announcementProvider,
                        content: 'Añadir Anuncio',
                        option: listavistaanuncios[1],
                        onOptionChanged: onOptionChanged,
                      ),
                      GridDataAnnouncement(
                        announcementDataSource: announcementDataSource,
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
