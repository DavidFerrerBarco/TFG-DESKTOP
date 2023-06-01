import 'package:flutter/material.dart';
import 'package:my_desktop_app/constants/constants.dart';
import 'package:my_desktop_app/provider/employee_provider.dart';
import 'package:my_desktop_app/widgets/widget.dart';
import 'package:provider/provider.dart';

class HomeAdminScreen extends StatelessWidget {
  const HomeAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeEmployeeProvider homeProvider =
        Provider.of<HomeEmployeeProvider>(context);

    void onLockedChanged(String newOption) {
      homeProvider.onLockedChanged(newOption);
      if (newOption == listaventanasadmin.last) {
        Navigator.pushReplacementNamed(context, 'login');
        homeProvider.onLockedChanged(listaventanasadmin[0]);
      }
    }

    return StreamBuilder<Object>(
      stream: homeProvider.lockedOption,
      initialData: listaventanasadmin[0],
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.only(left: 30, top: 30, bottom: 30),
              child: Row(
                children: [
                  HomeDrawer(
                    lockedOption: snapshot.data! as String,
                    onLockedChanged: onLockedChanged,
                    lista: listaventanasadmin,
                  ),
                  HomeContent(
                    lockedOption: snapshot.data! as String,
                    onLockedOption: onLockedChanged,
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Scaffold();
        }
      },
    );
  }
}
