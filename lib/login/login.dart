import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sensor_bluetooth_app/main.dart'; // Importamos AppState
import 'package:sensor_bluetooth_app/utils/assets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Importa las traducciones generadas

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
          // 1. Imagen de fondo
          Image.asset(Assets.login, fit: BoxFit.cover),

          // 2. Formulario centrado
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

          // --- CORRECCIÓN ---
          // 3. Botones de idioma en la esquina superior derecha
          // Usamos Positioned para anclar el widget a una posición específica del Stack.
          // Se dibuja al final para que quede por encima de los demás elementos.
          Positioned(
            top: 40, // Espacio desde el borde superior
            right: 16, // Espacio desde el borde derecho
            child: SafeArea(
              // Se mantiene para evitar el notch en móviles
              child: Row(
                children: [
                  LanguageButton(
                      locale: const Locale('es'), tooltip: 'Español'),
                  const SizedBox(width: 8),
                  LanguageButton(
                      locale: const Locale('en'), tooltip: 'English'),
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

// --- WIDGET ANIMADO PARA EL BOTÓN DE IDIOMA ---
class LanguageButton extends StatelessWidget {
  final Locale locale;
  final String tooltip;

  const LanguageButton(
      {super.key, required this.locale, required this.tooltip});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final bool isSelected = appState.appLocale == locale;

    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: () {
          // Usamos el Provider para cambiar el idioma
          Provider.of<AppState>(context, listen: false).changeLocale(locale);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isSelected
                ? Colors.white.withOpacity(0.9)
                : Colors.white.withOpacity(0.4),
            shape: BoxShape.circle,
            border:
                isSelected ? Border.all(color: Colors.blue, width: 2) : null,
          ),
          child: Text(
            locale.languageCode.toUpperCase(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.blue : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
