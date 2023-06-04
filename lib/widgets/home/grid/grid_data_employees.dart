import 'package:flutter/material.dart';
import 'package:my_desktop_app/constants/constants.dart';
import 'package:my_desktop_app/models/models.dart';
import 'package:my_desktop_app/provider/provider.dart';
import 'package:my_desktop_app/theme/app_theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class GridDataEmployee extends StatelessWidget {
  final EmployeeDataSource employeeDataSource;

  const GridDataEmployee({
    super.key,
    required this.employeeDataSource,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SfDataGrid(
        source: employeeDataSource,
        columnWidthMode: ColumnWidthMode.lastColumnFill,
        allowSorting: true,
        allowFiltering: true,
        allowColumnsResizing: true,
        columns: <GridColumn>[
          GridColumn(
            columnName: 'id',
            label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text('ID'),
            ),
            columnWidthMode: ColumnWidthMode.fitByColumnName,
            visible: false,
          ),
          GridColumn(
            columnName: 'dni',
            label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text('DNI'),
            ),
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
            columnName: 'company',
            allowFiltering: false,
            label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text('EMPRESA'),
            ),
          ),
          GridColumn(
            columnWidthMode: ColumnWidthMode.fill,
            columnName: 'email',
            allowFiltering: false,
            label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text('EMAIL'),
            ),
          ),
          GridColumn(
            columnName: 'contract',
            allowFiltering: false,
            label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'CONTR.',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          GridColumn(
            columnWidthMode: ColumnWidthMode.auto,
            allowSorting: false,
            columnName: 'admin',
            label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text('ADMIN'),
            ),
          ),
          GridColumn(
            allowSorting: false,
            allowFiltering: false,
            columnName: 'edit',
            label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(''),
            ),
          ),
        ],
      ),
    );
  }
}

class EmployeeDataSource extends DataGridSource {
  EmployeeDataSource({
    required List<Employee> employeesData,
    required HomeEmployeeProvider employeeProvider,
    required LoginProvider loginProvider,
    required Function onOptionChanged,
  }) {
    _employeeProvider = employeeProvider;
    _loginProvider = loginProvider;
    _onOptionChanged = onOptionChanged;
    _employeesData = employeesData
        .map<DataGridRow>((e) => DataGridRow(
              cells: [
                DataGridCell<String>(
                  columnName: 'id',
                  value: e.id,
                ),
                DataGridCell<String>(
                  columnName: 'dni',
                  value: e.dni,
                ),
                DataGridCell<String>(
                  columnName: 'name',
                  value: e.name,
                ),
                DataGridCell<String>(
                  columnName: 'company',
                  value: e.company,
                ),
                DataGridCell<String>(
                  columnName: 'email',
                  value: e.email,
                ),
                DataGridCell<int>(
                  columnName: 'contract',
                  value: e.contract,
                ),
                DataGridCell<bool>(
                  columnName: 'admin',
                  value: e.admin,
                ),
                DataGridCell<bool>(
                  columnName: 'edit',
                  value: e.admin,
                ),
              ],
            ))
        .toList();
  }

  List<DataGridRow> _employeesData = [];

  late HomeEmployeeProvider _employeeProvider;
  late LoginProvider _loginProvider;

  late Function _onOptionChanged;

  @override
  List<DataGridRow> get rows => _employeesData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map((e) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: e.columnName == 'edit'
            ? StreamBuilder<Employee>(
                stream: _loginProvider.employee,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final employee = snapshot.data!;
                    return StreamBuilder<bool>(
                      stream: _loginProvider.isdeveloper,
                      initialData: true,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final isdeveloper = snapshot.data!;
                          return isdeveloper
                              ? employee.id != row.getCells()[0].value
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            _employeeProvider
                                                .putAdmin(
                                                    row.getCells()[0].value,
                                                    !row.getCells()[6].value)
                                                .then(
                                              (value) {
                                                if (value) {
                                                  _onOptionChanged(
                                                      listavistaempleado[0]);
                                                }
                                              },
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: e.value
                                                ? AppTheme.primary
                                                : AppTheme.redColor,
                                          ),
                                          child: const Text(
                                            'Admin',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Container()
                              : Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        _employeeProvider.addAllEmployeeData(
                                          row.getCells()[0].value,
                                          row.getCells()[2].value,
                                          row.getCells()[1].value,
                                          row.getCells()[5].value,
                                        );
                                        _employeeProvider.isCreate(false);
                                        _onOptionChanged(listavistaempleado[1]);
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        color: AppTheme.primary,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    IconButton(
                                      onPressed: () {
                                        _employeeProvider
                                            .deleteEmployee(
                                                row.getCells()[0].value)
                                            .then(
                                          (value) {
                                            if (value) {
                                              _onOptionChanged(
                                                  listavistaempleado[0]);
                                            }
                                          },
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.remove_circle,
                                        color: AppTheme.redColor,
                                      ),
                                    ),
                                  ],
                                );
                        } else {
                          return Container();
                        }
                      },
                    );
                  } else {
                    return Container();
                  }
                },
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
