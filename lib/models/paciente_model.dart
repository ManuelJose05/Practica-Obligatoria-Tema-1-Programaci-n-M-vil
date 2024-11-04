// ignore: unused_import
import 'dart:convert';

class Paciente {
  //ATRIBUTOS CLASE PACIENTE
  String? id;
  String dni;
  String nombre;

  //CONSTRUCTORES CLASE PACIENTE
  Paciente({
    required this.dni,
    required this.nombre
  });
  
  factory Paciente.fromJson(Map<String, dynamic> json) => Paciente(
        dni: json["dni"],
        nombre: json["nombre"],
    );

    Map<String, dynamic> toJson() => {
        "dni": dni,
        "nombre": nombre,
    };

  //GETTER Y SETTER CLASE PACIENTE
  String get dniPaciente => dni;
  String get nombrePaciente => nombre;

  set dniPaciente(String dni) => this.dni = dni;
  set nombrePaciente(String nombre) => this.nombre = nombre;

    //MÉTODOS CLASE PACIENTE
    @override
  String toString() {
    return '''=== INFORMACIÓN DE PACIENTE ===
    Nombre del paciente: $nombre
    DNI: $dni
    ==============================''';
  }
}