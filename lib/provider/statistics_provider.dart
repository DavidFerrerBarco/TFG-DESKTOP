import 'package:flutter/material.dart';
import 'package:my_desktop_app/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:my_desktop_app/models/models.dart';

class StatisticsProvider extends ChangeNotifier {
  Stream<Map<String, int>> getEmployeesAndHours(
    List<String> empleados,
  ) async* {
    Map<String, int> listaFinal = {};
    for (var empleado in empleados) {
      var url = Uri.http(baseUrl, "api/schedule/employeedni/$empleado");

      final response = await http.get(url);

      final ScheduleModel scheduleModel = ScheduleModel.fromJson(response.body);
      final List<Schedule> schedules = scheduleModel.data;
      int hourCounted = 0;

      for (var element in schedules) {
        hourCounted += element.hoursCount;
      }

      listaFinal[empleado] = hourCounted;
    }
    yield listaFinal;
  }
}
