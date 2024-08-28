import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nodo_app_2/feature/home/domain/person_entity.dart';
import 'package:nodo_app_2/feature/ingresos/domain/entiy/visit_entity.dart';
import 'package:nodo_app_2/feature/ingresos/domain/services/visits_service.dart';

final visitService = VisitService();

final currentVisitsProvider = FutureProvider<List<Visita>>((ref) async {
  try {
    final apiResponse = await visitService.getCurrentVisits();
    return apiResponse;
  } catch (error) {
    throw Error();
  }
});

final visitsProvider = FutureProvider<List<Visita>>((ref) async {
  try {
    final apiResponse = await visitService.getVisits();
    return apiResponse;
  } catch (error) {
    throw Error();
  }
});

final employesProvider = FutureProvider<List<Persona>>((ref) async {
  try {
    final apiResponse = await visitService.getPersonas();
    return apiResponse;
  } catch (error) {
    throw Error();
  }
});

final searchPersonaByDniProvider =
    FutureProvider.family<Persona, String>((ref, dni) async {
  try {
    final apiResponse = await visitService.getPeronaByDni(dni: dni);
    return apiResponse;
  } catch (error) {
    throw Error();
  }
});
