import 'package:flutter/material.dart';
import 'package:my_desktop_app/constants/constants.dart';
import 'package:my_desktop_app/models/company.dart';
import 'package:my_desktop_app/provider/provider.dart';
import 'package:my_desktop_app/theme/app_theme.dart';
import 'package:my_desktop_app/widgets/widget.dart';
import 'package:provider/provider.dart';
class HomeContentEmpresas extends StatelessWidget {
  const HomeContentEmpresas({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final HomeProvider homeProvider = Provider.of<HomeProvider>(context);

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
                  const HomeButtonAdd(),
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
