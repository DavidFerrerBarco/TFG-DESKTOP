import 'package:flutter/material.dart';
import 'package:my_desktop_app/constants/constants.dart';
import '../widgets/widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String lockedOption = listaventanas[0];

  void onLockedChange(String newLocked){
    if(newLocked == listaventanas.last){
      Navigator.pushReplacementNamed(context, 'login');
    }
    else{
      setState(() {
        lockedOption = newLocked;
      });
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
