import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:my_desktop_app/provider/provider.dart';
import 'package:my_desktop_app/theme/app_theme.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final SplashProvider splashProvider = Provider.of<SplashProvider>(context);
    return StreamBuilder(
      stream: splashProvider.loading,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          SchedulerBinding.instance.addPostFrameCallback((_) { 
            Navigator.pushReplacementNamed(context, 'home');
          });
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(
              color: AppTheme.primary,
            ),
          ),
        );
      }
    );
  }
}