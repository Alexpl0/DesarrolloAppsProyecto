import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sensor_bluetooth_app/screens/PaginaEnvios.dart';
import 'package:sensor_bluetooth_app/screens/PaginaHistorial.dart';
import 'package:sensor_bluetooth_app/screens/PaginaStatus.dart';
import 'package:sensor_bluetooth_app/utils/assets.dart';

class Envio {
  final String id;
  final String producto;
  final int cantidad;
  final String nombrePropietario;
  final String imagenUrl;

  Envio({
    required this.id,
    required this.producto,
    required this.cantidad,
    required this.nombrePropietario,
    required this.imagenUrl,
  });
}

class PaginaHome extends StatefulWidget {
  const PaginaHome({Key? key}) : super(key: key);

  @override
  _PaginaHomeState createState() => _PaginaHomeState();
}

class _PaginaHomeState extends State<PaginaHome> {
  int _paginaActual = 0;

  final List<Widget> _paginas = [
    const PaginaHomeContent(),
    const PaginaStatus(),
    const PaginaHistorial(),
    const PaginaEnvios(),
  ];

  final List<String> _titulos = ["Home", "Status", "Historial", "Envíos"];
  final List<Color> _coloresAppBar = [
    Colors.lightBlueAccent,
    Colors.lightBlueAccent,
    Colors.lightBlueAccent,
    Colors.lightBlueAccent,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titulos[_paginaActual]),
        backgroundColor: _coloresAppBar[_paginaActual],
      ),
      body: _paginas[_paginaActual],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _paginaActual,
        selectedItemColor: const Color.fromARGB(255, 58, 173, 183),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _paginaActual = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.airplane_ticket),
            label: "Status",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: "Historial",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_shipping),
            label: "Envíos",
          ),
        ],
      ),
    );
  }
}

class PaginaHomeContent extends StatefulWidget {
  const PaginaHomeContent({Key? key}) : super(key: key);

  @override
  State<PaginaHomeContent> createState() => _PaginaHomeContentState();
}

class _PaginaHomeContentState extends State<PaginaHomeContent> {
  final List<Envio> envios = [
    Envio(
      id: '001',
      producto: 'Vino Tinto',
      cantidad: 50,
      nombrePropietario: 'Carlos Pérez',
      imagenUrl: Assets.vino,
    ),
    Envio(
      id: '002',
      producto: 'Tequila',
      cantidad: 30,
      nombrePropietario: 'Ana Gómez',
      imagenUrl: Assets.tequila,
    ),
    Envio(
      id: '003',
      producto: 'Whisky',
      cantidad: 20,
      nombrePropietario: 'Luis Ramírez',
      imagenUrl: Assets.whisky,
    ),
    Envio(
      id: '004',
      producto: 'Whisky',
      cantidad: 10,
      nombrePropietario: 'Ana Torres',
      imagenUrl: Assets.whisky,
    ),
    Envio(
      id: '005',
      producto: 'Champagne',
      cantidad: 8,
      nombrePropietario: 'David Gómez',
      imagenUrl: Assets.champagne,
    ),
    Envio(
      id: '006',
      producto: 'Ron',
      cantidad: 25,
      nombrePropietario: 'Beatriz Luna',
      imagenUrl: Assets.ron,
    ),
    Envio(
      id: '007',
      producto: 'Mezcal',
      cantidad: 18,
      nombrePropietario: 'Fernando Cruz',
      imagenUrl: Assets.mezcal,
    ),
    Envio(
      id: '008',
      producto: 'Vodka',
      cantidad: 40,
      nombrePropietario: 'Sofía Herrera',
      imagenUrl: Assets.vodka,
    ),
    Envio(
      id: '009',
      producto: 'Brandy',
      cantidad: 22,
      nombrePropietario: 'Emilio Vargas',
      imagenUrl: Assets.brandy,
    ),
    Envio(
      id: '010',
      producto: 'Ginebra',
      cantidad: 35,
      nombrePropietario: 'Valeria Soto',
      imagenUrl: Assets.ginebra,
    ),
  ];

  String filtro = '';

  @override
  Widget build(BuildContext context) {
    final hora = DateFormat('hh:mm a').format(DateTime.now());

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Admin",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(
                    "Última actualización: $hora",
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              const Icon(Icons.person, size: 32, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 20),
          TextField(
            decoration: const InputDecoration(
              hintText: "Buscar por producto o propietario",
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: (value) => setState(() => filtro = value.toLowerCase()),
          ),
          const SizedBox(height: 20),
          _barraResumenEnvios(6, 4),
          const SizedBox(height: 16),
          _tablaResumen(envios.length, 6, 4),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton.icon(
              icon: const Icon(Icons.bluetooth),
              label: const Text("Escanear Bluetooth"),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                backgroundColor: const Color.fromARGB(255, 58, 173, 183),
              ),
              onPressed:
                  () =>
                      Navigator.pushNamed(context, '/BluetoothDeviceSelection'),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              children:
                  envios
                      .where(
                        (e) =>
                            e.producto.toLowerCase().contains(filtro) ||
                            e.nombrePropietario.toLowerCase().contains(filtro),
                      )
                      .map(
                        (envio) => Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                envio.imagenUrl,
                                width: 90,
                                height: 60,
                                fit: BoxFit.contain,
                              ),
                            ),
                            title: Text(
                              envio.producto,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 4),
                                Text('ID: ${envio.id}'),
                                Text('Cantidad: ${envio.cantidad}'),
                                Text('Propietario: ${envio.nombrePropietario}'),
                              ],
                            ),
                            isThreeLine: true,
                          ),
                        ),
                      )
                      .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tablaResumen(int total, int enTransito, int entregados) {
    return Table(
      border: TableBorder.all(color: Colors.grey.shade300),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TableRow(
          decoration: BoxDecoration(color: Colors.grey.shade200),
          children: const [
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Pedidos',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'En Tránsito',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Entregados',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        TableRow(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text('$total', textAlign: TextAlign.center),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text('$enTransito', textAlign: TextAlign.center),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text('$entregados', textAlign: TextAlign.center),
            ),
          ],
        ),
      ],
    );
  }

  Widget _barraResumenEnvios(int enTransito, int entregados) {
    final total = enTransito + entregados;
    final porcentaje = total == 0 ? 0.0 : entregados / total;
    final anchoBarra = MediaQuery.of(context).size.width - 64;
    final anchoVerde = porcentaje * anchoBarra;
    final anchoNaranja = (1 - porcentaje) * anchoBarra;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Resumen de envíos",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Row(
            children: [
              Container(
                width: anchoNaranja,
                height: 24,
                color: Colors.orange,
                alignment: Alignment.center,
                child:
                    enTransito > 0
                        ? const Text(
                          "En tránsito",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        )
                        : const SizedBox.shrink(),
              ),
              Container(
                width: anchoVerde,
                height: 24,
                color: Colors.green,
                alignment: Alignment.center,
                child:
                    entregados > 0
                        ? const Text(
                          "Entregados",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        )
                        : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
