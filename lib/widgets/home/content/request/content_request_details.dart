import 'package:flutter/material.dart';
import 'package:my_desktop_app/constants/constants.dart';
import 'package:my_desktop_app/provider/provider.dart';
import 'package:my_desktop_app/theme/app_theme.dart';
import 'package:my_desktop_app/widgets/widget.dart';

class ContentRequestDetails extends StatelessWidget {
  final RequestProvider requestProvider;
  final Function onOptionChanged;

  const ContentRequestDetails({
    super.key,
    required this.requestProvider,
    required this.onOptionChanged,
  });

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> myRequestKey = GlobalKey<FormState>();
    final Map<String, String> formValues = {
      'title': '',
      'content': '',
    };

    Stream<String> requesttitle = requestProvider.requesttitle;
    Stream<String> requestcontent = requestProvider.requestcontent;

    var title = TextEditingController();
    var content = TextEditingController();

    requesttitle.listen((data) {
      title.value = TextEditingValue(text: data);
    });

    requestcontent.listen((data) {
      content.value = TextEditingValue(text: data);
    });

    return SingleChildScrollView(
      child: Column(
        children: [
          ButtonRequestOption(
            onOptionChanged: onOptionChanged,
            content: 'Volver',
            option: listavistasolicitudes[0],
            requestProvider: requestProvider,
          ),
          SizedBox(
            width: 500,
            child: Form(
              key: myRequestKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Detalles Solicitudes",
                    style: TextStyle(
                      color: AppTheme.primary,
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 8,
                    ),
                  ),
                  const SizedBox(height: 30),
                  CustomInputField(
                    controller: title,
                    prefixIcon: Icons.title,
                    labelText: 'Título',
                    hintText: 'Título de la solicitud',
                    formProperty: 'title',
                    formValues: formValues,
                    readOnly: true,
                  ),
                  const SizedBox(height: 30),
                  CustomInputField(
                    controller: content,
                    prefixIcon: Icons.content_paste_rounded,
                    labelText: 'Contenido',
                    hintText: 'Contenido de la solicitud',
                    formProperty: 'content',
                    formValues: formValues,
                    keyboardType: TextInputType.multiline,
                    maxLines: 6,
                    readOnly: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
