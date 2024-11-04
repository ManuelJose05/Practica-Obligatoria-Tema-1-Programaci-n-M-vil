import 'dart:convert';

import 'package:vacunas/models/vacuna_model.dart';
import 'package:http/http.dart';
class VacunaServices {
  //URL DE LA BASE DE DATOS DE FIREBASE QUE CONTIENE LA INFORMACIÓN DE LAS VACUNAS
  final String _url = 'https://pruebafirebase-8d04b-default-rtdb.europe-west1.firebasedatabase.app/vacunas';

  //MÉTODO QUE REALIZA UNA PETICIÓN A LA BASE DE DATOS DE FIREBASE Y DEVUELVE TODAS LAS VACUNAS REGISTRADAS
  Future<List<Vacuna>> getVacunas() async{
    Uri uri = Uri.parse('$_url.json');
    List<Vacuna> vacunas = [];
    Response response = await get(uri);

    Map<String,dynamic> firebase = jsonDecode(response.body);

    firebase.forEach((clave,valor) {
      Vacuna temp = Vacuna.fromJson(valor);
      temp.id = clave;
      vacunas.add(temp);
    });
    return vacunas;
  }

  //MÉTODO QUE AGREGA A LA BASE DE DATOS UNA NUEVA VACUNA
  Future<String> postVacuna(Vacuna v) async{
    Uri uri = Uri.parse('$_url.json');
    Response idVacuna = await post(uri,body: jsonEncode(v));

    return jsonDecode(idVacuna.body)['name'];
  }
}