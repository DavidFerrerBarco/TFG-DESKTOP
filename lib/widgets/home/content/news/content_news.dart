import 'package:flutter/material.dart';
import 'package:my_desktop_app/constants/constants.dart';
import 'package:my_desktop_app/provider/news_provider.dart';
import 'package:my_desktop_app/widgets/home/content/news/content_news_add_put.dart';
import 'package:my_desktop_app/widgets/home/content/news/content_news_data.dart';
import 'package:provider/provider.dart';

class ContentNews extends StatelessWidget {
  const ContentNews({super.key});

  @override
  Widget build(BuildContext context) {
    final NewsProvider newsProvider = Provider.of<NewsProvider>(context);

    void onNewsChanged(String newNewsOption) {
      newsProvider.onLockedNewsChanged(newNewsOption);
    }

    Widget newsViews(String vista) {
      if (vista == listavistanoticias[0]) {
        return ContentNewData(
          newsProvider: newsProvider,
          onOptionChanged: onNewsChanged,
        );
      } else if (vista == listavistanoticias[1]) {
        return ContentNewAddPut(
          newsProvider: newsProvider,
          onOptionChanged: onNewsChanged,
        );
      } else {
        return Container(color: Colors.black);
      }
    }

    return StreamBuilder(
      stream: newsProvider.vistaNoticias,
      initialData: listavistanoticias[0],
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(child: newsViews(snapshot.data!));
        } else {
          return Container();
        }
      },
    );
  }
}
