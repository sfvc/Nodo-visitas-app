import 'package:nodo_app_2/feature/home/domain/person_entity.dart';
import 'package:nodo_app_2/feature/home/domain/visit_entity.dart';

class VisitMapper {
  static Visita visitaJsonToEntity(Map<String, dynamic> json) {
    return Visita(
        id: json['id'] ?? '',
        tiempo: json['tiempo'] ?? '',
        motivo: json['motivo'] ?? '',
        dia: json['dia'] ?? '',
        hora: json['hora'] ?? '',
        persona: personaJsonToEntity(json['persona']));
  }

  static Persona personaJsonToEntity(Map<String, dynamic> json) {
    return Persona(
        id: json['id'] ?? '',
        nombre: json['nombre'] ?? '',
        apellido: json['apellido'] ?? '',
        dni: json['dni'] ?? '',
        telefono: json['telefono'] ?? '',
        funcion: json['funcion'] ?? '');
  }
}

class PersonaMapper {
  static Persona personaJsonToEntity(Map<String, dynamic> json) {
    return Persona(
        id: json['id'] ?? '',
        nombre: json['nombre'] ?? '',
        apellido: json['apellido'] ?? '',
        dni: json['dni'] ?? '',
        telefono: json['telefono'] ?? '',
        funcion: json['funcion'] ?? '');
  }

  // static Map<String, dynamic> toJson(Persona persona) {
  //   return {
  //     'id': persona.id,
  //     'nombre': persona.nombre,
  //     'apellido': persona.apellido,
  //     'dni': persona.dni,
  //     'telefono': persona.telefono,
  //   };
  // }
}
