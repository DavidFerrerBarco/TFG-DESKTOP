import 'package:flutter/material.dart';
import 'package:my_desktop_app/constants/constants.dart';
import 'package:my_desktop_app/provider/news_provider.dart';
import 'package:my_desktop_app/theme/app_theme.dart';
import 'package:my_desktop_app/widgets/widget.dart';

class ContentNewAddPut extends StatelessWidget {
  final NewsProvider newsProvider;
  final Function onOptionChanged;

  const ContentNewAddPut({
    super.key,
    required this.newsProvider,
    required this.onOptionChanged,
  });

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> myNewFormKey = GlobalKey<FormState>();
    final Map<String, String> formValues = {
      'title': '',
      'content': '',
    };

    Stream<String> newtitle = newsProvider.newtitle;
    Stream<String> newcontent = newsProvider.newcontent;
    Stream<bool> iscreate = newsProvider.create;

    var title = TextEditingController();
    var content = TextEditingController();
    bool create = false;

    newtitle.listen((data) {
      title.value = TextEditingValue(text: data);
    });

    newcontent.listen((data) {
      content.value = TextEditingValue(text: data);
    });

    return SingleChildScrollView(
      child: Column(
        children: [
          ButtonNewOption(
            onOptionChanged: onOptionChanged,
            content: 'Volver',
            option: listavistanoticias[0],
            newsProvider: newsProvider,
          ),
          StreamBuilder(
            stream: iscreate,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                create = snapshot.data!;
                return SizedBox(
                  width: 500,
                  child: Form(
                    key: myNewFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          create ? "Crear Noticia" : "Editar Noticia",
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
                          hintText: 'Título de la noticia',
                          formProperty: 'title',
                          formValues: formValues,
                        ),
                        const SizedBox(height: 30),
                        CustomInputField(
                          controller: content,
                          prefixIcon: Icons.content_paste_rounded,
                          labelText: 'Contenido',
                          hintText: 'Contenido de la noticia',
                          formProperty: 'content',
                          formValues: formValues,
                          keyboardType: TextInputType.multiline,
                          maxLines: 6,
                        ),
                        const SizedBox(height: 50),
                        ElevatedButton(
                          onPressed: () {
                            newsProvider.addDataPost(title.text, content.text);

                            if (create) {
                              newsProvider.postNew().then((value) {
                                if (value) {
                                  newsProvider.resetNewForm();
                                  onOptionChanged(listavistanoticias[0]);
                                } else {}
                              });
                            } else {
                              newsProvider.putNew().then((value) {
                                if (value) {
                                  newsProvider.resetNewForm();
                                  onOptionChanged(listavistanoticias[0]);
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
                                style: AppTheme.lightTheme.textTheme.labelLarge,
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
  }
}
