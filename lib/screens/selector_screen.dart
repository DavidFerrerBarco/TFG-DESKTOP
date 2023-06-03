import 'package:flutter/material.dart';
import 'package:my_desktop_app/models/models.dart';
import 'package:my_desktop_app/provider/provider.dart';
import 'package:my_desktop_app/theme/app_theme.dart';
import 'package:provider/provider.dart';

class SelectorScreen extends StatelessWidget {
  const SelectorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginProvider loginProvider = Provider.of<LoginProvider>(context);
    final HomeEmployeeProvider employeeProvider =
        Provider.of<HomeEmployeeProvider>(context);
    return Scaffold(
      body: StreamBuilder<Employee>(
        stream: loginProvider.employee,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Selecciona el Modo:",
                    style: TextStyle(
                      color: AppTheme.primary,
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 100),
                  ElevatedButton(
                    onPressed: () {
                      loginProvider.setIsDeleveoper(true);
                      Navigator.pushNamed(context, 'homedeveloper');
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.developer_mode),
                          SizedBox(width: 20),
                          Text("MODO DESARROLLADOR")
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 60),
                  ElevatedButton(
                    onPressed: () {
                      loginProvider.setIsDeleveoper(false);
                      employeeProvider.setLockedCompany(snapshot.data!.company);
                      Navigator.pushNamed(context, 'homeadmin');
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.admin_panel_settings_rounded),
                          SizedBox(width: 20),
                          Text("MODO ADMIN")
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
