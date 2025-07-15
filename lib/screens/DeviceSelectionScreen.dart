import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sensor_bluetooth_app/l10n/app_localizations.dart'
    show AppLocalizations;
import 'package:sensor_bluetooth_app/screens/SensorDataScreen.dart';
//import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Importamos las traducciones

class DeviceSelectionScreen extends StatefulWidget {
  const DeviceSelectionScreen({super.key});

  @override
  _DeviceSelectionScreenState createState() => _DeviceSelectionScreenState();
}

class _DeviceSelectionScreenState extends State<DeviceSelectionScreen> {
  final List<BluetoothDiscoveryResult> _foundDevices = [];
  bool _isDiscovering = false;

  @override
  void initState() {
    super.initState();
    _askPermissions().then((_) {
      _startDiscovery();
    });
  }

  Future<void> _askPermissions() async {
    await [
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.locationWhenInUse,
    ].request();
  }

  void _startDiscovery() {
    setState(() {
      _foundDevices.clear();
      _isDiscovering = true;
    });

    FlutterBluetoothSerial.instance.startDiscovery().listen((result) {
      final existingIndex = _foundDevices.indexWhere(
        (r) => r.device.address == result.device.address,
      );
      if (existingIndex >= 0) {
        setState(() => _foundDevices[existingIndex] = result);
      } else {
        setState(() => _foundDevices.add(result));
      }
    }).onDone(() => setState(() => _isDiscovering = false));
  }

  void _connectToDevice(BluetoothDevice device) async {
    try {
      final connection = await BluetoothConnection.toAddress(device.address);
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SensorDataScreen(connection: connection),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error al conectar: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    // NOTA: El AppBar de esta pantalla ahora se controla desde PaginaHome.
    // Si quisieras un título diferente, tendrías que pasar el control aquí.
    // Por ahora, se mostrará el título "Sensores" definido en PaginaHome.
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _isDiscovering
            ? const Center(child: CircularProgressIndicator())
            : _foundDevices.isEmpty
                ? Center(child: Text(localizations.noDevicesFound))
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
                          leading:
                              const Icon(Icons.bluetooth, color: Colors.blue),
                          title:
                              Text(device.name ?? localizations.unnamedDevice),
                          subtitle: Text(device.address),
                          trailing:
                              const Icon(Icons.arrow_forward_ios, size: 16),
                          onTap: () => _connectToDevice(device),
                        ),
                      );
                    },
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _startDiscovery,
        backgroundColor: const Color.fromARGB(255, 58, 173, 183),
        tooltip: localizations.searchDevices,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
