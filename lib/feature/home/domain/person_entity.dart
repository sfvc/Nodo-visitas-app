class Persona {
  final int id;
  final String nombre;
  final String apellido;
  final String dni;
  final String telefono;
  final String funcion;

  Persona({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.dni,
    required this.telefono,
    required this.funcion,
  });

  factory Persona.fromJson(Map<String, dynamic> json) {
    return Persona(
      id: json['id'],
      nombre: json['nombre'],
      apellido: json['apellido'],
      dni: json['dni'],
      telefono: json['telefono'],
      funcion: json['funcion'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'apellido': apellido,
      'dni': dni,
      'telefono': telefono,
      'funcion': funcion
    };
  }
}
