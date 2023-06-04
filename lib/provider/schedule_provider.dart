import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_desktop_app/constants/constants.dart';
import 'package:my_desktop_app/models/schedule.dart';

import 'package:http/http.dart' as http;
import 'package:my_desktop_app/models/schedule_model.dart';

class ScheduleProvider extends ChangeNotifier {
  String _vistaHorario = listavistahorario[0];

  Stream<String> get vistaHorario async* {
    yield _vistaHorario;
  }

  void onLockedScheduleChanged(String newScheduleOption) {
    _vistaHorario = newScheduleOption;
    notifyListeners();
  }

  // -----------------------------------------------------

  bool _create = true;

  Stream<bool> get create async* {
    yield _create;
  }

  void isCreate(bool isnewcreate) {
    _create = isnewcreate;
  }

  // -----------------------------------------------------

  bool _horarioPartido = false;

  Stream<bool> get horarioPartido async* {
    yield _horarioPartido;
  }

  void isHorariopartido(bool isPartido) {
    _horarioPartido = isPartido;
    resetValuesHours();
    notifyListeners();
  }

  // --------------------------------------------------------

  String _scheduleEmployee = '';

  Stream<String> get scheduleEmployee async* {
    yield _scheduleEmployee;
  }

  void setNewEmployee(String newEmployee) {
    _scheduleEmployee = newEmployee;
    notifyListeners();
  }

  // -------------------------------------------------------

  String _scheduleDay = '';

  Stream<String> get scheduleDay async* {
    yield _scheduleDay;
  }

  void setNewDay(String newDay) {
    _scheduleDay = newDay;
    notifyListeners();
  }

  // -------------------------------------------------------

  List<String> _scheduleHours = <String>[
    listahorasdefault[12],
    listahorasdefault[13],
    listahorasdefault[14],
    listahorasdefault[15],
  ];

  Stream<List<String>> get scheduleHours async* {
    yield _scheduleHours;
  }

  void setNewHours(int index, String hour) {
    _scheduleHours[index] = hour;
    notifyListeners();
  }

  void resetValuesHours() {
    _scheduleHours = <String>[
      listahorasdefault[12],
      listahorasdefault[13],
      listahorasdefault[14],
      listahorasdefault[15],
    ];
  }

  // --------------------------------------------------------

  void resetScheduleForm() {
    _scheduleEmployee = '';
    _scheduleDay = '';
    resetValuesHours();
  }

  // --------------------------------------------------------

  Stream<List<Schedule>> scheduleData(String company) async* {
    await Future.delayed(const Duration(milliseconds: 200));
    String validCompany = company.replaceAll(' ', '-');
    var url = Uri.http(baseUrl, 'api/schedule/company/$validCompany');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final ScheduleModel scheduleModel =
            ScheduleModel.fromJson(response.body);
        yield scheduleModel.data;
      } else {
        yield <Schedule>[];
      }
    } catch (error) {
      yield [defaultschedule];
    }
  }

  // ---------------------------------------------------------

  Future<int> getHoursJob(String dni, List<String> days) async {
    var url = Uri.http(baseUrl, 'api/schedule/daylist/$dni');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "daylist": days,
        }),
      );

      if (response.statusCode == 200) {
        final ScheduleModel scheduleModel =
            ScheduleModel.fromJson(response.body);
        final List<Schedule> schedules = scheduleModel.data;
        int hourCounted = 0;

        for (var element in schedules) {
          hourCounted += element.hoursCount;
        }

        return hourCounted;
      } else {
        return -1;
      }
    } catch (error) {
      return -1;
    }
  }

  // --------------------------------------------------------

  Future<bool> postSchedule(String dniEmpleado, int horasPuestas) async {
    List<String> horario = ["${_scheduleHours[0]}-${_scheduleHours[1]}"];
    if (_horarioPartido) {
      horario.add("${_scheduleHours[2]}-${_scheduleHours[3]}");
    }

    var url = Uri.http(baseUrl, 'api/schedule');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "employee": dniEmpleado,
          "day": _scheduleDay,
          "hours": horario,
          "hoursCount": horasPuestas,
        }),
      );

      print(response.body);
      return response.statusCode == 201;
    } catch (error) {
      return false;
    }
  }

  // ---------------------------------------------------------

  Future<bool> deleteSchedule(String id) async {
    var url = Uri.http(baseUrl, 'api/schedule/$id');
    try {
      final response = await http.delete(url);
      return response.statusCode == 200;
    } catch (error) {
      return false;
    }
  }
}
