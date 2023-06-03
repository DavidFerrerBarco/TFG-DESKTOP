import 'package:flutter/material.dart';
import 'package:my_desktop_app/constants/constants.dart';
import 'package:my_desktop_app/models/models.dart';
import 'package:my_desktop_app/provider/news_provider.dart';
import 'package:my_desktop_app/theme/app_theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class GridDataNews extends StatelessWidget {
  final NewsDataSource newsDataSource;

  const GridDataNews({
    super.key,
    required this.newsDataSource,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SfDataGrid(
        source: newsDataSource,
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
            columnName: 'date',
            label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text('FECHA'),
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

class NewsDataSource extends DataGridSource {
  NewsDataSource({
    required List<News> newsData,
    required NewsProvider newsProvider,
    required Function onOptionChanged,
  }) {
    _newsProvider = newsProvider;
    _onOptionChanged = onOptionChanged;
    _newsData = newsData
        .map<DataGridRow>((e) => DataGridRow(
              cells: [
                DataGridCell<String>(
                  columnName: 'id',
                  value: e.id,
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
                  columnName: 'date',
                  value: e.date,
                ),
                const DataGridCell(
                  columnName: 'edit',
                  value: null,
                ),
              ],
            ))
        .toList();
  }

  List<DataGridRow> _newsData = [];

  late NewsProvider _newsProvider;

  late Function _onOptionChanged;

  @override
  List<DataGridRow> get rows => _newsData;

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
                      _newsProvider.addAllNewData(
                        row.getCells()[0].value,
                        row.getCells()[1].value,
                        row.getCells()[2].value,
                      );
                      _newsProvider.isCreate(false);
                      _onOptionChanged(listavistanoticias[1]);
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: AppTheme.primary,
                    ),
                  ),
                  const SizedBox(width: 5),
                  IconButton(
                    onPressed: () {
                      _newsProvider
                          .deleteNew(row.getCells()[0].value)
                          .then((value) {
                        if (value) {
                          _onOptionChanged(listavistanoticias[0]);
                        }
                      });
                    },
                    icon: const Icon(
                      Icons.remove_circle,
                      color: Colors.red,
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
