import 'package:flutter/material.dart';
import 'package:my_desktop_app/constants/constants.dart';
import '../../widget.dart';

class HomeContent extends StatelessWidget {

  final String lockedOption;

  const HomeContent({
    super.key, 
    required this.lockedOption
  });

  Widget contentVista(){
    if(lockedOption == listaventanas[0]){
      return const HomeContentEmpresas();
    }else if(lockedOption == listaventanas[1]){
      return Container(color: Colors.green,);
    }else{
      return Container(color: Colors.blue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          HomeContentTitle(lockedOption: lockedOption),
          Expanded(
            child: contentVista(),
          ),
        ],
      ),
    );
  }
}