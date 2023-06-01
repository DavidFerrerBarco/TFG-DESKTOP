import 'package:flutter/material.dart';
import 'package:my_desktop_app/models/custom_error.dart';

class CustomAlertError extends StatelessWidget {
  const CustomAlertError({
    super.key,
    required this.error,
  });

  final CustomError error;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "ERROR ${error.id}",
          style: const TextStyle(
            color: Colors.red,
            fontSize: 20,
          ),
        ),
        Text(
          error.name,
          style: const TextStyle(
            color: Colors.red,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
