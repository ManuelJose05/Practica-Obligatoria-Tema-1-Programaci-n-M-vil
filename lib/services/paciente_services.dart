import 'dart:convert';
import 'package:vacunas/models/paciente_model.dart';
import 'package:http/http.dart';

class PacienteServices {
  //URL DE LA BASE DE DATOS DE FIREBASE QUE CONTIENE LA INFORMACIÓN DE LOS PACIENTES
  final String _url = 'https://pruebafirebase-8d04b-default-rtdb.europe-west1.firebasedatabase.app/pacientes';

  //MÉTODO QUE HACE UNA PETICIÓN A FIREBASE Y DEVUELVE LA INFORMACIÓN DE TODOS LOS PACIENTES.
  Future<List<Paciente>> httpGetPacientes() async{
    Uri uri = Uri.parse("$_url.json");
    List<Paciente> pacientes = [];

    Response response = await get(uri);
    Map<String,dynamic> fireBase = jsonDecode(response.body);

    fireBase.forEach((clave,valor) {
      Paciente temp = Paciente.fromJson(valor);

      temp.id = clave;
      pacientes.add(temp);
    });
    return pacientes;
  }

  //MÉTODO QUE AGREGA UN PACIENTE A LA BASE DE DATOS DE FIREBASE
  Future<String> postPaciente(Paciente p) async{
    Uri uri = Uri.parse("$_url.json");
    Response response = await post(uri,body: jsonEncode(p));

    return jsonDecode(response.body)['name'];
  }
}