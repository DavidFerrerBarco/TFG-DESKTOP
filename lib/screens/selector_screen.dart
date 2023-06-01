import 'package:flutter/material.dart';
import 'package:my_desktop_app/theme/app_theme.dart';

class SelectorScreen extends StatelessWidget {
  const SelectorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                Navigator.pushNamed(context, 'homedeveloper');
              },
              child: const Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.developer_mode),
                    SizedBox(width: 20),
                    Text("MODO DESARROLADOR")
                  ],
                ),
              ),
            ),
            const SizedBox(height: 60),
            ElevatedButton(
              onPressed: () {
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
      ),
    );
  }
}
