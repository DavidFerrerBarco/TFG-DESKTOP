import 'package:flutter/material.dart';
import 'package:my_desktop_app/constants/constants.dart';
import 'package:my_desktop_app/provider/provider.dart';
import 'package:my_desktop_app/widgets/widget.dart';
import 'package:provider/provider.dart';

class ContentEmployee extends StatelessWidget {
  const ContentEmployee({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeEmployeeProvider employeeProvider =
        Provider.of<HomeEmployeeProvider>(context);

    void onEmployeeViewChanged(String newView) {
      employeeProvider.onLockedEmployeeViewChanged(newView);
    }

    Widget employeeViews(String vista, String company) {
      if (vista == listavistaempleado[0]) {
        return ContentEmployeesData(
          employeeProvider: employeeProvider,
          company: company,
          onOptionChanged: onEmployeeViewChanged,
        );
      } else if (vista == listavistaempleado[1]) {
        return ContentEmployeeAddPut(
          employeeProvider: employeeProvider,
          onOptionChanged: onEmployeeViewChanged,
        );
      } else {
        return Container(color: Colors.black);
      }
    }

    return StreamBuilder<String>(
      stream: employeeProvider.lockedCompany,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final company = snapshot.data!;

          return StreamBuilder(
            stream: employeeProvider.lockedEmployeeView,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final vista = snapshot.data!;
                return Container(child: employeeViews(vista, company));
              } else {
                return Container();
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
