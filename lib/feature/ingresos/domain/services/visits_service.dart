import 'package:dio/dio.dart';
import 'package:nodo_app_2/feature/home/domain/person_entity.dart';
import 'package:nodo_app_2/feature/ingresos/domain/entiy/visit_entity.dart';
import 'package:nodo_app_2/feature/ingresos/domain/mappers/visit_mapper.dart';
import 'package:nodo_app_2/shared/services/api_client.dart';
import 'package:nodo_app_2/shared/shared_wapper.dart';

final api = ApiClient();

class VisitService {
  final intlService = IntlService();

  Future getCurrentVisits() async {
    final currentDate = intlService.getCurrentDateFormatted();
    // const currentDate = 2024 - 07 - 19;

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
      final apiResponse = await api.getHttp(path: '/ingreso');
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
      throw Exception('Error de conexión: ${error.message}');
    } catch (e) {
      throw Exception('Error al obtener las visitas');
    }
  }

  Future createNewVisit(body) async {
    try {
      final apiResponse = await api.postHttp(path: '/ingreso', body: body);
      return apiResponse;
    } on DioException catch (error) {
      return error.response;
    }
  }

  Future getPersonas() async {
    try {
      final apiResponse = await api.getHttp(path: '/personas');
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
      final apiResponse = await api.getHttp(path: '/personas/dni/$dni');
      return apiResponse;
    } on DioException catch (error) {
      return error.response;
    }
  }
}
