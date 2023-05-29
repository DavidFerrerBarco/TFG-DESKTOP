import 'package:flutter/material.dart';
import 'package:my_desktop_app/theme/app_theme.dart';
import 'package:my_desktop_app/widgets/widget.dart';

class LoginContainer extends StatelessWidget {
  const LoginContainer({
    super.key,
    required this.myFormKey,
    required this.dni,
    required this.formValues,
    required this.password,
    required this.size,
  });

  final GlobalKey<FormState> myFormKey;
  final TextEditingController dni;
  final Map<String, String> formValues;
  final TextEditingController password;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height: 500,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: AppTheme.primary,
          width: 2,
        ),
        boxShadow: const [
          BoxShadow(
            color: AppTheme.shadowGreen,
            blurRadius: 2,
            offset: Offset(10,10),
          )
        ]
      ),
      child: MyLoginForm(
        myFormKey: myFormKey,
        formValues: formValues,
        dni: dni,
        password: password,
        size: size,
      ),
    );
  }
}