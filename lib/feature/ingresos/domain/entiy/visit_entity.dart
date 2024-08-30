import 'package:nodo_app_2/feature/home/domain/person_entity.dart';

class Visita {
  final int turno;
  final int id;
  final DateTime fechaCreacion;
  final String? motivo;
  final int? personaId;
  final Persona? persona;

  Visita({
    required this.id,
    required this.turno,
    required this.fechaCreacion,
    this.motivo,
    this.personaId,
    this.persona,
  });
}
