import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Una clase dedicada a manejar el guardado y la carga de datos locales.
// Esto mantiene nuestro código organizado y fácil de mantener.
class PreferencesService {
  // Guarda el código del idioma seleccionado (ej. 'es' o 'en') en el dispositivo.
  Future<void> saveLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    // Usamos una clave 'languageCode' para almacenar el valor.
    await prefs.setString('languageCode', languageCode);
  }

  // Carga el idioma que fue guardado previamente en el dispositivo.
  Future<Locale> loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    // Leemos el valor asociado a la clave 'languageCode'.
    final languageCode = prefs.getString('languageCode');

    // Si no se encuentra ningún idioma guardado (la primera vez que se abre la app),
    // devolvemos español ('es') como el idioma por defecto.
    return Locale(languageCode ?? 'es');
  }
}
