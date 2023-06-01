import 'package:flutter/material.dart';
import 'package:my_desktop_app/models/models.dart';
import 'package:my_desktop_app/provider/provider.dart';
import 'package:provider/provider.dart';

import '../../widget.dart';

class HomeDrawerProfileData extends StatelessWidget {
  const HomeDrawerProfileData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final LoginProvider loginProvider = Provider.of<LoginProvider>(context);

    return StreamBuilder(
      stream: loginProvider.employee,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final Employee employee = snapshot.data!;

          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleIconAvatar(radius: 45, name: employee.name),
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  employee.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 33,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
