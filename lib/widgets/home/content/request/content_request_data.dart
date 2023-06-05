import 'package:flutter/material.dart';
import 'package:my_desktop_app/constants/constants.dart';
import 'package:my_desktop_app/models/models.dart';
import 'package:my_desktop_app/provider/provider.dart';
import 'package:my_desktop_app/theme/app_theme.dart';
import 'package:my_desktop_app/widgets/custom_error_message.dart';
import 'package:my_desktop_app/widgets/home/grid/grid_data_requests.dart';
import 'package:provider/provider.dart';

class ContentRequestData extends StatelessWidget {
  final RequestProvider requestProvider;
  final Function onOptionChanged;
  const ContentRequestData({
    super.key,
    required this.requestProvider,
    required this.onOptionChanged,
  });

  @override
  Widget build(BuildContext context) {
    LoginProvider loginProvider = Provider.of<LoginProvider>(context);

    return StreamBuilder<Employee>(
      stream: loginProvider.employee,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Employee employeeLogged = snapshot.data!;
          return StreamBuilder(
            stream: requestProvider.requestData(employeeLogged.company),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                if (snapshot.data! == [defaultrequest]) {
                  return const CustomErrorMessage();
                } else {
                  RequestDataSource requestDataSource = RequestDataSource(
                    requestData: snapshot.data!,
                    requestProvider: requestProvider,
                    onOptionChanged: onOptionChanged,
                  );

                  return Column(
                    children: [
                      GridDataRequest(
                        requestDataSource: requestDataSource,
                      ),
                    ],
                  );
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppTheme.primary,
                  ),
                );
              }
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}
