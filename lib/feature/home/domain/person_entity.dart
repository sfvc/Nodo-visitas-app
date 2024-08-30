import 'package:nodo_app_2/feature/home/domain/area.entity.dart';

class Persona {
  final int id;
  final String nombre;
  final String apellido;
  final String dni;
  final int tipoPersona;
  final int? areaId;
  final String? telefono;
  final String? funcion;
  final Area? area;

  Persona({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.dni,
    required this.tipoPersona,
    this.funcion,
    this.telefono,
    this.areaId,
    this.area,
  });
}
