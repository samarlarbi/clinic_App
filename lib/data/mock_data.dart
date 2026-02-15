import 'package:cliniccxc/models/patient.dart';

import '../models/user.dart';

List<User> users = [
  User(
    username: 'admin',
    password: '1234',
    role: UserRole.admin,
  ),
  User(
    username: 'patient',
    password: '1111',
    role: UserRole.patient,
    patientName: 'patient test',
  ),
  User(
    username: 'killua',
    password: '2222',
    role: UserRole.patient,
    patientName: 'Killua Zoldyck',
  ),
];

List<Patient> patients = [
  Patient(
    name: 'patient',
    treatment: 'Checkup',
    appointment: DateTime.now().add(const Duration(days: 1)),
  ),
  Patient(
    name: 'Killua Zoldyck',
    treatment: 'Vaccination',
    appointment: DateTime.now().add(const Duration(days: 2)),
  ),
];
