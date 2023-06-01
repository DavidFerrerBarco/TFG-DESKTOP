import 'package:flutter/material.dart';
import 'package:my_desktop_app/constants/constants.dart';
import 'package:my_desktop_app/provider/provider.dart';
import 'package:my_desktop_app/widgets/widget.dart';
import 'package:provider/provider.dart';

class ContentCompany extends StatelessWidget {
  final Function onLockedOption;

  const ContentCompany({
    super.key,
    required this.onLockedOption,
  });

  @override
  Widget build(BuildContext context) {
    final HomeCompanyProvider homeProvider =
        Provider.of<HomeCompanyProvider>(context);

    void onCompanyChanged(String newCompanyOption) {
      homeProvider.onLockedCompanyChanged(newCompanyOption);
    }

    Widget companyView(String vista) {
      if (vista == listavistaempresa[0]) {
        return ContentCompanyData(
          homeProvider: homeProvider,
          onOptionChanged: onCompanyChanged,
          onLockedOption: onLockedOption,
        );
      } else if (vista == listavistaempresa[1]) {
        return ContentCompanyAddPut(
          homeProvider: homeProvider,
          onOptionChanged: onCompanyChanged,
        );
      } else {
        return Container(color: Colors.black);
      }
    }

    return StreamBuilder(
      stream: homeProvider.vistaEmpresa,
      initialData: listavistaempresa[0],
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(child: companyView(snapshot.data!));
        } else {
          return Container();
        }
      },
    );
  }
}
