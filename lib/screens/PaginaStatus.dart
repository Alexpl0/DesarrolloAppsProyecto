import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Importamos las traducciones

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
    final localizations = AppLocalizations.of(context)!;
    final List<EnvioStatus> enviosStatus = [
      // La data sigue hardcodeada
      EnvioStatus(
          id: '001',
          propietario: 'Carlos Pérez',
          status: 'En vuelo',
          fechaEstimadaLlegada: '2025-03-25',
          horaEstimadaLlegada: '14:30',
          modoTransporte: 'Avión',
          destino: 'Seattle, WA'),
      // ... más datos
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
                  // Usando la traducción
                  Text(
                    localizations.orderId(envio.id),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 6),
                  // Usando la traducción
                  Text(localizations.owner(envio.propietario)),
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
