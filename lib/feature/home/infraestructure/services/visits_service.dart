import 'package:dio/dio.dart';
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

  Future createNewVisit(Object body) async {
    try {
      final apiResponse = await api.postHttp(path: '/ingresos', body: body);
      return;
    } on DioException catch (error) {
      return error.response;
    }
  }

  Future getPeronaByDni(String dni) async {
    try {
      final apiResponse = await api.postHttp(path: '/persona/buscar/dni/$dni');
      return apiResponse;
    } on DioException catch (error) {
      return error.response;
    }
  }
}
