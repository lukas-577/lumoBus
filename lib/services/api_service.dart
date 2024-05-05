import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<Map<String, dynamic>> obtenerDatosParadero(
      String codigo) async {
    final url = Uri.parse('https://api.xor.cl/red/bus-stop/$codigo');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return jsonResponse;
      } else {
        throw Exception('Error al cargar los datos');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
}
