import 'package:dio/dio.dart';
import 'package:nodo_app_2/config/constants/enviroments.dart';

final Dio dio = Dio(BaseOptions(baseUrl: Enviroments.apiUrl));

class ApiClient {
  // final Dio _dio = Dio();

  Future getHttp({required String path}) async {
    // final userToken = await setKeyValue.getKeyValue<String>('userToken');
    try {
      final response = await dio.get(path,
          options: Options(headers: {
            // 'Authorization': 'Bearer $userToken',
          }));

      return response;
    } on DioException catch (dioError) {
      return dioError.response;
    } catch (error) {
      return error;
    }
  }

  // Future /* <List<String>>  */ fetchIngresos() async {
  //   try {
  //     final response = await dio.get('/ingresos');
  //     return List<String>.from(response.data);
  //   } catch (e) {
  //     print('Error fetching ingresos: $e');
  //     return e; // Return ;empty list on error
  //   }
  // }
}
