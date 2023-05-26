import 'package:flutter/material.dart';
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
        allowColumnsResizing: true,
        columns: <GridColumn>[
          GridColumn(
            columnName: 'id',
            label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text('ID'),
            ),
          ),
          GridColumn(
            columnName: 'name',
            label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text('Name'),
            ),
          ),
          GridColumn(
            columnName: 'address',
            label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Address',
                overflow: TextOverflow.ellipsis
              ),
            ),
          ),
          GridColumn(
            columnName: 'contractTypes',
            label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text('ContractTypes'),
            ),
          ),
        ],
      ),
    );
  }
}

class CompanyDataSource extends DataGridSource {
  CompanyDataSource({required List<Company> companyData}) {
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
            ]))
        .toList();
  }

  List<DataGridRow> _companyData = [];

  @override
  List<DataGridRow> get rows => _companyData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Text(e.value.toString()),
      );
    }).toList());
  }
}