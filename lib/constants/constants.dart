import 'package:my_desktop_app/models/models.dart';

const developercompany = "Employee Diary";

const casa = '192.168.0.11';
const trabajo = '10.0.1.198';
const baseUrl = '$casa:3000';

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
  'SOLICITUDES',
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

final List<String> listavistaanuncios = [
  'DATA',
  'CREATE_EDIT',
];

final List<String> listavistahorario = [
  'DATA',
  'CREATE_EDIT',
];

final List<String> listavistatareas = [
  'DATA',
  'CREATE_EDIT',
];

final List<String> listavistasolicitudes = [
  'DATA',
  'DETAILS',
];

final List<Company> companiesDefault = <Company>[companydefault];

final Company companydefault = Company(
  id: '',
  name: '',
  address: '',
  contractTypes: <int>[],
  v: 0,
);

final List<News> newsDefault = <News>[
  News(
    id: '',
    title: '',
    content: '',
    date: '',
    v: 0,
  ),
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

final Announcement defaultannouncement = Announcement(
  id: '',
  title: '',
  content: '',
  company: '',
  date: '',
  v: 0,
);

final Schedule defaultschedule = Schedule(
  id: '',
  employee: '',
  day: '',
  hours: [],
  hoursCount: 0,
  v: 0,
);

final Task defaulttask = Task(
  id: '',
  title: '',
  content: '',
  day: '',
  employee: '',
  status: '',
  date: '',
  v: 0,
);

final Request defaultrequest = Request(
  title: '',
  content: '',
  employee: '',
  id: '',
  date: '',
  v: 0,
);

final List<String> listahorasdefault = [
  '00:00',
  '01:00',
  '02:00',
  '03:00',
  '04:00',
  '05:00',
  '06:00',
  '07:00',
  '08:00',
  '09:00',
  '10:00',
  '11:00',
  '12:00',
  '13:00',
  '14:00',
  '15:00',
  '16:00',
  '17:00',
  '18:00',
  '19:00',
  '20:00',
  '21:00',
  '22:00',
  '23:00',
];
