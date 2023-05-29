import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_desktop_app/constants/constants.dart';
import 'package:my_desktop_app/provider/provider.dart';
import 'package:my_desktop_app/theme/app_theme.dart';
import 'package:my_desktop_app/widgets/widget.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class HomeContentEmpresaAdd extends StatelessWidget {

  final HomeProvider homeProvider;
  final Function onOptionChanged;

  const HomeContentEmpresaAdd({
    super.key, 
    required this.homeProvider,
    required this.onOptionChanged,
  });

  @override
  Widget build(BuildContext context) {

    final HomeProvider homeProvider = Provider.of<HomeProvider>(context);

    final GlobalKey<FormState> myCompanyFormKey = GlobalKey<FormState>();
    final Map<String, dynamic> formValues = {'name': '', 'address':'', 'contractTypes': <int>[]};

    Stream<String> namecompany = homeProvider.companyname;
    Stream<String> addresscompany = homeProvider.companyaddress;

    var name = TextEditingController();
    var address = TextEditingController();
    var contractType = TextEditingController();

    namecompany.listen((data) {
      name.value = TextEditingValue( text: data);
    });

    addresscompany.listen((data) {
      address.value = TextEditingValue( text: data );
    });

    return  SingleChildScrollView(
      child: Column(
        children: [
          HomeButtonOption(
            onOptionChanged: onOptionChanged,
            content: 'Volver',
            option: listavistaempresa[0],
          ),
          SizedBox(
            width: 500,
            child: Form(
              key: myCompanyFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Crear Empresa', 
                    style: TextStyle(
                      color: AppTheme.primary,
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 8,
                    ),
                  ),
                  const SizedBox(height: 40),
                  CustomInputField(
                    controller: name,
                    prefixIcon: Icons.business_rounded,
                    labelText: 'Empresa',
                    hintText: 'Nombre de la empresa',
                    formProperty: 'name',
                    formValues: formValues,
                  ),
                  const SizedBox(height: 50),
                  CustomInputField(
                    controller: address,
                    prefixIcon: Icons.house_rounded,
                    labelText: 'Dirección',
                    hintText: 'Dirección de la empresa',
                    formProperty: 'address',
                    formValues: formValues,
                  ),
                  const SizedBox(height: 50),
                  CustomInputField(
                    controller: contractType,
                    prefixIcon: Icons.history_toggle_off_rounded,
                    suffixIcon: Icons.add_circle_rounded,
                    labelText: 'Horas Contrato',
                    hintText: 'Horas del contrato',
                    formProperty: 'contractTypes',
                    formValues: formValues,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    onPressed: () {
                      if(contractType.text.isNotEmpty){
                        homeProvider.addToHourList(
                          name.text, 
                          address.text,  
                          int.parse(contractType.text),
                        );
                      }
                    } 
                  ),
                  const SizedBox(height: 10),
                  StreamBuilder(
                    stream: homeProvider.listahoras,
                    builder: (context, snapshot) {
                      if(snapshot.hasData)
                      {
                        return SizedBox(
                          height: 35,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.length,
                            separatorBuilder: (context, index) {
                              return const SizedBox(width: 10);
                            },
                            itemBuilder: (context, index) {
                              return CardContractType(
                                index: index, 
                                snapshot: snapshot, 
                                homeProvider: homeProvider, 
                                name: name, 
                                address: address,
                              );
                            },
                          ),
                        );
                      }else{
                        return const SizedBox(height: 25);
                      }
                    },
                  ),
                  const SizedBox(height: 70),
                  ElevatedButton(
                    onPressed: () {
                      homeProvider.addCompanyName(name.text);
                      homeProvider.addCompanyAddress(address.text);
                      
                      homeProvider.postCompany()
                        .then((value) {
                          if(value){
                            homeProvider.resetCompanyForm();
                            onOptionChanged(listavistaempresa[0]);
                          }else{
                            
                          }
                        });
                    },
                    style: AppTheme.lightTheme.elevatedButtonTheme.style,
                    child: SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: Center(
                        child: Text(
                          'Crear', 
                          style: AppTheme.lightTheme.textTheme.labelLarge
                        ), 
                      ),
                    )
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