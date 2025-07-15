import 'package:flutter/material.dart';
import 'package:sensor_bluetooth_app/l10n/app_localizations.dart'
    show AppLocalizations;
import 'package:sensor_bluetooth_app/utils/assets.dart';
//import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Importa las traducciones

// Pantalla principal de Login
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String usuarioText = "";
  String passwordText = "";

  @override
  Widget build(BuildContext context) {
    // Obtenemos las traducciones para el contexto actual
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(Assets.login, fit: BoxFit.cover),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    localizations.welcomeMessage, // Usando la traducción
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  _inputField(
                    hintText: localizations.userHint, // Usando la traducción
                    onChanged: (value) => usuarioText = value,
                  ),
                  const SizedBox(height: 15),
                  _inputField(
                    hintText:
                        localizations.passwordHint, // Usando la traducción
                    obscure: true,
                    onChanged: (value) => passwordText = value,
                  ),
                  const SizedBox(height: 25),
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
                      if (usuarioText == 'Admin' && passwordText == 'Admin') {
                        Navigator.pushReplacementNamed(context, '/PaginaHome');
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(localizations
                                .invalidCredentials), // Usando la traducción
                            backgroundColor: Colors.redAccent,
                          ),
                        );
                      }
                    },
                    child: Text(
                      localizations.loginButton, // Usando la traducción
                      style: const TextStyle(fontSize: 22, color: Colors.white),
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

  Widget _inputField({
    required String hintText,
    bool obscure = false,
    void Function(String)? onChanged,
  }) {
    return TextField(
      obscureText: obscure,
      onChanged: onChanged,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.white.withOpacity(0.5),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
