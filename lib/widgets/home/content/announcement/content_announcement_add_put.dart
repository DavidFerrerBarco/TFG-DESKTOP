import 'package:flutter/material.dart';
import 'package:my_desktop_app/constants/constants.dart';
import 'package:my_desktop_app/models/models.dart';
import 'package:my_desktop_app/provider/provider.dart';
import 'package:my_desktop_app/theme/app_theme.dart';
import 'package:my_desktop_app/widgets/widget.dart';
import 'package:provider/provider.dart';

class ContentAnnouncementAddPut extends StatelessWidget {
  final AnnouncementProvider announcementProvider;
  final Function onOptionChanged;

  const ContentAnnouncementAddPut({
    super.key,
    required this.announcementProvider,
    required this.onOptionChanged,
  });

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> myAnnouncementFormKey = GlobalKey<FormState>();
    final Map<String, String> formValues = {
      'title': '',
      'content': '',
    };

    Stream<String> announcementtitle = announcementProvider.announcementtitle;
    Stream<String> announcementcontent =
        announcementProvider.announcementcontent;
    Stream<bool> iscreate = announcementProvider.create;

    var title = TextEditingController();
    var content = TextEditingController();
    bool create = false;

    announcementtitle.listen((data) {
      title.value = TextEditingValue(text: data);
    });

    announcementcontent.listen((data) {
      content.value = TextEditingValue(text: data);
    });

    final LoginProvider loginProvider = Provider.of<LoginProvider>(context);
    return StreamBuilder<Employee>(
      stream: loginProvider.employee,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          String company = snapshot.data!.company;
          return SingleChildScrollView(
            child: Column(
              children: [
                ButtonAnnouncementOption(
                  onOptionChanged: onOptionChanged,
                  content: 'Volver',
                  option: listavistaanuncios[0],
                  announcementProvider: announcementProvider,
                ),
                StreamBuilder(
                  stream: iscreate,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      create = snapshot.data!;
                      return SizedBox(
                        width: 500,
                        child: Form(
                          key: myAnnouncementFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                create ? "Crear Anuncio" : "Editar Anuncio",
                                style: const TextStyle(
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
                                hintText: 'Título del anuncio',
                                formProperty: 'title',
                                formValues: formValues,
                              ),
                              const SizedBox(height: 30),
                              CustomInputField(
                                controller: content,
                                prefixIcon: Icons.content_paste_rounded,
                                labelText: 'Contenido',
                                hintText: 'Contenido del anuncio',
                                formProperty: 'content',
                                formValues: formValues,
                                keyboardType: TextInputType.multiline,
                                maxLines: 6,
                              ),
                              const SizedBox(height: 50),
                              ElevatedButton(
                                onPressed: () {
                                  announcementProvider.addDataPost(
                                    title.text,
                                    content.text,
                                  );

                                  if (create) {
                                    announcementProvider
                                        .postAnnouncement(company)
                                        .then((value) {
                                      if (value) {
                                        announcementProvider
                                            .resetAnnouncementForm();
                                        onOptionChanged(listavistaanuncios[0]);
                                      } else {}
                                    });
                                  } else {
                                    announcementProvider
                                        .putAnnouncement(company)
                                        .then((value) {
                                      if (value) {
                                        announcementProvider
                                            .resetAnnouncementForm();
                                        onOptionChanged(listavistaanuncios[0]);
                                      } else {}
                                    });
                                  }
                                },
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 45,
                                  child: Center(
                                    child: Text(
                                      create ? "Crear" : "Editar",
                                      style: AppTheme
                                          .lightTheme.textTheme.labelLarge,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
