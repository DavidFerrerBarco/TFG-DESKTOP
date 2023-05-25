import 'package:flutter/material.dart';
import '../widgets/widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String lockedOption = 'EMPRESAS';

  void onLockedChange(String newLocked){
    setState(() {
      lockedOption = newLocked;
    });
    if(lockedOption == 'CERRAR SESIÓN'){
      Navigator.pushReplacementNamed(context, 'login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
      padding: const EdgeInsets.only(left: 30, top: 30, bottom: 30),
      child:Row(
          children: [
            HomeDrawer(
              lockedOption: lockedOption,
              onLockedChange: onLockedChange,
            ),
            HomeContent(
              lockedOption: lockedOption,
            )
          ],
        ),   
      ),
    );
  }
}
