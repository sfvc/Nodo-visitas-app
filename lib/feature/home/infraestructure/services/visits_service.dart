import 'package:dio/dio.dart';
import 'package:nodo_app_2/feature/home/domain/person_entity.dart';
import 'package:nodo_app_2/feature/home/domain/visit_entity.dart';
import 'package:nodo_app_2/feature/home/infraestructure/services/mappers/visit_mapper.dart';
import 'package:nodo_app_2/shared/services/api_client.dart';
import 'package:nodo_app_2/shared/shared_wapper.dart';

final api = ApiClient();

class VisitService {
  final intlService = IntlService();

  Future getCurrentVisits() async {
    final currentDate = intlService.getCurrentDateFormatted();

    try {
      final apiResponse =
          await api.getHttp(path: '/ingresos/buscar/$currentDate');
      if (apiResponse.statusCode == 200) {
        final List<dynamic> visitasList = apiResponse.data;
        final List<Visita> visitas = visitasList
            .map((visita) => VisitMapper.visitaJsonToEntity(visita))
            .toList();
        return visitas;
      } else {
        throw Exception('Error al traer listado de visitantes');
      }
    } on DioException catch (error) {
      return error.response;
    }
  }

  Future getVisits() async {
    try {
      final apiResponse = await api.getHttp(path: '/ingresos');
      if (apiResponse.statusCode == 200) {
        final List<dynamic> visitasList = apiResponse.data;
        final List<Visita> visitas = visitasList
            .map((visita) => VisitMapper.visitaJsonToEntity(visita))
            .toList();
        return visitas;
      } else {
        throw Exception('Error al traer listado de visitantes');
      }
    } on DioException catch (error) {
      return error.response;
    }
  }

  Future createNewVisit(body) async {
    try {
      final apiResponse = await api.postHttp(path: '/ingresos', body: body);
      return apiResponse;
    } on DioException catch (error) {
      return error.response;
    }
  }

  Future getPersonas() async {
    try {
      final apiResponse = await api.getHttp(path: '/persona');
      if (apiResponse.statusCode == 200) {
        final List<dynamic> empleadosList = apiResponse.data;
        final List<Persona> empleados = empleadosList
            .map((visita) => PersonaMapper.personaJsonToEntity(visita))
            .toList();
        return empleados;
      } else {
        throw Exception('Error al traer listado de visitantes');
      }
    } on DioException catch (error) {
      return error.response;
    }
  }

  Future getPeronaByDni({required String dni}) async {
    try {
      final apiResponse = await api.getHttp(path: '/persona/buscar/dni/$dni');
      return apiResponse;
    } on DioException catch (error) {
      return error.response;
    }
  }
}
