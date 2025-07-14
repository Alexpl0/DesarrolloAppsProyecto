import 'package:flutter/material.dart';

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
    HistorialPedido(
      id: '001',
      propietario: 'Carlos Pérez',
      checkpoints: [
        Checkpoint(
          nombre: 'Entrega al aeropuerto',
          status: 'Completado',
          hora: '10:30 AM',
          destino: 'Aeropuerto JFK',
        ),
        Checkpoint(
          nombre: 'Despegue',
          status: 'Completado',
          hora: '11:00 AM',
          destino: 'En vuelo hacia Seattle',
        ),
        Checkpoint(
          nombre: 'En vuelo',
          status: 'Completado',
          hora: '11:30 AM',
          destino: 'En vuelo hacia Seattle',
        ),
        Checkpoint(
          nombre: 'Aterrizando',
          status: 'N/I',
          hora: 'N/I',
          destino: 'Aeropuerto SeaTac',
        ),
        Checkpoint(
          nombre: 'Entregado al cliente',
          status: 'N/I',
          hora: 'N/I',
          destino: 'Dirección del cliente',
        ),
      ],
    ),
    HistorialPedido(
      id: '002',
      propietario: 'María López',
      checkpoints: [
        Checkpoint(
          nombre: 'Entrega al aeropuerto',
          status: 'Completado',
          hora: '9:45 AM',
          destino: 'Aeropuerto CDMX',
        ),
        Checkpoint(
          nombre: 'Despegue',
          status: 'Completado',
          hora: '10:15 AM',
          destino: 'En vuelo hacia Los Ángeles',
        ),
        Checkpoint(
          nombre: 'En vuelo',
          status: 'Completado',
          hora: '11:10 AM',
          destino: 'En vuelo hacia Los Ángeles',
        ),
        Checkpoint(
          nombre: 'Aterrizando',
          status: 'Completado',
          hora: '12:00 PM',
          destino: 'Aeropuerto LAX',
        ),
        Checkpoint(
          nombre: 'Entregado al cliente',
          status: 'N/I',
          hora: 'N/I',
          destino: 'Dirección del cliente',
        ),
      ],
    ),
    HistorialPedido(
      id: '003',
      propietario: 'Luis Ramírez',
      checkpoints: [
        Checkpoint(
          nombre: 'Entrega al aeropuerto',
          status: 'Completado',
          hora: '8:30 AM',
          destino: 'Aeropuerto CDG',
        ),
        Checkpoint(
          nombre: 'Despegue',
          status: 'Completado',
          hora: '9:00 AM',
          destino: 'En vuelo hacia Chicago',
        ),
        Checkpoint(
          nombre: 'En vuelo',
          status: 'Completado',
          hora: '10:15 AM',
          destino: 'En vuelo hacia Chicago',
        ),
        Checkpoint(
          nombre: 'Aterrizando',
          status: 'N/I',
          hora: 'N/I',
          destino: 'Aeropuerto O’Hare',
        ),
        Checkpoint(
          nombre: 'Entregado al cliente',
          status: 'N/I',
          hora: 'N/I',
          destino: 'Dirección del cliente',
        ),
      ],
    ),
    HistorialPedido(
      id: '004',
      propietario: 'Ana Torres',
      checkpoints: [
        Checkpoint(
          nombre: 'Entrega al aeropuerto',
          status: 'Completado',
          hora: '7:45 AM',
          destino: 'Aeropuerto MAD',
        ),
        Checkpoint(
          nombre: 'Despegue',
          status: 'Completado',
          hora: '8:30 AM',
          destino: 'En vuelo hacia Houston',
        ),
        Checkpoint(
          nombre: 'En vuelo',
          status: 'En tránsito',
          hora: '10:00 AM',
          destino: 'En vuelo hacia Houston',
        ),
        Checkpoint(
          nombre: 'Aterrizando',
          status: 'N/I',
          hora: 'N/I',
          destino: 'Aeropuerto IAH',
        ),
        Checkpoint(
          nombre: 'Entregado al cliente',
          status: 'N/I',
          hora: 'N/I',
          destino: 'Dirección del cliente',
        ),
      ],
    ),
    HistorialPedido(
      id: '005',
      propietario: 'David Gómez',
      checkpoints: [
        Checkpoint(
          nombre: 'Entrega al aeropuerto',
          status: 'Completado',
          hora: '6:30 AM',
          destino: 'Aeropuerto FCO',
        ),
        Checkpoint(
          nombre: 'Despegue',
          status: 'Completado',
          hora: '7:10 AM',
          destino: 'En vuelo hacia San Francisco',
        ),
        Checkpoint(
          nombre: 'En vuelo',
          status: 'Completado',
          hora: '9:45 AM',
          destino: 'En vuelo hacia San Francisco',
        ),
        Checkpoint(
          nombre: 'Aterrizando',
          status: 'Completado',
          hora: '12:00 PM',
          destino: 'Aeropuerto SFO',
        ),
        Checkpoint(
          nombre: 'Entregado al cliente',
          status: 'Completado',
          hora: '2:30 PM',
          destino: 'Dirección del cliente',
        ),
      ],
    ),
    HistorialPedido(
      id: '006',
      propietario: 'Beatriz Luna',
      checkpoints: [
        Checkpoint(
          nombre: 'Salida de almacén',
          status: 'Completado',
          hora: '08:00 AM',
          destino: 'Bodega Central Querétaro',
        ),
        Checkpoint(
          nombre: 'En tránsito',
          status: 'Completado',
          hora: '09:30 AM',
          destino: 'Carretera Federal 57',
        ),
        Checkpoint(
          nombre: 'Llegando a destino',
          status: 'N/I',
          hora: 'N/I',
          destino: 'Guadalajara, JAL',
        ),
        Checkpoint(
          nombre: 'Entregado al cliente',
          status: 'N/I',
          hora: 'N/I',
          destino: 'Sucursal Guadalajara',
        ),
      ],
    ),
    HistorialPedido(
      id: '007',
      propietario: 'Fernando Cruz',
      checkpoints: [
        Checkpoint(
          nombre: 'Salida de almacén',
          status: 'Completado',
          hora: '07:15 AM',
          destino: 'Bodega Central Querétaro',
        ),
        Checkpoint(
          nombre: 'En tránsito',
          status: 'Completado',
          hora: '09:00 AM',
          destino: 'Carretera Saltillo-MTY',
        ),
        Checkpoint(
          nombre: 'Llegando a destino',
          status: 'N/I',
          hora: 'N/I',
          destino: 'Monterrey, NL',
        ),
        Checkpoint(
          nombre: 'Entregado al cliente',
          status: 'N/I',
          hora: 'N/I',
          destino: 'Sucursal Monterrey',
        ),
      ],
    ),
    HistorialPedido(
      id: '008',
      propietario: 'Sofía Herrera',
      checkpoints: [
        Checkpoint(
          nombre: 'Salida de almacén',
          status: 'Completado',
          hora: '06:45 AM',
          destino: 'Bodega Central Querétaro',
        ),
        Checkpoint(
          nombre: 'En tránsito',
          status: 'Completado',
          hora: '08:30 AM',
          destino: 'Tramo Mexicali-Tijuana',
        ),
        Checkpoint(
          nombre: 'Llegando a destino',
          status: 'N/I',
          hora: 'N/I',
          destino: 'Tijuana, BC',
        ),
        Checkpoint(
          nombre: 'Entregado al cliente',
          status: 'N/I',
          hora: 'N/I',
          destino: 'Sucursal Tijuana',
        ),
      ],
    ),
    HistorialPedido(
      id: '009',
      propietario: 'Emilio Vargas',
      checkpoints: [
        Checkpoint(
          nombre: 'Salida de almacén',
          status: 'Completado',
          hora: '08:20 AM',
          destino: 'Bodega Central Querétaro',
        ),
        Checkpoint(
          nombre: 'En tránsito',
          status: 'Completado',
          hora: '10:00 AM',
          destino: 'Autopista México-Puebla',
        ),
        Checkpoint(
          nombre: 'Llegando a destino',
          status: 'Completado',
          hora: '11:45 AM',
          destino: 'Puebla, PUE',
        ),
        Checkpoint(
          nombre: 'Entregado al cliente',
          status: 'Completado',
          hora: '12:30 PM',
          destino: 'Sucursal Puebla',
        ),
      ],
    ),
    HistorialPedido(
      id: '010',
      propietario: 'Valeria Soto',
      checkpoints: [
        Checkpoint(
          nombre: 'Salida de almacén',
          status: 'Completado',
          hora: '07:00 AM',
          destino: 'Bodega Central Querétaro',
        ),
        Checkpoint(
          nombre: 'En tránsito',
          status: 'Completado',
          hora: '08:20 AM',
          destino: 'Querétaro Centro',
        ),
        Checkpoint(
          nombre: 'Llegando a destino',
          status: 'Completado',
          hora: '09:15 AM',
          destino: 'Sucursal Centro Histórico',
        ),
        Checkpoint(
          nombre: 'Entregado al cliente',
          status: 'Completado',
          hora: '09:40 AM',
          destino: 'Sucursal Centro Histórico',
        ),
      ],
    ),
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
      filteredPedidos =
          historialPedidos
              .where(
                (pedido) =>
                    pedido.id.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Buscar por ID de Pedido',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => _filterPedidos(),
            ),
            const SizedBox(height: 20),
            Expanded(
              child:
                  filteredPedidos.isEmpty
                      ? const Center(child: Text('No se encontraron pedidos.'))
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
                              title: Text(
                                'ID Pedido: ${pedido.id}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                'Propietario: ${pedido.propietario}',
                              ),
                              children: [
                                const Divider(),
                                ...pedido.checkpoints.map((cp) {
                                  return ListTile(
                                    leading: Icon(
                                      Icons.flag,
                                      color: _getStatusColor(cp.status),
                                    ),
                                    title: Text(cp.nombre),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
