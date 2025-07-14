import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Importamos las traducciones

class Checkpoint {
  final String nombre;
  final String status;
  final String hora;
  final String destino;

  Checkpoint({
    required this.nombre,
    required this.status,
    required this.hora,
    required this.destino,
  });
}

class HistorialPedido {
  final String id;
  final String propietario;
  final List<Checkpoint> checkpoints;

  HistorialPedido({
    required this.id,
    required this.propietario,
    required this.checkpoints,
  });
}

class PaginaHistorial extends StatefulWidget {
  const PaginaHistorial({super.key});

  @override
  State<PaginaHistorial> createState() => _PaginaHistorialState();
}

class _PaginaHistorialState extends State<PaginaHistorial> {
  final TextEditingController _searchController = TextEditingController();
  List<HistorialPedido> historialPedidos = [
    // La data sigue hardcodeada
    HistorialPedido(id: '001', propietario: 'Carlos Pérez', checkpoints: [ Checkpoint(nombre: 'Entrega al aeropuerto', status: 'Completado', hora: '10:30 AM', destino: 'Aeropuerto JFK'), /* ... */ ]),
    HistorialPedido(id: '002', propietario: 'María López', checkpoints: [ Checkpoint(nombre: 'Entrega al aeropuerto', status: 'Completado', hora: '9:45 AM', destino: 'Aeropuerto CDMX'), /* ... */ ]),
    // ... más datos
  ];

  List<HistorialPedido> filteredPedidos = [];

  @override
  void initState() {
    super.initState();
    filteredPedidos = historialPedidos;
  }

  void _filterPedidos() {
    setState(() {
      final query = _searchController.text.trim();
      if (query.isEmpty) {
        filteredPedidos = historialPedidos;
      } else {
        filteredPedidos = historialPedidos
            .where((pedido) => pedido.id.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completado':
        return Colors.green;
      case 'en tránsito':
        return Colors.orange;
      case 'n/i':
        return Colors.grey;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                // Usando la traducción
                labelText: localizations.searchByOrderId,
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(),
              ),
              onChanged: (_) => _filterPedidos(),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: filteredPedidos.isEmpty
                  // Usando la traducción
                  ? Center(child: Text(localizations.noOrdersFound))
                  : ListView.builder(
                      itemCount: filteredPedidos.length,
                      itemBuilder: (context, index) {
                        final pedido = filteredPedidos[index];
                        return Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ExpansionTile(
                            // Usando la traducción
                            title: Text(
                              localizations.orderId(pedido.id),
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            // Usando la traducción
                            subtitle: Text(localizations.owner(pedido.propietario)),
                            children: [
                              const Divider(),
                              ...pedido.checkpoints.map((cp) {
                                return ListTile(
                                  leading: Icon(Icons.flag, color: _getStatusColor(cp.status)),
                                  title: Text(cp.nombre),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Hora: ${cp.hora}'),
                                      Text('Destino: ${cp.destino}'),
                                    ],
                                  ),
                                  trailing: Text(
                                    cp.status,
                                    style: TextStyle(
                                      color: _getStatusColor(cp.status),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              }),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
