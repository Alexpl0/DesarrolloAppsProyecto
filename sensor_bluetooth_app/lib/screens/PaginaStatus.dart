import 'package:flutter/material.dart';

class EnvioStatus {
  final String id;
  final String propietario;
  final String status;
  final String fechaEstimadaLlegada;
  final String horaEstimadaLlegada;
  final String modoTransporte;
  final String destino;

  EnvioStatus({
    required this.id,
    required this.propietario,
    required this.status,
    required this.fechaEstimadaLlegada,
    required this.horaEstimadaLlegada,
    required this.modoTransporte,
    required this.destino,
  });
}

class PaginaStatus extends StatelessWidget {
  const PaginaStatus({super.key});

  @override
  Widget build(BuildContext context) {
    final List<EnvioStatus> enviosStatus = [
      EnvioStatus(
        id: '001',
        propietario: 'Carlos Pérez',
        status: 'En vuelo',
        fechaEstimadaLlegada: '2025-03-25',
        horaEstimadaLlegada: '14:30',
        modoTransporte: 'Avión',
        destino: 'Seattle, WA',
      ),
      EnvioStatus(
        id: '002',
        propietario: 'María López',
        status: 'Aterrizando',
        fechaEstimadaLlegada: '2025-03-25',
        horaEstimadaLlegada: '15:00',
        modoTransporte: 'Avión',
        destino: 'Los Ángeles, CA',
      ),
      EnvioStatus(
        id: '003',
        propietario: 'Luis Ramírez',
        status: 'Despegue',
        fechaEstimadaLlegada: '2025-03-25',
        horaEstimadaLlegada: '16:15',
        modoTransporte: 'Avión',
        destino: 'Chicago, IL',
      ),
      EnvioStatus(
        id: '004',
        propietario: 'Ana Torres',
        status: 'En aeropuerto',
        fechaEstimadaLlegada: '2025-03-25',
        horaEstimadaLlegada: '17:20',
        modoTransporte: 'Avión',
        destino: 'Houston, TX',
      ),
      EnvioStatus(
        id: '005',
        propietario: 'David Gómez',
        status: 'Entregado',
        fechaEstimadaLlegada: '2025-03-25',
        horaEstimadaLlegada: '18:45',
        modoTransporte: 'Avión',
        destino: 'San Francisco, CA',
      ),
      EnvioStatus(
        id: '006',
        propietario: 'Beatriz Luna',
        status: 'En camino',
        fechaEstimadaLlegada: '2025-03-26',
        horaEstimadaLlegada: '13:20',
        modoTransporte: 'Camión',
        destino: 'Guadalajara, JAL',
      ),
      EnvioStatus(
        id: '007',
        propietario: 'Fernando Cruz',
        status: 'Despachado',
        fechaEstimadaLlegada: '2025-03-26',
        horaEstimadaLlegada: '15:00',
        modoTransporte: 'Camión',
        destino: 'Monterrey, NL',
      ),
      EnvioStatus(
        id: '008',
        propietario: 'Sofía Herrera',
        status: 'En ruta',
        fechaEstimadaLlegada: '2025-03-26',
        horaEstimadaLlegada: '17:45',
        modoTransporte: 'Camión',
        destino: 'Tijuana, BC',
      ),
      EnvioStatus(
        id: '009',
        propietario: 'Emilio Vargas',
        status: 'Entregado',
        fechaEstimadaLlegada: '2025-03-26',
        horaEstimadaLlegada: '12:30',
        modoTransporte: 'Camión',
        destino: 'Puebla, PUE',
      ),
      EnvioStatus(
        id: '010',
        propietario: 'Valeria Soto',
        status: 'En almacén',
        fechaEstimadaLlegada: '2025-03-26',
        horaEstimadaLlegada: '16:10',
        modoTransporte: 'Camión',
        destino: 'Querétaro, QRO',
      ),
    ];

    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        itemCount: enviosStatus.length,
        itemBuilder: (context, index) {
          final envio = enviosStatus[index];

          return Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ID Pedido: ${envio.id}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text('Propietario: ${envio.propietario}'),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.flight_takeoff, size: 16),
                      const SizedBox(width: 6),
                      Text('Estado: ${envio.status}'),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 16),
                      const SizedBox(width: 6),
                      Text('Fecha Estimada: ${envio.fechaEstimadaLlegada}'),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.schedule, size: 16),
                      const SizedBox(width: 6),
                      Text('Hora Estimada: ${envio.horaEstimadaLlegada}'),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.local_shipping, size: 16),
                      const SizedBox(width: 6),
                      Text('Transporte: ${envio.modoTransporte}'),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 16),
                      const SizedBox(width: 6),
                      Text('Destino: ${envio.destino}'),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
