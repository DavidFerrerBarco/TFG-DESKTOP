import 'package:flutter/material.dart';
import 'package:my_desktop_app/constants/constants.dart';
import 'package:my_desktop_app/models/employee.dart';
import 'package:my_desktop_app/provider/provider.dart';
import 'package:my_desktop_app/theme/app_theme.dart';
import 'package:my_desktop_app/widgets/widget.dart';
import 'package:provider/provider.dart';

class ContentTaskAddPut extends StatelessWidget {
  final TaskProvider taskProvider;
  final Function onOptionChanged;

  const ContentTaskAddPut({
    super.key,
    required this.taskProvider,
    required this.onOptionChanged,
  });

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> myTaskFormKey = GlobalKey<FormState>();
    final Map<String, String> formValues = {
      'employee': '',
      'day': '',
      'title': '',
      'content': '',
    };

    Stream<String> taskday = taskProvider.taskDay;
    Stream<String> taskemployee = taskProvider.taskEmployee;
    Stream<String> tasktitle = taskProvider.taskTitle;
    Stream<String> taskcontent = taskProvider.taskContent;
    Stream<bool> iscreate = taskProvider.create;

    var day = TextEditingController();
    var employee = '';
    var title = TextEditingController();
    var content = TextEditingController();

    bool create = false;

    taskday.listen((data) {
      day.value = TextEditingValue(text: data);
    });

    taskemployee.listen((data) {
      employee = data;
    });

    tasktitle.listen((data) {
      title.value = TextEditingValue(text: data);
    });

    taskcontent.listen((data) {
      content.value = TextEditingValue(text: data);
    });

    final HomeEmployeeProvider employeeProvider =
        Provider.of<HomeEmployeeProvider>(context);

    return StreamBuilder<List<Employee>>(
      stream: employeeProvider.employeesData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Employee> listaEmpleados = snapshot.data!;
          List<String> listaNombres = [];
          for (Employee empleado in listaEmpleados) {
            listaNombres.add(empleado.name);
          }
          if (employee == '') {
            employee = listaNombres[0];
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                ButtonTaskOption(
                  onOptionChanged: onOptionChanged,
                  content: 'Volver',
                  option: listavistatareas[0],
                  taskProvider: taskProvider,
                ),
                StreamBuilder(
                  stream: iscreate,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      create = snapshot.data!;
                      return SizedBox(
                        width: 500,
                        child: Form(
                          key: myTaskFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                create ? "Crear Tarea" : "Editar Tarea",
                                style: const TextStyle(
                                  color: AppTheme.primary,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 8,
                                ),
                              ),
                              const SizedBox(height: 30),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 235,
                                    child: CustomInputField(
                                      controller: day,
                                      prefixIcon: Icons.calendar_month,
                                      labelText: "Día",
                                      formProperty: 'day',
                                      formValues: formValues,
                                      tap: true,
                                      taskProvider: taskProvider,
                                    ),
                                  ),
                                  const SizedBox(width: 30),
                                  SizedBox(
                                    width: 235,
                                    child: DropdownButtonFormField(
                                      decoration: const InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                          ),
                                          borderSide: BorderSide(
                                            width: 1,
                                            color: AppTheme.primary,
                                          ),
                                        ),
                                      ),
                                      isExpanded: true,
                                      value: listaNombres.contains(employee)
                                          ? employee
                                          : listaNombres[0],
                                      onChanged: (item) {
                                        taskProvider.setAllData(
                                            title.text, content.text, item!);
                                      },
                                      items: listaNombres
                                          .map(
                                            (item) => DropdownMenuItem<String>(
                                              value: item,
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.person,
                                                    color: AppTheme.primary,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  Text(
                                                    item.toString(),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        fontSize: 18),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 30),
                              CustomInputField(
                                controller: title,
                                prefixIcon: Icons.title,
                                labelText: 'Título',
                                hintText: 'Título de la tarea',
                                formProperty: 'title',
                                formValues: formValues,
                              ),
                              const SizedBox(height: 30),
                              CustomInputField(
                                controller: content,
                                prefixIcon: Icons.content_paste_rounded,
                                labelText: 'Contenido',
                                hintText: 'Contenido de la tarea',
                                formProperty: 'content',
                                formValues: formValues,
                                keyboardType: TextInputType.multiline,
                                maxLines: 3,
                              ),
                              const SizedBox(height: 30),
                              ElevatedButton(
                                onPressed: () {
                                  if (day.text != '' &&
                                      title.text != '' &&
                                      content.text != '') {
                                    String dniEmpleado = '';
                                    for (var element in listaEmpleados) {
                                      if (element.name == employee) {
                                        dniEmpleado = element.dni;
                                        break;
                                      }
                                    }

                                    taskProvider.setNewTitle(title.text);
                                    taskProvider.setNewContent(content.text);
                                    if (create) {
                                      taskProvider
                                          .postTask(dniEmpleado)
                                          .then((value) {
                                        if (value) {
                                          taskProvider.resetTaskForm();
                                          onOptionChanged(listavistatareas[0]);
                                        }
                                      });
                                    } else {
                                      taskProvider
                                          .putTask(dniEmpleado)
                                          .then((value) {
                                        if (value) {
                                          taskProvider.resetTaskForm();
                                          onOptionChanged(listavistatareas[0]);
                                        }
                                      });
                                    }
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
