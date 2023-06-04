import 'package:flutter/material.dart';
import 'package:my_desktop_app/constants/constants.dart';
import 'package:my_desktop_app/functions/custom_dropdown_button.dart';
import 'package:my_desktop_app/models/models.dart';
import 'package:my_desktop_app/provider/provider.dart';
import 'package:my_desktop_app/theme/app_theme.dart';
import 'package:my_desktop_app/widgets/widget.dart';
import 'package:provider/provider.dart';

class ContentScheduleAddPut extends StatelessWidget {
  final ScheduleProvider scheduleProvider;
  final Function onOptionChanged;
  const ContentScheduleAddPut({
    super.key,
    required this.scheduleProvider,
    required this.onOptionChanged,
  });

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> myScheduleFormKey = GlobalKey<FormState>();
    final Map<String, dynamic> formValues = {
      'employee': '',
      'day': '',
      'hour1': '',
      'hour2': '',
      'hour3': '',
      'hour4': '',
    };

    Stream<String> scheduleday = scheduleProvider.scheduleDay;
    Stream<List<String>> schedulehourlist = scheduleProvider.scheduleHours;
    Stream<String> scheduleemployee = scheduleProvider.scheduleEmployee;
    Stream<bool> iscreate = scheduleProvider.create;

    var day = TextEditingController();
    var employee = '';
    var hour1 = listahorasdefault[12];
    var hour2 = listahorasdefault[13];
    var hour3 = listahorasdefault[14];
    var hour4 = listahorasdefault[15];

    bool create = false;

    scheduleday.listen((data) {
      day.value = TextEditingValue(text: data);
    });

    scheduleemployee.listen((data) {
      employee = data;
    });

    schedulehourlist.listen((data) {
      hour1 = data[0];
      hour2 = data[1];
      hour3 = data[2];
      hour4 = data[3];
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
                ButtonScheduleOption(
                  onOptionChanged: onOptionChanged,
                  content: 'Volver',
                  option: listavistahorario[0],
                  scheduleProvider: scheduleProvider,
                ),
                StreamBuilder(
                  stream: iscreate,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      create = snapshot.data!;
                      return StreamBuilder(
                        stream: scheduleProvider.horarioPartido,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            bool horariopartido = snapshot.data!;
                            return SizedBox(
                              width: 500,
                              child: Form(
                                key: myScheduleFormKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      create
                                          ? "Crear Horario"
                                          : "Editar Horario",
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
                                            scheduleProvider: scheduleProvider,
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
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                ),
                                                borderSide: BorderSide(
                                                  width: 1,
                                                  color: AppTheme.primary,
                                                ),
                                              ),
                                            ),
                                            isExpanded: true,
                                            value:
                                                listaNombres.contains(employee)
                                                    ? employee
                                                    : listaNombres[0],
                                            onChanged: (item) {
                                              scheduleProvider
                                                  .setNewEmployee(item!);
                                            },
                                            items: listaNombres
                                                .map(
                                                  (item) =>
                                                      DropdownMenuItem<String>(
                                                    value: item,
                                                    child: Row(
                                                      children: [
                                                        const Icon(
                                                          Icons.person,
                                                          color:
                                                              AppTheme.primary,
                                                        ),
                                                        const SizedBox(
                                                            width: 5),
                                                        Text(
                                                          item.toString(),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              const TextStyle(
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
                                    const SizedBox(height: 10),
                                    const Text(
                                      'HORA DE ENTRADA',
                                      style: TextStyle(
                                        color: AppTheme.primary,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 3,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: horariopartido ? 235 : 500,
                                          child: customDropdownButtonFormField(
                                            hour1,
                                            12,
                                            Icons.history_toggle_off_rounded,
                                            (String item) {
                                              if (listahorasdefault
                                                      .indexOf(item) <
                                                  listahorasdefault
                                                      .indexOf(hour2)) {
                                                scheduleProvider.setNewHours(
                                                  0,
                                                  item,
                                                );
                                              } else {
                                                scheduleProvider.setNewHours(
                                                  0,
                                                  hour1,
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                        horariopartido
                                            ? SizedBox(
                                                width: 265,
                                                child: Row(
                                                  children: [
                                                    const SizedBox(width: 30),
                                                    SizedBox(
                                                      width: 235,
                                                      child:
                                                          customDropdownButtonFormField(
                                                        hour3,
                                                        14,
                                                        Icons
                                                            .history_toggle_off_rounded,
                                                        (String item) {
                                                          if (listahorasdefault
                                                                      .indexOf(
                                                                          item) >
                                                                  listahorasdefault
                                                                      .indexOf(
                                                                          hour2) &&
                                                              listahorasdefault
                                                                      .indexOf(
                                                                          item) <
                                                                  listahorasdefault
                                                                      .indexOf(
                                                                          hour4)) {
                                                            scheduleProvider
                                                                .setNewHours(
                                                              2,
                                                              item,
                                                            );
                                                          } else {
                                                            scheduleProvider
                                                                .setNewHours(
                                                              2,
                                                              hour3,
                                                            );
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Container()
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      'HORA DE SALIDA',
                                      style: TextStyle(
                                        color: AppTheme.primary,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 3,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: horariopartido ? 235 : 500,
                                          child: customDropdownButtonFormField(
                                            hour2,
                                            13,
                                            Icons.history_toggle_off_rounded,
                                            (String item) {
                                              if (listahorasdefault
                                                      .indexOf(item) >
                                                  listahorasdefault
                                                      .indexOf(hour1)) {
                                                scheduleProvider.setNewHours(
                                                  1,
                                                  item,
                                                );
                                              } else {
                                                scheduleProvider.setNewHours(
                                                  1,
                                                  hour2,
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                        horariopartido
                                            ? SizedBox(
                                                width: 265,
                                                child: Row(
                                                  children: [
                                                    const SizedBox(width: 30),
                                                    SizedBox(
                                                      width: 235,
                                                      child:
                                                          customDropdownButtonFormField(
                                                        hour4,
                                                        15,
                                                        Icons
                                                            .history_toggle_off_rounded,
                                                        (String item) {
                                                          if (listahorasdefault
                                                                  .indexOf(
                                                                      item) >
                                                              listahorasdefault
                                                                  .indexOf(
                                                                      hour3)) {
                                                            scheduleProvider
                                                                .setNewHours(
                                                              3,
                                                              item,
                                                            );
                                                          } else {
                                                            scheduleProvider
                                                                .setNewHours(
                                                              3,
                                                              hour4,
                                                            );
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Container()
                                      ],
                                    ),
                                    CheckboxListTile(
                                      title: const Text(
                                        "Horario Partido",
                                        style: TextStyle(
                                          color: AppTheme.primary,
                                          fontSize: 20,
                                        ),
                                      ),
                                      value: horariopartido,
                                      onChanged: (value) {
                                        scheduleProvider
                                            .isHorariopartido(value!);
                                      },
                                      activeColor: AppTheme.primary,
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                    ),
                                    const SizedBox(height: 10),
                                    ElevatedButton(
                                      onPressed: () {
                                        if (day.text != '') {
                                          DateTime dia =
                                              DateTime.parse(day.text);

                                          int weekday = dia.weekday;

                                          List<String> listaDias = [];

                                          for (var i = 1; i <= 7; i++) {
                                            DateTime day = dia.add(
                                                Duration(days: -weekday + i));
                                            listaDias.add(day
                                                .toString()
                                                .substring(0, 10));
                                          }
                                          String dniEmpleado = '';
                                          int contractEmpleado = 0;
                                          for (var element in listaEmpleados) {
                                            if (element.name == employee) {
                                              dniEmpleado = element.dni;
                                              contractEmpleado =
                                                  element.contract;
                                              break;
                                            }
                                          }
                                          scheduleProvider
                                              .getHoursJob(
                                                  dniEmpleado, listaDias)
                                              .then(
                                            (value) {
                                              if (value != -1 ||
                                                  value == contractEmpleado) {
                                                int horasPuestas = 0;
                                                horasPuestas = int.parse(
                                                        hour2.substring(0, 2)) -
                                                    int.parse(
                                                        hour1.substring(0, 2));
                                                if (horariopartido) {
                                                  horasPuestas += int.parse(
                                                          hour4.substring(
                                                              0, 2)) -
                                                      int.parse(hour3.substring(
                                                          0, 2));
                                                }
                                                if (horasPuestas + value <=
                                                    contractEmpleado) {
                                                  scheduleProvider
                                                      .postSchedule(dniEmpleado,
                                                          horasPuestas)
                                                      .then(
                                                    (value) {
                                                      if (value) {
                                                        scheduleProvider
                                                            .resetScheduleForm();
                                                        onOptionChanged(
                                                          listavistahorario[0],
                                                        );
                                                      }
                                                    },
                                                  );
                                                }
                                              }
                                            },
                                          );
                                        }
                                      },
                                      style: AppTheme
                                          .lightTheme.elevatedButtonTheme.style,
                                      child: SizedBox(
                                        width: double.infinity,
                                        height: 45,
                                        child: Center(
                                          child: Text(
                                            create ? "Crear" : "Editar",
                                            style: AppTheme.lightTheme.textTheme
                                                .labelLarge,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
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
