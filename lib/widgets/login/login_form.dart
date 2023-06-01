import 'package:flutter/material.dart';
import 'package:my_desktop_app/constants/constants.dart';
import 'package:my_desktop_app/models/models.dart';
import 'package:my_desktop_app/provider/login_provider.dart';
import 'package:my_desktop_app/theme/app_theme.dart';

import '../widget.dart';

class MyLoginForm extends StatelessWidget {
  const MyLoginForm({
    super.key,
    required this.myFormKey,
    required this.dni,
    required this.formValues,
    required this.password,
    required this.size,
    required this.loginProvider,
  });

  final GlobalKey<FormState> myFormKey;
  final TextEditingController dni;
  final Map<String, String> formValues;
  final TextEditingController password;
  final Size size;
  final LoginProvider loginProvider;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      stream: loginProvider.error,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Iniciar Sesión",
                style: TextStyle(
                  color: AppTheme.primary,
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.italic,
                  shadows: [
                    Shadow(offset: Offset(1, 1), color: AppTheme.shadowGreen)
                  ],
                ),
              ),
              const SizedBox(height: 50),
              SizedBox(
                height: 300,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.height / 15),
                  child: Form(
                    key: myFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomInputField(
                          controller: dni,
                          prefixIcon: Icons.person,
                          labelText: 'DNI',
                          hintText: 'DNI del admin',
                          formProperty: 'dni',
                          formValues: formValues,
                        ),
                        CustomInputField(
                          controller: password,
                          suffixIcon: Icons.remove_red_eye_rounded,
                          prefixIcon: Icons.lock_outline_rounded,
                          labelText: 'Password',
                          hintText: 'Password',
                          formProperty: 'password',
                          formValues: formValues,
                          isPassword: true,
                          allowPassword: true,
                        ),
                        snapshot.data! != defaulterror
                            ? CustomAlertError(
                                error: snapshot.data! as CustomError)
                            : Container(),
                        ElevatedButton(
                          onPressed: () {
                            if (!myFormKey.currentState!.validate()) {
                              password.clear();
                              return;
                            }
                            loginProvider
                                .loginAdmin(
                              formValues.values.elementAt(0),
                              formValues.values.elementAt(1),
                            )
                                .then((value) {
                              if (value) {
                                Navigator.pushReplacementNamed(
                                    context, 'splash');
                              }
                            });
                          },
                          style: AppTheme.lightTheme.elevatedButtonTheme.style,
                          child: SizedBox(
                            width: double.infinity,
                            height: 45,
                            child: Center(
                              child: Text(
                                'Entrar',
                                style: AppTheme.lightTheme.textTheme.labelLarge,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
