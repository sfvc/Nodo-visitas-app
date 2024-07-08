import 'package:flutter_dotenv/flutter_dotenv.dart';

class Enviroments {
  static initEnviroment() async {
    await dotenv.load(fileName: ".env");
  }
  static String apiUrl = dotenv.env['API_URL'] ?? 'No hay apiUrl';
}