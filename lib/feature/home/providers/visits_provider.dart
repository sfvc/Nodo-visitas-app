import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nodo_app_2/feature/home/domain/visit_entity.dart';
import 'package:nodo_app_2/feature/home/infraestructure/services/visits_service.dart';

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

