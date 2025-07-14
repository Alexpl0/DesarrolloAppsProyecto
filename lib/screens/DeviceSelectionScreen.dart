// Pantalla para escanear y seleccionar dispositivos Bluetooth disponibles

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:permission_handler/permission_handler.dart';
import 'SensorDataScreen.dart'; // Importa la pantalla donde se muestran los datos del sensor

class DeviceSelectionScreen extends StatefulWidget {
  const DeviceSelectionScreen({super.key});

  @override
  _DeviceSelectionScreenState createState() => _DeviceSelectionScreenState();
}

class _DeviceSelectionScreenState extends State<DeviceSelectionScreen> {
  // Lista de dispositivos encontrados durante la búsqueda
  final List<BluetoothDiscoveryResult> _foundDevices = [];

  // Bandera para indicar si está en proceso de búsqueda
  bool _isDiscovering = false;

  @override
  void initState() {
    super.initState();
    // Solicita permisos necesarios al iniciar y luego empieza a escanear dispositivos
    _askPermissions().then((_) {
      _startDiscovery();
    });
  }

  // Función para solicitar permisos de Bluetooth y ubicación
  Future<void> _askPermissions() async {
    await Permission.bluetooth.request();
    await Permission.bluetoothScan.request();
    await Permission.bluetoothConnect.request();
    await Permission.locationWhenInUse.request();
  }

  // Inicia el escaneo de dispositivos Bluetooth
  void _startDiscovery() {
    setState(() {
      _foundDevices.clear(); // Limpia la lista anterior
      _isDiscovering = true; // Cambia estado a "descubriendo"
    });

    // Comienza el descubrimiento de dispositivos
    FlutterBluetoothSerial.instance
        .startDiscovery()
        .listen((result) {
          // Verifica si el dispositivo ya está en la lista
          final existingIndex = _foundDevices.indexWhere(
            (r) => r.device.address == result.device.address,
          );
          if (existingIndex >= 0) {
            // Si existe, lo actualiza
            setState(() => _foundDevices[existingIndex] = result);
          } else {
            // Si no existe, lo agrega
            setState(() => _foundDevices.add(result));
          }
        })
        .onDone(
          () => setState(() => _isDiscovering = false),
        ); // Finaliza el escaneo
  }

  // Intenta conectarse al dispositivo seleccionado y navega a la pantalla de sensores
  void _connectToDevice(BluetoothDevice device) async {
    try {
      final connection = await BluetoothConnection.toAddress(device.address);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SensorDataScreen(connection: connection),
        ),
      );
    } catch (e) {
      // Muestra error si la conexión falla
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error al conectar: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra superior con título y color personalizado
      appBar: AppBar(
        title: const Text('Dispositivos Bluetooth'),
        backgroundColor: const Color.fromARGB(255, 58, 173, 183),
      ),
      // Cuerpo principal que muestra la lista o una animación de carga
      body: Padding(
        padding: const EdgeInsets.all(16),
        child:
            _isDiscovering
                ? const Center(
                  child: CircularProgressIndicator(),
                ) // Indicador de búsqueda activa
                : _foundDevices.isEmpty
                ? const Center(child: Text('No se encontraron dispositivos'))
                : ListView.separated(
                  itemCount: _foundDevices.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, index) {
                    final device = _foundDevices[index].device;
                    return Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        leading: const Icon(
                          Icons.bluetooth,
                          color: Colors.blue,
                        ),
                        title: Text(device.name ?? 'Sin nombre'),
                        subtitle: Text(device.address),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap:
                            () => _connectToDevice(
                              device,
                            ), // Al presionar conecta
                      ),
                    );
                  },
                ),
      ),
      // Botón flotante para volver a buscar dispositivos
      floatingActionButton: FloatingActionButton(
        onPressed: _startDiscovery,
        backgroundColor: const Color.fromARGB(255, 58, 173, 183),
        tooltip: 'Buscar dispositivos',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
