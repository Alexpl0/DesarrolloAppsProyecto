// Pantalla que muestra los datos recibidos por Bluetooth desde el microcontrolador
// Incluye temperatura (LM35), temperatura y humedad (DHT11), y porcentaje de luz (LDR)

import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class SensorDataScreen extends StatefulWidget {
  // Recibe un objeto de conexión Bluetooth al instanciar esta pantalla
  final BluetoothConnection connection;

  const SensorDataScreen({super.key, required this.connection});

  @override
  State<SensorDataScreen> createState() => _SensorDataScreenState();
}

class _SensorDataScreenState extends State<SensorDataScreen> {
  // Variable para mantener seleccionada la pestaña "Sensores" en la barra de navegación inferior
  int _paginaActual = 3;

  // Variables para almacenar los datos recibidos
  String temperaturaLM35 = '-';
  String temperaturaDHT = '-';
  String humedad = '-';
  String luz = '-';

  @override
  void initState() {
    super.initState();
    // Escucha continua del canal de entrada del dispositivo Bluetooth
    widget.connection.input?.listen(_onDataReceived);
  }

  // Función que procesa los datos entrantes por Bluetooth
  void _onDataReceived(Uint8List data) {
    final String received =
        utf8.decode(data).trim(); // Decodifica los datos a texto

    // Si el texto contiene separadores "|", significa que es una trama válida
    if (received.contains('|')) {
      final parts = received.split('|'); // Divide los datos recibidos

      // Asegura que haya al menos 4 datos (temp LM35, temp DHT, humedad, luz)
      if (parts.length >= 4) {
        setState(() {
          temperaturaLM35 = parts[0];
          temperaturaDHT = parts[1];
          humedad = parts[2];
          luz = parts[3];
        });
      }
    }
  }

  // Función que envía el comando "D" por Bluetooth para solicitar datos al microcontrolador
  void _solicitarDatos() {
    widget.connection.output.add(utf8.encode("D\n"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra superior con título y color personalizado
      appBar: AppBar(
        title: const Text('Datos del Sensor'),
        backgroundColor: Colors.teal,
      ),
      // Contenido principal que muestra las tarjetas con los datos
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            _buildSensorCard(
              Icons.thermostat,
              'Temperatura LM35',
              '$temperaturaLM35 °C',
            ),
            _buildSensorCard(
              Icons.device_thermostat,
              'Temperatura DHT11',
              '$temperaturaDHT °C',
            ),
            _buildSensorCard(Icons.water_drop, 'Humedad', '$humedad %'),
            _buildSensorCard(Icons.wb_sunny, 'Luz', '$luz %'),
            const SizedBox(height: 20),
            // Botón que solicita los datos al microcontrolador
            ElevatedButton.icon(
              onPressed: _solicitarDatos,
              icon: const Icon(Icons.refresh),
              label: const Text('Solicitar Datos'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
            ),
          ],
        ),
      ),
      // Barra de navegación inferior para moverse entre pantallas
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _paginaActual, // Página activa: Sensores
        onTap: (index) {
          setState(() {
            _paginaActual = index;
          });

          // Navegación entre las distintas pantallas de la app
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/PaginaHome');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/PaginaStatus');
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/PaginaHistorial');
              break;
            case 3:
              break; // Ya estamos en la página de sensores
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.airplane_ticket),
            label: 'Status',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Historial',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.sensors), label: 'Sensores'),
        ],
      ),
    );
  }

  // Método reutilizable para crear una tarjeta de sensor con ícono, título y valor
  Widget _buildSensorCard(IconData icon, String title, String value) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, size: 32),
        title: Text(title),
        subtitle: Text(value, style: const TextStyle(fontSize: 18)),
      ),
    );
  }

  @override
  void dispose() {
    // Cierra la conexión Bluetooth al salir de la pantalla
    widget.connection.dispose();
    super.dispose();
  }
}
