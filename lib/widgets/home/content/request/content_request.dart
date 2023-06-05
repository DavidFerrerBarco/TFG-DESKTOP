import 'package:flutter/material.dart';
import 'package:my_desktop_app/constants/constants.dart';
import 'package:my_desktop_app/provider/request_provider.dart';
import 'package:my_desktop_app/widgets/home/content/request/content_request_details.dart';
import 'package:my_desktop_app/widgets/widget.dart';
import 'package:provider/provider.dart';

class ContentRequests extends StatelessWidget {
  const ContentRequests({super.key});

  @override
  Widget build(BuildContext context) {
    final RequestProvider requestProvider =
        Provider.of<RequestProvider>(context);

    void onRequestsChanged(String newRequestOption) {
      requestProvider.onLockedChanged(newRequestOption);
    }

    Widget requestsViews(String vista) {
      if (vista == listavistasolicitudes[0]) {
        return ContentRequestData(
          requestProvider: requestProvider,
          onOptionChanged: onRequestsChanged,
        );
      } else if (vista == listavistasolicitudes[1]) {
        return ContentRequestDetails(
          requestProvider: requestProvider,
          onOptionChanged: onRequestsChanged,
        );
      } else {
        return Container();
      }
    }

    return StreamBuilder(
      stream: requestProvider.vistaSolicitud,
      initialData: listavistasolicitudes[0],
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(child: requestsViews(snapshot.data!));
        } else {
          return Container();
        }
      },
    );
  }
}
