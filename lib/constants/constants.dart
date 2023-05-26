import 'package:my_desktop_app/models/models.dart';

final List<String> listaventanas = [
  'EMPRESAS',
  'NOTICIAS',
  'ESTADÍSTICAS',
  'CERRAR SESIÓN',
];

const baseUrl = '10.0.1.198:3000';

final List<Company> companiesDefault = <Company>[
  Company(id: '', name: '', address: '', contractTypes: <int>[], v: 0),
];