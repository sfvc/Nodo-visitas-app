import 'package:dio/dio.dart';
import 'package:nodo_app_2/config/constants/enviroments.dart';

final Dio dio = Dio(BaseOptions(baseUrl: 'http://192.168.101.216:3000/api'));

class ApiClient {
  // final Dio _dio = Dio();

  Future<List<Map<String, dynamic>>> fetchPersonas() async {
    try {
      final response = await dio.get('/persona');
      return List<Map<String, dynamic>>.from(response.data);
   
    } catch (e) {
      print('Error fetching personas: $e');
      return []; // Return empty list on error
    }
  }

  Future/* <List<String>>  */fetchIngresos() async {
    try {
      final  response = await dio.get('/ingresos');
      return List<String>.from(response.data);
    } catch (e) {
      print('Error fetching ingresos: $e');
      return e; // Return ;empty list on error
    }
  }
}
