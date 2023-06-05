import 'package:flutter/material.dart';
import 'package:my_desktop_app/constants/constants.dart';
import 'package:my_desktop_app/models/models.dart';
import 'package:my_desktop_app/provider/provider.dart';
import 'package:my_desktop_app/theme/app_theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class GridDataRequest extends StatelessWidget {
  final RequestDataSource requestDataSource;
  const GridDataRequest({
    super.key,
    required this.requestDataSource,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SfDataGrid(
        source: requestDataSource,
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
            visible: false,
            columnWidthMode: ColumnWidthMode.fitByCellValue,
          ),
          GridColumn(
            columnName: 'date',
            label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text('FECHA'),
            ),
          ),
          GridColumn(
            columnName: 'company',
            label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'EMPRESA',
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

class RequestDataSource extends DataGridSource {
  RequestDataSource({
    required List<Request> requestData,
    required RequestProvider requestProvider,
    required Function onOptionChanged,
  }) {
    _requestProvider = requestProvider;
    _onOptionChanged = onOptionChanged;
    _requestData = requestData
        .map<DataGridRow>((e) => DataGridRow(
              cells: [
                DataGridCell<String>(
                  columnName: 'id',
                  value: e.id,
                ),
                DataGridCell<String>(
                  columnName: 'date',
                  value: e.date,
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
                const DataGridCell(
                  columnName: 'edit',
                  value: null,
                ),
              ],
            ))
        .toList();
  }

  List<DataGridRow> _requestData = [];

  late RequestProvider _requestProvider;

  late Function _onOptionChanged;

  @override
  List<DataGridRow> get rows => _requestData;

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
                      _requestProvider.setData(
                        row.getCells()[3].value,
                        row.getCells()[4].value,
                      );
                      _onOptionChanged(listavistasolicitudes[1]);
                    },
                    icon: const Icon(
                      Icons.manage_search_rounded,
                      color: AppTheme.primary,
                    ),
                  ),
                  const SizedBox(width: 5),
                  IconButton(
                    onPressed: () {
                      _requestProvider
                          .deleteRequest(row.getCells()[0].value)
                          .then((value) {
                        if (value) {
                          _onOptionChanged(listavistasolicitudes[0]);
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
