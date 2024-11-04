import 'dart:io';

import 'package:vacunas/models/vacuna_model.dart';
import 'package:vacunas/services/vacuna_services.dart';

main() async{
    int op;

    do{
        op = pintaMenuPaciente();

        switch (op){
            case 1:
                print('Introduce el dni del paciente: ');
                print(await pintaVacunasPaciente(stdin.readLineSync()!));
                break;
            case 2:
                print('Cerrando programa');
                break;
            default:
                print('Opción incorrecta');
                break;        
        }
    } while (op != 2);
}
int pintaMenuPaciente(){
    print('''Menú de Paciente
    1. Ver historial de vacunas
    2. Salir
    Elija una opción: ''');

    return int.parse(stdin.readLineSync()!);
}

//FUNCIÓN QUE PIDE AL USUARIO EL DNI, TRAE LAS VACUNAS DE LA BASE DE DATOS Y BUSCA VACUNAS QUE CONTENGAN EL DNI INTRODUCIDO Y LAS PINTA POR PANTALLA
//SI EL PACIENTE TIENE MÁS DE 1 VACUNA INYECTADA SE MUESTRA EL CERTIFICADO DE QUE ESTA TOTALMENTE VACUNADO
Future<String> pintaVacunasPaciente(String dni) async{
    VacunaServices vacunaServices = VacunaServices();
    List<Vacuna> vacunas = await vacunaServices.getVacunas();
    int numVacunasPaciente = 0;
    String resultado = '';

    vacunas.forEach((vacuna) {
      if (vacuna.idPaciente == dni){
        resultado += vacuna.toString();
        numVacunasPaciente++;
      } 
    });
    
    if (numVacunasPaciente == 0) resultado = 'No existe ningún registro de vacunación del paciente';
    else if (numVacunasPaciente > 1) resultado = 'Certificado de Vacunación de paciente\n' + resultado;
    

    return resultado;
}
//FUNCIÓN QUE PINTA TODAS LAS VACUNAS REGISTRADAS EN LA BASE DE DATOS
//DEJO ESTA FUNCIÓN PARA COMPROBAR QUE TRAE TODAS LAS VACUNAS EN CASO DE ERROR
Future<String> pintaVacunas() async{
  VacunaServices vacunaServices = VacunaServices();
  List<Vacuna> vacunas = await vacunaServices.getVacunas();

  String resultado = '';

  vacunas.forEach((vacuna) {
    resultado += vacuna.toString();
  });
  return resultado;
}