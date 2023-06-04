import 'package:flutter/material.dart';
import 'package:my_desktop_app/constants/constants.dart';
import 'package:my_desktop_app/provider/provider.dart';
import 'package:my_desktop_app/theme/app_theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../models/models.dart';

class GridDataCompanies extends StatelessWidget {
  const GridDataCompanies({
    super.key,
    required this.companyDataSource,
  });

  final CompanyDataSource companyDataSource;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SfDataGrid(
        source: companyDataSource,
        columnWidthMode: ColumnWidthMode.fill,
        allowSorting: true,
        allowEditing: true,
        allowColumnsResizing: true,
        allowPullToRefresh: true,
        columns: <GridColumn>[
          GridColumn(
            columnName: 'id',
            label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text('ID'),
            ),
            allowEditing: false,
            columnWidthMode: ColumnWidthMode.fitByCellValue,
          ),
          GridColumn(
            columnName: 'name',
            label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text('NOMBRE'),
            ),
          ),
          GridColumn(
            columnName: 'address',
            label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'DIRECCIÓN',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          GridColumn(
            columnName: 'contractTypes',
            label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text('CONTRATOS'),
            ),
            allowSorting: false,
          ),
          GridColumn(
            columnName: 'edit',
            label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(''),
            ),
            allowSorting: false,
            columnWidthMode: ColumnWidthMode.fill,
          ),
        ],
      ),
    );
  }
}

class CompanyDataSource extends DataGridSource {
  CompanyDataSource({
    required List<Company> companyData,
    required HomeCompanyProvider homeProvider,
    required HomeEmployeeProvider employeeProvider,
    required Function onOptionChanged,
    required Function onLockedOption,
  }) {
    _homeProvider = homeProvider;
    _employeeProvider = employeeProvider;
    _onOptionChanged = onOptionChanged;
    _onLockedOption = onLockedOption;
    _companyData = companyData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(
                columnName: 'id',
                value: e.id,
              ),
              DataGridCell<String>(
                columnName: 'name',
                value: e.name,
              ),
              DataGridCell<String>(
                columnName: 'address',
                value: e.address,
              ),
              DataGridCell<List<int>>(
                columnName: 'contractTypes',
                value: e.contractTypes,
              ),
              const DataGridCell<Widget>(
                columnName: 'edit',
                value: null,
              ),
            ]))
        .toList();
  }

  List<DataGridRow> _companyData = [];

  late HomeCompanyProvider _homeProvider;

  late HomeEmployeeProvider _employeeProvider;

  late Function _onOptionChanged;

  late Function _onLockedOption;

  @override
  List<DataGridRow> get rows => _companyData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: e.columnName == 'edit'
            ? Row(
                children: [
                  IconButton(
                    onPressed: () {
                      _employeeProvider
                          .setLockedCompany(row.getCells()[1].value);
                      _onLockedOption(listaventanasadmin[0]);
                    },
                    icon: const Icon(
                      Icons.person_search,
                      color: AppTheme.primary,
                    ),
                  ),
                  const SizedBox(width: 5),
                  IconButton(
                    onPressed: () {
                      _homeProvider.setId(row.getCells()[0].value);
                      _homeProvider.addCompanyName(row.getCells()[1].value);
                      _homeProvider.addCompanyAddress(row.getCells()[2].value);
                      List<int> lista = row.getCells()[3].value;
                      _homeProvider.isCreate(false);
                      _homeProvider.addAnHourList(lista);

                      _onOptionChanged(listavistaempresa[1]);
                    },
                    icon: const Icon(Icons.edit, color: AppTheme.primary),
                  ),
                  const SizedBox(width: 5),
                  IconButton(
                    onPressed: () {
                      _homeProvider
                          .deleteCompany(row.getCells()[0].value)
                          .then((value) {
                        if (value) {
                          _onOptionChanged(
                            listavistaempresa[0],
                          );
                        }
                      });
                    },
                    icon: const Icon(
                      Icons.remove_circle,
                      color: AppTheme.redColor,
                    ),
                  ),
                ],
              )
            : Text(
                e.value.toString(),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
      );
    }).toList());
  }
}
