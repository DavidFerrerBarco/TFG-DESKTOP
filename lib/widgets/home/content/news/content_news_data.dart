import 'package:flutter/material.dart';
import 'package:my_desktop_app/constants/constants.dart';
import 'package:my_desktop_app/models/news.dart';
import 'package:my_desktop_app/provider/provider.dart';
import 'package:my_desktop_app/theme/app_theme.dart';
import 'package:my_desktop_app/widgets/home/grid/grid_data_news.dart';
import 'package:my_desktop_app/widgets/widget.dart';

class ContentNewData extends StatelessWidget {
  final NewsProvider newsProvider;
  final Function onOptionChanged;

  const ContentNewData({
    super.key,
    required this.newsProvider,
    required this.onOptionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: newsProvider.newsData,
      initialData: const <News>[],
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          if (snapshot.data! == newsDefault) {
            return const CustomErrorMessage();
          } else {
            NewsDataSource newsDataSource = NewsDataSource(
              newsData: snapshot.data!,
              newsProvider: newsProvider,
              onOptionChanged: onOptionChanged,
            );

            return Column(
              children: [
                ButtonNewOption(
                  onOptionChanged: onOptionChanged,
                  content: 'Añadir Noticia',
                  option: listavistanoticias[1],
                  newsProvider: newsProvider,
                ),
                GridDataNews(newsDataSource: newsDataSource),
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
