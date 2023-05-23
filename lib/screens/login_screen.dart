import 'package:flutter/material.dart';
import 'package:my_desktop_app/theme/app_theme.dart';
import 'package:my_desktop_app/widgets/widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();
    final Map<String,String> formValues = {'dni': '', 'password':''};

    var dni = TextEditingController();
    var password = TextEditingController();

    Size size = MediaQuery.of(context).size;
    bool isPassword = true;

    return Scaffold(
      backgroundColor: AppTheme.backgroundGreen,
      body:Center(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Column(
              children: [
                SizedBox(
                  height: size.height/5,
                  child: const Center(
                    child: Text(
                      'EMPLOYEE DIARY',
                      style: TextStyle(
                        fontSize: 60,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            offset: Offset(0.1, 1),
                            color: AppTheme.shadowGreen,
                          ),
                          Shadow(
                            offset: Offset(0.2, 2),
                            color: AppTheme.shadowGreen,
                          ),
                          Shadow(
                            offset: Offset(0.3, 3),
                            color: AppTheme.shadowGreen,
                          ),
                          Shadow(
                            offset: Offset(0.4, 4),
                            color: AppTheme.shadowGreen,
                          ),
                          Shadow(
                            offset: Offset(0.5, 5),
                            color: AppTheme.shadowGreen,
                          ),
                          Shadow(
                            offset: Offset(0.6, 6),
                            color: AppTheme.shadowGreen,
                          ),
                          Shadow(
                            offset: Offset(0.7, 7),
                            color: AppTheme.shadowGreen,
                          ),
                          Shadow(
                            offset: Offset(0.8, 8),
                            color: AppTheme.shadowGreen,
                          ),
                          Shadow(
                            offset: Offset(0.9, 9),
                            color: AppTheme.shadowGreen,
                          ),
                          Shadow(
                            offset: Offset(1, 10),
                            color: AppTheme.shadowGreen,
                          ),
                        ]
                      ),
                    ),
                  ),
                ),
                LoginContainer(
                  myFormKey: myFormKey,
                  formValues: formValues,
                  dni: dni,
                  password: password,
                  size: size,
                  isPassword: isPassword,
                ),
              ],
            ),
            
          ]
        ),
      ),
    );
  }
}
