class Formulario {
  final String tipoSangre;
  final String nombre;
  final String apellidoPaterno;
  final String apellidoMaterno;
  final String rfc;
  final String calle;
  final String colonia;
  final String numero;
  final int edad;
  final String enfermedades;
  final String telefonoCasa;
  final String telefonoMovil;
  final String actaNacimiento;
  final String curp;
  final String ine;
  final String user;
  final DateTime createdAt;
  final DateTime updatedAt;

  Formulario({
    required this.tipoSangre,
    required this.nombre,
    required this.apellidoPaterno,
    required this.apellidoMaterno,
    required this.rfc,
    required this.calle,
    required this.colonia,
    required this.numero,
    required this.edad,
    required this.enfermedades,
    required this.telefonoCasa,
    required this.telefonoMovil,
    required this.actaNacimiento,
    required this.curp,
    required this.ine,
    required this.user,
    required this.createdAt,
    required this.updatedAt,
  });

  // Método para convertir un JSON en un objeto Formulario
  factory Formulario.fromJson(Map<String, dynamic> json) {
    return Formulario(
      tipoSangre: json['tipoSangre'],
      nombre: json['nombre'],
      apellidoPaterno: json['apellidoPaterno'],
      apellidoMaterno: json['apellidoMaterno'],
      rfc: json['rfc'],
      calle: json['calle'],
      colonia: json['colonia'],
      numero: json['numero'],
      edad: json['edad'],
      enfermedades: json['enfermedades'],
      telefonoCasa: json['telefonoCasa'],
      telefonoMovil: json['telefonoMovil'],
      actaNacimiento: json['actaNacimiento'],
      curp: json['curp'],
      ine: json['ine'],
      user: json['user'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  // Método para convertir un objeto Formulario en un JSON
  Map<String, dynamic> toJson() {
    return {
      'tipoSangre': tipoSangre,
      'nombre': nombre,
      'apellidoPaterno': apellidoPaterno,
      'apellidoMaterno': apellidoMaterno,
      'rfc': rfc,
      'calle': calle,
      'colonia': colonia,
      'numero': numero,
      'edad': edad,
      'enfermedades': enfermedades,
      'telefonoCasa': telefonoCasa,
      'telefonoMovil': telefonoMovil,
      'actaNacimiento': actaNacimiento,
      'curp': curp,
      'ine': ine,
      'user': user,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
