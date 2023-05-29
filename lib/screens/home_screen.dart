import 'package:flutter/material.dart';
import 'package:my_desktop_app/constants/constants.dart';
import 'package:my_desktop_app/provider/provider.dart';
import 'package:provider/provider.dart';
import '../widgets/widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final HomeProvider homeProvider = Provider.of<HomeProvider>(context);

    void onLockedChanged(String newOption) {
      homeProvider.onLockedChanged(newOption);
      if(newOption ==listaventanas.last){
        Navigator.pushReplacementNamed(context, 'login');
        homeProvider.onLockedChanged(listaventanas[0]);
        homeProvider.onLockedCompanyChanged(listavistaempresa[0]);
      }
    }

    return StreamBuilder(
      stream: homeProvider.lockedOption,
      initialData: listaventanas[0],
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
            padding: const EdgeInsets.only(left: 30, top: 30, bottom: 30),
            child: Row(
                children: [
                  HomeDrawer(
                    lockedOption: snapshot.data!,
                    onLockedChanged: onLockedChanged,
                  ),
                  HomeContent(
                    lockedOption: snapshot.data!,
                  ),
                ],
              ),   
            ),
          );
        }else{
          return const Scaffold();
        }
      },
    );
  }
}
