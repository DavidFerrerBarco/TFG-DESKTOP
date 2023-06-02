import 'package:flutter/material.dart';
import 'package:my_desktop_app/constants/constants.dart';
import 'package:my_desktop_app/models/models.dart';
import 'package:my_desktop_app/provider/provider.dart';
import 'package:my_desktop_app/theme/app_theme.dart';
import 'package:my_desktop_app/widgets/widget.dart';
import 'package:provider/provider.dart';

class ContentEmployeeAddPut extends StatelessWidget {
  final HomeEmployeeProvider employeeProvider;
  final Function onOptionChanged;

  const ContentEmployeeAddPut({
    super.key,
    required this.employeeProvider,
    required this.onOptionChanged,
  });

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> myEmployeeFormKey = GlobalKey<FormState>();
    final Map<String, dynamic> formValues = {
      'name': '',
      'dni': '',
      'contract': 0
    };

    final LoginProvider loginProvider = Provider.of<LoginProvider>(context);

    Stream<String> nameemployee = employeeProvider.employeename;
    Stream<String> dniemployee = employeeProvider.employeedni;
    Stream<int> contractemployee = employeeProvider.employeecontract;
    Stream<bool> iscreate = employeeProvider.create;

    var name = TextEditingController();
    var dni = TextEditingController();
    var contract = 0;
    bool create = false;

    nameemployee.listen((data) {
      name.value = TextEditingValue(text: data);
    });

    dniemployee.listen((data) {
      dni.value = TextEditingValue(text: data);
    });

    contractemployee.listen((data) {
      contract = data;
    });

    return StreamBuilder<bool>(
      stream: loginProvider.isdeveloper,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          bool developer = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              children: [
                ButtonEmployeeOption(
                  onOptionChanged: onOptionChanged,
                  content: 'Volver',
                  option: listavistaempleado[0],
                  employeeProvider: employeeProvider,
                ),
                StreamBuilder(
                  stream: iscreate,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      create = snapshot.data!;
                      return SizedBox(
                        width: 500,
                        child: Form(
                          key: myEmployeeFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                create ? "Crear Empleado" : "Editar Empleado",
                                style: const TextStyle(
                                  color: AppTheme.primary,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 8,
                                ),
                              ),
                              const SizedBox(height: 30),
                              CustomInputField(
                                controller: name,
                                prefixIcon: Icons.person,
                                labelText: 'Nombre',
                                hintText: 'Nombre del empleado',
                                formProperty: 'name',
                                formValues: formValues,
                              ),
                              const SizedBox(height: 30),
                              CustomInputField(
                                controller: dni,
                                prefixIcon: Icons.edit_document,
                                labelText: 'DNI',
                                hintText: 'DNI del empleado',
                                formProperty: 'dni',
                                formValues: formValues,
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'CONTRATO',
                                style: TextStyle(
                                  color: AppTheme.primary,
                                  fontSize: 23,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 3,
                                ),
                              ),
                              const SizedBox(height: 10),
                              StreamBuilder<Company>(
                                stream: employeeProvider.companyData,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    Company company = snapshot.data!;
                                    return DropdownButtonFormField(
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
                                      value: company.contractTypes
                                              .contains(contract)
                                          ? contract
                                          : company.contractTypes[0],
                                      onChanged: (item) {
                                        employeeProvider
                                            .setEmployeeName(name.text);
                                        employeeProvider
                                            .setEmployeeDni(dni.text);
                                        employeeProvider
                                            .setEmployeeContract(item!);
                                      },
                                      items: company.contractTypes
                                          .map(
                                            (item) => DropdownMenuItem<int>(
                                              value: item,
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    Icons
                                                        .content_paste_search_rounded,
                                                    color: AppTheme.primary,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  Text(
                                                    item.toString(),
                                                    style: const TextStyle(
                                                        fontSize: 22),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                          .toList(),
                                    );
                                  } else {
                                    return const SizedBox(height: 62);
                                  }
                                },
                              ),
                              const SizedBox(height: 50),
                              ElevatedButton(
                                onPressed: () {
                                  employeeProvider.addEmployeeDataPost(
                                    name.text,
                                    dni.text,
                                    contract,
                                  );

                                  if (create) {
                                    employeeProvider
                                        .postEmployee(developer, contract)
                                        .then((value) {
                                      if (value) {
                                        employeeProvider.resetEmployeeForm();
                                        onOptionChanged(listavistaempleado[0]);
                                      } else {}
                                    });
                                  } else {
                                    employeeProvider
                                        .putEmployee(contract)
                                        .then((value) {
                                      if (value) {
                                        employeeProvider.resetEmployeeForm();
                                        onOptionChanged(listavistaempleado[0]);
                                      }
                                    });
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
                                      style: AppTheme
                                          .lightTheme.textTheme.labelLarge,
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
