import 'package:flutter/material.dart';
import 'package:my_desktop_app/constants/constants.dart';
import 'package:my_desktop_app/provider/provider.dart';
import 'package:my_desktop_app/widgets/widget.dart';
import 'package:provider/provider.dart';
class HomeContentEmpresas extends StatelessWidget {
  const HomeContentEmpresas({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final HomeProvider homeProvider = Provider.of<HomeProvider>(context);

    void onCompanyChanged(String newCompanyOption){
      homeProvider.onLockedCompanyChanged(newCompanyOption);
    }

    Widget companyView(String vista){
      if(vista == listavistaempresa[0])
      {
        return HomeContentEmpresaData(
          homeProvider: homeProvider,
          onOptionChanged: onCompanyChanged,
        );
      }else if (vista == listavistaempresa[1]){
        return HomeContentEmpresaAdd(
          homeProvider: homeProvider,
          onOptionChanged: onCompanyChanged,
        );
      }else{
        return Container(color: Colors.black);
      }
        
    }

    return StreamBuilder(
      stream: homeProvider.vistaEmpresa,
      initialData: listavistaempresa[0],
      builder: (context, snapshot) {
        if(snapshot.hasData)
        {
          return Container(child: companyView(snapshot.data!));
        }else{
          return Container();
        }
      },
    );
  }
}
