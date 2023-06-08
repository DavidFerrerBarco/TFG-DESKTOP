import 'package:flutter/material.dart';
import 'package:my_desktop_app/constants/constants.dart';
import 'package:my_desktop_app/models/models.dart';
import 'package:my_desktop_app/provider/provider.dart';
import 'package:my_desktop_app/theme/app_theme.dart';
import 'package:my_desktop_app/widgets/custom_error_message.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ContentStatistics extends StatelessWidget {
  const ContentStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginProvider loginProvider = Provider.of<LoginProvider>(context);
    final TaskProvider taskProvider = Provider.of<TaskProvider>(context);
    final HomeEmployeeProvider employeeProvider =
        Provider.of<HomeEmployeeProvider>(context);
    final StatisticsProvider statisticsProvider =
        Provider.of<StatisticsProvider>(context);
    return StreamBuilder(
      stream: loginProvider.employee,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Employee employee = snapshot.data!;
          return StreamBuilder(
            stream: taskProvider.taskData(employee.company),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                List<Task> tareas = snapshot.data!;
                if (tareas == [defaulttask]) {
                  return const CustomErrorMessage();
                } else {
                  int pendientes = tareas
                      .where((element) => element.status == "Pendiente")
                      .length;
                  int finalizadas = tareas
                      .where((element) => element.status == "Finalizado")
                      .length;
                  int canceladas = tareas
                      .where((element) => element.status == "Cancelado")
                      .length;
                  return StreamBuilder(
                    stream: employeeProvider.employeesData,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<String> empleadosDNI = [];
                        List<Employee> empleados = snapshot.data!;
                        for (var element in empleados) {
                          empleadosDNI.add(element.dni);
                        }
                        return StreamBuilder(
                          stream: statisticsProvider
                              .getEmployeesAndHours(empleadosDNI),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              Map<String, int> lista = snapshot.data!;
                              List<ChartData> validList = [];
                              lista.forEach((key, value) {
                                validList.add(ChartData(key, value));
                              });
                              return Row(
                                children: [
                                  SizedBox(
                                    width: 480,
                                    height: 560,
                                    child: SfCircularChart(
                                      palette: <Color>[
                                        Colors.amber.shade700,
                                        AppTheme.primary,
                                        Colors.red.shade700,
                                      ],
                                      legend: Legend(
                                        isVisible: true,
                                        position: LegendPosition.bottom,
                                        borderColor: Colors.black,
                                        borderWidth: 2,
                                      ),
                                      title: ChartTitle(
                                        text: 'ESTADO DE LA TAREAS',
                                        textStyle: const TextStyle(
                                          color: AppTheme.primary,
                                          fontSize: 25,
                                        ),
                                      ),
                                      series: <CircularSeries>[
                                        DoughnutSeries<ChartData, String>(
                                          dataSource: [
                                            ChartData('Pen', pendientes),
                                            ChartData('Fin', finalizadas),
                                            ChartData('Can', canceladas),
                                          ],
                                          xValueMapper: (ChartData data, _) =>
                                              data.x,
                                          yValueMapper: (ChartData data, _) =>
                                              data.y,
                                          dataLabelSettings:
                                              const DataLabelSettings(
                                            isVisible: true,
                                            showZeroValue: false,
                                            textStyle: TextStyle(fontSize: 30),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 480,
                                    height: 560,
                                    child: SfCartesianChart(
                                      title: ChartTitle(
                                        text: 'HORAS TRABAJADAS',
                                        textStyle: const TextStyle(
                                          color: AppTheme.primary,
                                          fontSize: 25,
                                        ),
                                      ),
                                      enableAxisAnimation: true,
                                      primaryXAxis: CategoryAxis(
                                        majorGridLines:
                                            const MajorGridLines(width: 0),
                                        axisLine: const AxisLine(width: 0),
                                        interval: 1,
                                      ),
                                      primaryYAxis: NumericAxis(),
                                      enableSideBySideSeriesPlacement: false,
                                      series: <ChartSeries>[
                                        BarSeries<ChartData, String>(
                                          dataSource: validList,
                                          xValueMapper: (ChartData data, _) =>
                                              data.x,
                                          yValueMapper: (ChartData data, _) =>
                                              data.y,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: AppTheme.primary,
                                ),
                              );
                            }
                          },
                        );
                      } else {
                        return Container();
                      }
                    },
                  );
                }
              } else {
                return Container();
              }
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final int y;
}
