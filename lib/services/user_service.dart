import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  // URL base da API
  final String baseUrl = "http://localhost:5000";

  // Método para registrar um novo usuário
  Future<Map<String, dynamic>> registerUser(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Erro ao registrar usuário: ${response.body}');
    }
  }

  // Método para fazer login
  Future<Map<String, dynamic>> loginUser(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body); // Retorna o token e informações do usuário
    } else {
      throw Exception('Erro ao fazer login: ${response.body}');
    }
  }
}
