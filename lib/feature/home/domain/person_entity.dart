class Persona {
  final int id;
  final String nombre;
  final String apellido;
  final String dni;
  final String telefono;

  Persona({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.dni,
    required this.telefono,
  });

  factory Persona.fromJson(Map<String, dynamic> json) {
    return Persona(
      id: json['id'],
      nombre: json['nombre'],
      apellido: json['apellido'],
      dni: json['dni'],
      telefono: json['telefono'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'apellido': apellido,
      'dni': dni,
      'telefono': telefono,
    };
  }
}
