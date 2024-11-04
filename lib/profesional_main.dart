import 'dart:io';
import 'package:vacunas/models/paciente_model.dart';
import 'package:vacunas/models/vacuna_model.dart';
import 'package:vacunas/services/paciente_services.dart';
import 'package:vacunas/services/vacuna_services.dart';

void main(List<String> args) async {
  int op;
  do {
    op = menu();

    switch (op) {
      case 1:
        await inyectaVacuna();
        break;
      case 2:
        print('Cerrando programa');
        break;
      default:
        print('Opción incorrecta');
    }
  } while (op != 2);
}

//FUNCIÓN QUE MUESTRA POR PANTALLA UN PEQUEÑO MENÚ DE OPCIONES PARA EL USUARIO
int menu() {
  print('''
=== Menú de Médico ===
1. Añadir Vacuna
2. Salir
Elija una opción: ''');

  return int.parse(stdin.readLineSync()!);
}

//FUNCIÓN QUE PIDE EL DNI AL PROFESIONAL, SI EL DNI EXISTE COMPLETAMOS LA INFORMACIÓN DE LA NUEVA VACUNA INYECTADA Y SE SUBE A LA BASE DE DATOS
//EN CASO DE QUE NO EXISTA, SE PIDE EL NOMBRE DEL PACIENTE Y SE SUBE LA INFORMACIÓN TANTO DEL NUEVO PACIENTE COMO DE LA VACUNA INYECTADA
Future inyectaVacuna() async{
  VacunaServices vacunaServices = VacunaServices();
  print('Introduce el dni del paciente: ');
  String dniPaciente = stdin.readLineSync()!;

  bool existe = await buscaPacientePorDni(dniPaciente);
  if (!existe) {
    print('Paciente no encontrado en la base de datos. Proceciendo a su insercción');
    (await agregaPaciente(dniPaciente))? 'Paciente agregado con exito':'No se ha podido agregar el paciente';
  }
  print('Introduce el nombre de la vacuna');
  String nombreVacuna = stdin.readLineSync()!;

  print('Introduce el lugar de vacunación');
  String lugar = stdin.readLineSync()!;

  print('Introduce la fecha de vacunación: (YYYY-MM-DD)');
  String fechaVacunacion = stdin.readLineSync()!;

  print('Introduce tu id profesional: ');
  int idMedico = int.parse(stdin.readLineSync()!);

  Vacuna temp = Vacuna(idMedico: idMedico, nombre: nombreVacuna, lugarVacunacion: lugar, fechaVacunacion: fechaVacunacion, idPaciente: dniPaciente);

  if (await vacunaServices.postVacuna(temp) != '') print('Vacuna inyectada con exito');
}

//FUNCIÓN QUE RECIBE UN DNI, PIDE EL NOMBRE DEL PACIENTE Y LO SUBE A LA BASE DE DATOS PARA QUE QUEDE REGISTRADO
Future<bool> agregaPaciente(String dni) async{
  print('Introduce el nombre del paciente: ');
  String nombre = stdin.readLineSync()!;

  PacienteServices pacienteServices = PacienteServices();

  Paciente temp = Paciente(dni: dni, nombre: nombre);

  String id =  '';
  id = await pacienteServices.postPaciente(temp);

  if (id != '') {
    return true;
  } else {
    return false;
  }
}
//FUNCIÓN QUE BUSCA UN PACIENTE EN LA BASE DE DATOS POR SU DNI Y DEVUELVE UN BOOL (TRUE/FALSE)
Future<bool> buscaPacientePorDni(String dniPa) async{
  PacienteServices pacienteServices = PacienteServices();
  bool existe = false;
  List<Paciente> pacientes = await pacienteServices.httpGetPacientes();

  for (var paciente in pacientes) {
    if (paciente.dni == dniPa) existe = true;
  }
  return existe;
}

