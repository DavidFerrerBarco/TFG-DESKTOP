import 'package:flutter/material.dart';
import 'package:my_desktop_app/constants/constants.dart';
import 'package:my_desktop_app/provider/provider.dart';
import 'package:my_desktop_app/theme/app_theme.dart';
import 'package:my_desktop_app/widgets/widget.dart';

import '../../../../models/models.dart';

class HomeContentEmpresaData extends StatelessWidget {

  final HomeProvider homeProvider;
  final Function onOptionChanged; 

  const HomeContentEmpresaData({
    super.key,
    required this.homeProvider,
    required this.onOptionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: homeProvider.companiesData,
      initialData: const <Company>[],
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.done && snapshot.hasData)
        {
            if(snapshot.data! == companiesDefault)
            {
              return const Center(
                child: Text(
                  'ERROR EN LA RED :(', 
                  style: TextStyle(
                    color: AppTheme.primary,
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }
            else{
              CompanyDataSource companyDataSource = CompanyDataSource(companyData: snapshot.data!);

              return Column(
                children: [
                  HomeButtonOption(
                    onOptionChanged: onOptionChanged,
                    content: 'Añadir Empresa',
                    option: listavistaempresa[1],
                  ),
                  GridDataCompanies(companyDataSource: companyDataSource),
                ],
              );
            }
        }
        else{
          return const Center(child: CircularProgressIndicator(color: AppTheme.primary,));
        }
        
      },
    );
  }
}