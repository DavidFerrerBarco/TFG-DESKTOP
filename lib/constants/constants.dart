import 'package:my_desktop_app/models/models.dart';

const developercompany = "Employee Diary";

final List<String> listaventanasdeveloper = [
  'EMPRESAS',
  'NOTICIAS',
  'CERRAR SESIÓN',
];

final List<String> listaventanasadmin = [
  'EMPLEADOS',
  'ANUNCIOS',
  'HORARIOS',
  'TAREAS',
  'ESTADÍSTICAS',
  'CERRAR SESIÓN',
];

final List<String> listavistaempresa = [
  'DATA',
  'CREATE_EDIT',
];

final List<String> listavistaempleado = [
  'DATA',
  'CREATE_EDIT',
];

final List<String> listavistanoticias = [
  'DATA',
  'CREATE_EDIT',
];

const casa = '192.168.0.11';
const trabajo = '10.0.1.198';
const baseUrl = '$casa:3000';

final List<Company> companiesDefault = <Company>[companydefault];

final Company companydefault =
    Company(id: '', name: '', address: '', contractTypes: <int>[], v: 0);

final List<News> newsDefault = <News>[
  News(id: '', title: '', content: '', date: '', v: 0),
];

final Employee defaultemployee = Employee(
  id: '',
  name: '',
  dni: '',
  password: '',
  company: '',
  contract: 0,
  admin: false,
  email: '',
  v: 0,
  token: '',
);

final CustomError defaulterror = CustomError(
  id: '',
  name: '',
);
