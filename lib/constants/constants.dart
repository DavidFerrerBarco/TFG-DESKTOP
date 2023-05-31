import 'package:my_desktop_app/models/models.dart';

final List<String> listaventanas = [
  'EMPRESAS',
  'NOTICIAS',
  'ESTADÍSTICAS',
  'CERRAR SESIÓN',
];

final List<String> listavistaempresa = [
  'DATA',
  'CREATE_EDIT',
];

const casa = '192.168.0.11';
const trabajo = '10.0.1.198';
const baseUrl = '$casa:3000';

final List<Company> companiesDefault = <Company>[
  Company(id: '', name: '', address: '', contractTypes: <int>[], v: 0),
];
