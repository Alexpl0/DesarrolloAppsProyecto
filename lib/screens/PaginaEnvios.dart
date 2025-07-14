import 'package:flutter/material.dart';

// Modelo de datos que representa un envío individual
class EnvioDetalle {
  final String id; // ID del pedido
  final String producto; // Nombre del producto (licor)
  final String tipo; // Tipo de transporte: Aéreo o Terrestre
  final String estado; // Estado actual del envío
  final String destino; // Destino del envío
  final String propietario; // Nombre del propietario

  EnvioDetalle({
    required this.id,
    required this.producto,
    required this.tipo,
    required this.estado,
    required this.destino,
    required this.propietario,
  });
}

// Pantalla que muestra los envíos organizados por tipo (Aéreo y Terrestre)
class PaginaEnvios extends StatelessWidget {
  const PaginaEnvios({super.key});

  @override
  Widget build(BuildContext context) {
    // Lista de todos los envíos con sus respectivos detalles
    final List<EnvioDetalle> envios = [
      EnvioDetalle(
        id: '001',
        producto: 'Vino Tinto',
        tipo: 'Aéreo',
        estado: 'En vuelo',
        destino: 'Seattle, WA',
        propietario: 'Carlos Pérez',
      ),
      EnvioDetalle(
        id: '002',
        producto: 'Tequila',
        tipo: 'Aéreo',
        estado: 'Aterrizando',
        destino: 'Los Ángeles, CA',
        propietario: 'Ana Gómez',
      ),
      EnvioDetalle(
        id: '003',
        producto: 'Whisky',
        tipo: 'Aéreo',
        estado: 'Despegue',
        destino: 'Chicago, IL',
        propietario: 'Luis Ramírez',
      ),
      EnvioDetalle(
        id: '005',
        producto: 'Champagne',
        tipo: 'Aéreo',
        estado: 'Entregado',
        destino: 'Houston, TX',
        propietario: 'David Gómez',
      ),
      EnvioDetalle(
        id: '006',
        producto: 'Ron',
        tipo: 'Aéreo',
        estado: 'En aeropuerto',
        destino: 'San Francisco, CA',
        propietario: 'Beatriz Luna',
      ),
      EnvioDetalle(
        id: '007',
        producto: 'Mezcal',
        tipo: 'Terrestre',
        estado: 'En almacén',
        destino: 'Guadalajara, MX',
        propietario: 'Fernando Cruz',
      ),
      EnvioDetalle(
        id: '008',
        producto: 'Vodka',
        tipo: 'Terrestre',
        estado: 'Entregado',
        destino: 'Monterrey, MX',
        propietario: 'Sofía Herrera',
      ),
      EnvioDetalle(
        id: '009',
        producto: 'Brandy',
        tipo: 'Terrestre',
        estado: 'En ruta',
        destino: 'León, MX',
        propietario: 'Emilio Vargas',
      ),
      EnvioDetalle(
        id: '010',
        producto: 'Ginebra',
        tipo: 'Terrestre',
        estado: 'Pendiente',
        destino: 'Querétaro, MX',
        propietario: 'Valeria Soto',
      ),
    ];

    // Filtrar los envíos según el tipo
    final aereos = envios.where((e) => e.tipo == 'Aéreo').toList();
    final terrestres = envios.where((e) => e.tipo == 'Terrestre').toList();

    return Scaffold(
      // Contenido principal de la pantalla
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Aéreos ✈️',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...aereos
                .map(_buildEnvioCard)
                , // Generar tarjetas para los envíos aéreos
            const SizedBox(height: 20),
            const Text(
              'Terrestres 🚛',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...terrestres
                .map(_buildEnvioCard)
                , // Generar tarjetas para los envíos terrestres
          ],
        ),
      ),
    );
  }

  // Método que construye la tarjeta de visualización de cada envío
  Widget _buildEnvioCard(EnvioDetalle envio) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  // Icono diferente según el tipo de envío
                  envio.tipo == 'Aéreo' ? Icons.flight : Icons.local_shipping,
                  color: envio.tipo == 'Aéreo' ? Colors.blue : Colors.brown,
                ),
                const SizedBox(width: 8),
                Text(
                  '${envio.producto} (${envio.tipo})', // Producto y tipo de transporte
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text('ID: ${envio.id}'),
            Text('Propietario: ${envio.propietario}'),
            Text('Estado: ${envio.estado}'),
            Text('Destino: ${envio.destino}'),
          ],
        ),
      ),
    );
  }
}
