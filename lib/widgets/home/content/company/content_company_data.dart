import 'package:flutter/material.dart';
import 'package:my_desktop_app/constants/constants.dart';
import 'package:my_desktop_app/provider/provider.dart';
import 'package:my_desktop_app/theme/app_theme.dart';
import 'package:my_desktop_app/widgets/widget.dart';

import '../../../../models/models.dart';

class ContentCompanyData extends StatelessWidget {
  final HomeCompanyProvider homeProvider;
  final Function onOptionChanged;
  final Function onLockedOption;

  const ContentCompanyData({
    super.key,
    required this.homeProvider,
    required this.onOptionChanged,
    required this.onLockedOption,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: homeProvider.companiesData,
      initialData: const <Company>[],
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          if (snapshot.data! == companiesDefault) {
            return const CustomErrorMessage();
          } else {
            CompanyDataSource companyDataSource = CompanyDataSource(
              companyData: snapshot.data!,
              homeProvider: homeProvider,
              onOptionChanged: onOptionChanged,
              onLockedOption: onLockedOption,
            );

            return Column(
              children: [
                ButtonCompanyOption(
                  onOptionChanged: onOptionChanged,
                  content: 'Añadir Empresa',
                  option: listavistaempresa[1],
                  homeProvider: homeProvider,
                ),
                GridDataCompanies(companyDataSource: companyDataSource),
              ],
            );
          }
        } else {
          return const Center(
              child: CircularProgressIndicator(
            color: AppTheme.primary,
          ));
        }
      },
    );
  }
}
