import 'package:nodo_app_2/feature/home/domain/area.entity.dart';
import 'package:nodo_app_2/feature/home/domain/person_entity.dart';
import 'package:nodo_app_2/feature/ingresos/domain/entiy/visit_entity.dart';

class VisitMapper {
  static Visita visitaJsonToEntity(Map<String, dynamic> json) {
    return Visita(
      id: json['id'] ?? 0,
      turno: json['turno'] ?? 0,
      fechaCreacion: DateTime.parse(json['createdAt']),
      motivo: json['motivo'],
      personaId: json['personaId'],
      persona: json['persona'] != null
          ? PersonaMapper.personaJsonToEntity(json['persona'])
          : null,
    );
  }

  static Persona personaJsonToEntity(Map<String, dynamic> json) {
    return Persona(
        id: json['id'] ?? 0,
        nombre: json['nombre'] ?? '',
        apellido: json['apellido'] ?? '',
        dni: json['dni'] ?? '',
        telefono: json['telefono'] ?? '',
        funcion: json['funcion'] ?? '',
        tipoPersona: json['tipoPersona'] ?? 0);
  }
}

class PersonaMapper {
  static Persona personaJsonToEntity(Map<String, dynamic> json) {
    return Persona(
      id: json['id'] ?? 0,
      nombre: json['nombre'] ?? '',
      apellido: json['apellido'] ?? '',
      dni: json['dni'] ?? '',
      telefono: json['telefono'],
      tipoPersona: json['tipoPersona'] ?? 0,
      areaId: json['areaId'],
      area: json['area'] != null
          ? AreaMapper.areaJsonToEntity(json['area'])
          : null,
    );
  }
}

class AreaMapper {
  static Area areaJsonToEntity(Map<String, dynamic> json) {
    return Area(
      id: json['id'] ?? 0,
      nombre: json['nombre'] ?? '',
      fechaCreacion: DateTime.parse(json['createdAt']),
    );
  }
}
