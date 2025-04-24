// Punto de entrada principal de la aplicación Flutter
import 'package:flutter/material.dart';

// Importaciones de las pantallas (pantallas del rastreo y sensores)
import 'package:sensor_bluetooth_app/screens/PaginaEnvios.dart';
import 'package:sensor_bluetooth_app/screens/PaginaHistorial.dart';
import 'package:sensor_bluetooth_app/screens/PaginaHome.dart';
import 'package:sensor_bluetooth_app/screens/PaginaStatus.dart';
import 'package:sensor_bluetooth_app/login/login.dart';
import 'package:sensor_bluetooth_app/screens/DeviceSelectionScreen.dart';

void main() {
  // Inicializa y ejecuta la aplicación
  runApp(const RastreoSensorApp());
}

// Widget principal que configura la aplicación completa
class RastreoSensorApp extends StatelessWidget {
  const RastreoSensorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Oculta el banner de debug
      title: 'Rastreo + Sensores', // Título de la aplicación
      // Define el tema general de la app (colores, fuentes, etc.)
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(
            255,
            58,
            173,
            183,
          ), // Color personalizado celeste
        ),
        scaffoldBackgroundColor: Colors.grey[100], // Color de fondo claro
        useMaterial3: true, // Activa Material 3 para estilos modernos
      ),

      // Ruta inicial de la app (pantalla de login)
      initialRoute: '/',

      // Definición de las rutas de navegación entre pantallas
      routes: {
        '/': (context) => const Login(), // Página de inicio (Login)
        '/PaginaHome':
            (context) =>
                const PaginaHome(), // Página principal con navegación inferior
        '/PaginaStatus':
            (context) => const PaginaStatus(), // Página de estado de envíos
        '/PaginaHistorial':
            (context) =>
                const PaginaHistorial(), // Página con historial de entregas
        '/BluetoothDeviceSelection':
            (context) =>
                const DeviceSelectionScreen(), // Escaneo y conexión Bluetooth
        '/PaginaEnvios':
            (context) =>
                const PaginaEnvios(), // Página de clasificación por tipo de envío
      },
    );
  }
}
