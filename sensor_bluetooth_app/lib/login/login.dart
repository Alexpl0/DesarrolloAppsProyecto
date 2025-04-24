import 'package:flutter/material.dart';
import 'package:sensor_bluetooth_app/utils/assets.dart'; // Ruta a los recursos (como imágenes)

// Pantalla principal de Login
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // Variables para almacenar el texto ingresado por el usuario y la contraseña
  String usuarioText = "";
  String passwordText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Imagen de fondo que cubre toda la pantalla
          Image.asset(Assets.login, fit: BoxFit.cover),

          // Contenedor transparente que puedes usar como filtro o capa oscura si deseas
          Container(),

          // Formulario centrado en la pantalla
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Texto de bienvenida
                  const Text(
                    "BIENVENIDO",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Campo de entrada para el usuario
                  _inputField(
                    hintText: "Usuario",
                    onChanged: (value) => usuarioText = value,
                  ),
                  const SizedBox(height: 15),

                  // Campo de entrada para la contraseña (oculta el texto)
                  _inputField(
                    hintText: "Contraseña",
                    obscure: true,
                    onChanged: (value) => passwordText = value,
                  ),
                  const SizedBox(height: 25),

                  // Botón de "Entrar"
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 58, 175, 183),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 80,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      // Verifica si usuario y contraseña son "Admin"
                      if (usuarioText == 'Admin' && passwordText == 'Admin') {
                        // Si son correctos, navega a la pantalla principal
                        Navigator.pushReplacementNamed(context, '/PaginaHome');
                      } else {
                        // Si no, muestra un mensaje de error
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Credenciales no válidas'),
                            backgroundColor: Colors.redAccent,
                          ),
                        );
                      }
                    },
                    child: const Text(
                      "Entrar",
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Función para construir los campos de entrada de texto (usuario y contraseña)
  Widget _inputField({
    required String hintText,
    bool obscure = false,
    void Function(String)? onChanged,
  }) {
    return TextField(
      obscureText: obscure, // Oculta el texto si es un campo de contraseña
      onChanged: onChanged, // Actualiza la variable al cambiar el texto
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.white.withOpacity(
          0.5,
        ), // Fondo semitransparente blanco
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
