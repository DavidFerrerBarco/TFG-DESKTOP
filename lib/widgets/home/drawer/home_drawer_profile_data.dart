import 'package:flutter/material.dart';

import '../../widget.dart';

class HomeDrawerProfileData extends StatelessWidget {
  const HomeDrawerProfileData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleIconAvatar(radius: 45),
        SizedBox(width: 20),
        Expanded(
          child: Text(
            'David Ferrer',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 33,
              overflow: TextOverflow.ellipsis
            ),
          ),
        ),
      ],
    );
  }
}