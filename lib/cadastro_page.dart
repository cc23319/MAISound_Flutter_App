import 'package:flutter/material.dart';
import './services/user_service.dart';
import 'package:maisound/login_page.dart';

class CadastroPage extends StatefulWidget {
  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final UserService _userService = UserService();

  void _register() async {
    try {
      var response = await _userService.registerUser(
        _nameController.text,
        _emailController.text,
        _passwordController.text,
      );
      print('Usuário registrado: $response');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } catch (e) {
      print('Erro ao registrar: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF333441), // Cor de fundo
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          width: double.infinity, // Para ocupar toda a largura
          constraints: BoxConstraints(maxWidth: 400), // Limitar a largura
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Campos de texto e botão de cadastro aqui
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'User',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Email',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: 'Password',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                obscureText: true,
              ),
              SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: _register,
                child: Text('Create'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Cor do botão
                  padding: EdgeInsets.symmetric(vertical: 14.0),  
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              // Link para Login
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Text(
                  "Já tem cadastro? Faça login",
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
