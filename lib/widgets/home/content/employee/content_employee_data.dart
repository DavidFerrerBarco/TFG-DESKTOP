import 'package:flutter/material.dart';
import 'package:my_desktop_app/constants/constants.dart';
import 'package:my_desktop_app/models/models.dart';
import 'package:my_desktop_app/provider/provider.dart';
import 'package:my_desktop_app/theme/app_theme.dart';
import 'package:my_desktop_app/widgets/widget.dart';
import 'package:provider/provider.dart';

class ContentEmployeesData extends StatelessWidget {
  final HomeEmployeeProvider employeeProvider;
  final String company;
  final Function onOptionChanged;

  const ContentEmployeesData({
    super.key,
    required this.employeeProvider,
    required this.company,
    required this.onOptionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: employeeProvider.employeesData,
      initialData: const <Employee>[],
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          if (snapshot.data! == [defaultemployee]) {
            return const CustomErrorMessage();
          } else {
            final LoginProvider loginProvider =
                Provider.of<LoginProvider>(context);

            EmployeeDataSource employeeDataSource = EmployeeDataSource(
              employeesData: snapshot.data!,
              employeeProvider: employeeProvider,
              loginProvider: loginProvider,
              onOptionChanged: onOptionChanged,
            );

            return Column(
              children: [
                ButtonEmployeeOption(
                  onOptionChanged: onOptionChanged,
                  content: "Añadir Empleado",
                  option: listavistaempleado[1],
                  employeeProvider: employeeProvider,
                ),
                GridDataEmployee(employeeDataSource: employeeDataSource),
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
  }
}
