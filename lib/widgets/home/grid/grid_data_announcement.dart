import 'package:flutter/material.dart';
import 'package:my_desktop_app/constants/constants.dart';
import 'package:my_desktop_app/models/models.dart';
import 'package:my_desktop_app/provider/announcement_provider.dart';
import 'package:my_desktop_app/theme/app_theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class GridDataAnnouncement extends StatelessWidget {
  final AnnouncementDataSource announcementDataSource;

  const GridDataAnnouncement({
    super.key,
    required this.announcementDataSource,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SfDataGrid(
        source: announcementDataSource,
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

class AnnouncementDataSource extends DataGridSource {
  AnnouncementDataSource({
    required List<Announcement> announcementData,
    required AnnouncementProvider announcementProvider,
    required Function onOptionChanged,
  }) {
    _announcementProvider = announcementProvider;
    _onOptionChanged = onOptionChanged;
    _announcementData = announcementData
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
                  columnName: 'company',
                  value: e.company,
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

  List<DataGridRow> _announcementData = [];

  late AnnouncementProvider _announcementProvider;

  late Function _onOptionChanged;

  @override
  List<DataGridRow> get rows => _announcementData;

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
                        _announcementProvider.addAllAnnouncementData(
                          row.getCells()[0].value,
                          row.getCells()[3].value,
                          row.getCells()[4].value,
                        );
                        _announcementProvider.isCreate(false);
                        _onOptionChanged(listavistaanuncios[1]);
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: AppTheme.primary,
                      ),
                    ),
                    const SizedBox(width: 5),
                    IconButton(
                      onPressed: () {
                        _announcementProvider
                            .deleteAnnouncement(row.getCells()[0].value)
                            .then((value) {
                          if (value) {
                            _onOptionChanged(listavistaanuncios[0]);
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
                ));
    }).toList());
  }
}
