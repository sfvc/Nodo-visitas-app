import 'package:nodo_app_2/feature/home/domain/person_entity.dart';

class Visita {
  final int id;
  final String tiempo;
  final String motivo;
  final String dia;
  final String hora;
  final Persona persona;

  Visita({
    required this.id,
    required this.tiempo,
    required this.motivo,
    required this.dia,
    required this.hora,
    required this.persona,
  });
}
