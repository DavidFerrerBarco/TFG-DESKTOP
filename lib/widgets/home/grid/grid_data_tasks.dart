import 'package:flutter/material.dart';
import 'package:my_desktop_app/constants/constants.dart';
import 'package:my_desktop_app/models/models.dart';
import 'package:my_desktop_app/provider/provider.dart';
import 'package:my_desktop_app/theme/app_theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class GridDataTask extends StatelessWidget {
  final TaskDataSource taskDataSource;

  const GridDataTask({
    super.key,
    required this.taskDataSource,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SfDataGrid(
        source: taskDataSource,
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
            visible: false,
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
            columnName: 'title',
            label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'TÍTULO',
              ),
            ),
          ),
          GridColumn(
            columnName: 'content',
            label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'CONTENIDO',
              ),
            ),
          ),
          GridColumn(
            columnName: 'status',
            label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'ESTADO',
              ),
            ),
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

class TaskDataSource extends DataGridSource {
  TaskDataSource({
    required List<Task> taskData,
    required TaskProvider taskProvider,
    required Function onOptionChanged,
  }) {
    _taskProvider = taskProvider;
    _onOptionChanged = onOptionChanged;
    _taskData = taskData
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
                DataGridCell<String>(
                  columnName: 'title',
                  value: e.title,
                ),
                DataGridCell<String>(
                  columnName: 'content',
                  value: e.content,
                ),
                DataGridCell<String>(
                  columnName: 'status',
                  value: e.status,
                ),
                const DataGridCell(
                  columnName: 'edit',
                  value: null,
                ),
              ],
            ))
        .toList();
  }

  List<DataGridRow> _taskData = [];

  late TaskProvider _taskProvider;

  late Function _onOptionChanged;

  @override
  List<DataGridRow> get rows => _taskData;

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
                  row.getCells()[5].value == "Pendiente"
                      ? IconButton(
                          onPressed: () {
                            _taskProvider.setId(row.getCells()[0].value);
                            _taskProvider.setAllData(
                              row.getCells()[3].value,
                              row.getCells()[4].value,
                              row.getCells()[2].value,
                            );
                            _taskProvider.setNewDay(row.getCells()[1].value);
                            _taskProvider.isCreate(false);
                            _onOptionChanged(listavistanoticias[1]);
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: AppTheme.primary,
                          ),
                        )
                      : const SizedBox(width: 40),
                  const SizedBox(width: 5),
                  IconButton(
                    onPressed: () {
                      _taskProvider
                          .deleteTask(row.getCells()[0].value)
                          .then((value) {
                        if (value) {
                          _onOptionChanged(listavistatareas[0]);
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
            : Text(
                e.value.toString(),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
      );
    }).toList());
  }
}
