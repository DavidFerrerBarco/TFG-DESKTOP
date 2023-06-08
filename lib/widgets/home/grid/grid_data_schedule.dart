import 'package:flutter/material.dart';
import 'package:my_desktop_app/constants/constants.dart';
import 'package:my_desktop_app/models/models.dart';
import 'package:my_desktop_app/provider/schedule_provider.dart';
import 'package:my_desktop_app/theme/app_theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class GridDataSchedule extends StatelessWidget {
  final ScheduleDataSource scheduleDataSource;

  const GridDataSchedule({
    super.key,
    required this.scheduleDataSource,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SfDataGrid(
        source: scheduleDataSource,
        columnWidthMode: ColumnWidthMode.fill,
        allowSorting: true,
        allowFiltering: true,
        columns: <GridColumn>[
          GridColumn(
            columnName: 'id',
            allowFiltering: false,
            label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text('ID'),
            ),
            allowEditing: false,
            columnWidthMode: ColumnWidthMode.fitByCellValue,
          ),
          GridColumn(
            columnName: 'day',
            allowFiltering: true,
            label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text('DÍA'),
            ),
          ),
          GridColumn(
            columnName: 'employee',
            label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'EMPLEADO',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          GridColumn(
            columnName: 'hours',
            allowFiltering: false,
            allowSorting: false,
            columnWidthMode: ColumnWidthMode.fitByCellValue,
            label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text('HORAS'),
            ),
          ),
          GridColumn(
            columnName: 'realHours',
            allowFiltering: false,
            allowSorting: false,
            columnWidthMode: ColumnWidthMode.fitByCellValue,
            label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text('HORAS REALES'),
            ),
          ),
          GridColumn(
            columnName: 'hoursCount',
            allowFiltering: false,
            label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text('Nº HORAS'),
            ),
          ),
          GridColumn(
            columnName: 'edit',
            allowFiltering: false,
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

class ScheduleDataSource extends DataGridSource {
  ScheduleDataSource({
    required List<Schedule> scheduleData,
    required ScheduleProvider scheduleProvider,
    required Function onOptionChanged,
  }) {
    _scheduleProvider = scheduleProvider;
    _onOptionChanged = onOptionChanged;
    _scheduleData = scheduleData
        .map<DataGridRow>((e) => DataGridRow(
              cells: [
                DataGridCell<String>(
                  columnName: 'id',
                  value: e.id,
                ),
                DataGridCell<String>(
                  columnName: 'day',
                  value: e.day,
                ),
                DataGridCell<String>(
                  columnName: 'employee',
                  value: e.employee,
                ),
                DataGridCell<List<String>>(
                  columnName: 'hours',
                  value: e.hours,
                ),
                DataGridCell<List<String>>(
                  columnName: 'realHours',
                  value: e.realHours,
                ),
                DataGridCell<int>(
                  columnName: 'hoursCount',
                  value: e.hoursCount,
                ),
                const DataGridCell(
                  columnName: 'edit',
                  value: null,
                ),
              ],
            ))
        .toList();
  }

  List<DataGridRow> _scheduleData = [];

  late ScheduleProvider _scheduleProvider;

  late Function _onOptionChanged;

  @override
  List<DataGridRow> get rows => _scheduleData;

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
                      _scheduleProvider
                          .deleteSchedule(row.getCells()[0].value)
                          .then((value) {
                        if (value) {
                          _onOptionChanged(listavistahorario[0]);
                        } else {}
                      });
                    },
                    icon: const Icon(
                      Icons.remove_circle,
                      color: AppTheme.redColor,
                    ),
                  ),
                ],
              )
            : e.columnName == 'day'
                ? Text(
                    e.value.toString().substring(0, 10),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
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
