import 'package:flutter/material.dart';
import 'package:my_desktop_app/theme/app_theme.dart';

import 'screens/screen.dart';

// void main() => runApp(const AppState());

// class AppState extends StatelessWidget {
//   const AppState({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(providers: [], child: const MyApp(),);
//   }
// }

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Employee Diary',
      initialRoute: 'login',
      routes: {
        'login': (_) => const LoginScreen(),
        'home': (_) => const HomeScreen(),
      },
      theme: AppTheme.lightTheme,
    );
  }
}