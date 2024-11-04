class Vacuna {
  //ATRIBUTOS CLASE VACUNA
   String? id;
   int idMedico;
   String nombre;
   String lugarVacunacion;
   String fechaVacunacion;
   String idPaciente;

  //CONSTRUCTORES CLASE VACUNA
  Vacuna({
    required this.idMedico,
    required this.nombre,
    required this.lugarVacunacion,
    required this.fechaVacunacion,
    required this.idPaciente
  });

  factory Vacuna.fromJson(Map<String,dynamic> json) => Vacuna (
    idMedico : json['idMedico'],
    nombre : json['nombre'],
    lugarVacunacion : json['lugarVacunacion'],
    fechaVacunacion : json['fechaVacunacion'],
    idPaciente : json['idPaciente'],
  );

  Map<String, dynamic> toJson() => {
        "idMedico": idMedico,
        "nombre": nombre,
        "lugarVacunacion": lugarVacuna,
        "fechaVacunacion": fechaVacunacion,
        "idPaciente": idPaciente
    };

  //SETTER Y GETTER
  int get idMedic => idMedico;
  String get nombreVacuna => nombre;
  String get lugarVacuna => lugarVacunacion;
  String get fechaVacuna => fechaVacunacion;
  String get idPersona => idPaciente;

  set idVacuna(String id) => this.id = id;
  set idProfesional(int idMedico) => this.idMedico = idMedico;
  set nombreVacuna(String nombre) => this.nombre = nombre;
  set lugarVacuna(String lugar) => lugarVacunacion = lugar;
  set fechaVacuna(String fecha) => fechaVacunacion = fecha;
  set idEnfermo(String id) => idPaciente = id;

  //METODOS CLASE VACUNA

  // String formateFecha(String fecha){
  //     String fechaFormateada = DateFormat('dd/MM/yyyy').format(DateTime.parse(fecha));
  //   return fechaFormateada;
  // }
  @override
  String toString() {
    return '''=== INFORMACIÓN DE LA VACUNA ===
    Lote: $id
    Nombre de la vacuna: $nombreVacuna
    Lugar de vacunación: $lugarVacunacion
    Fecha de vacunación: $fechaVacuna
    Dni Paciente vacunado: $idPaciente\n''';
  }
}