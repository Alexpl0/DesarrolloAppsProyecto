import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sensor_bluetooth_app/l10n/app_localizations.dart'
    show AppLocalizations;
import 'package:sensor_bluetooth_app/main.dart'; // Importamos AppState para el selector de idioma
import 'package:sensor_bluetooth_app/screens/DeviceSelectionScreen.dart';
import 'package:sensor_bluetooth_app/screens/PaginaEnvios.dart';
import 'package:sensor_bluetooth_app/screens/PaginaHistorial.dart';
import 'package:sensor_bluetooth_app/screens/PaginaStatus.dart';
import 'package:sensor_bluetooth_app/utils/assets.dart';
import 'package:sensor_bluetooth_app/services/notification_service.dart';
//import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Importamos las traducciones

// --- MODELO Y DATOS DE EJEMPLO ---
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

final List<Envio> listaDeEnvios = [
  Envio(
      id: '001',
      producto: 'Vino Tinto',
      cantidad: 50,
      nombrePropietario: 'Carlos Pérez',
      imagenUrl: Assets.vino),
  Envio(
      id: '002',
      producto: 'Tequila',
      cantidad: 30,
      nombrePropietario: 'Ana Gómez',
      imagenUrl: Assets.tequila),
  // ... (resto de la lista)
];

// --- WIDGET PRINCIPAL CON NAVEGACIÓN ---
class PaginaHome extends StatefulWidget {
  const PaginaHome({super.key});
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
    const DeviceSelectionScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    // Lista de títulos ahora usa las traducciones
    final List<String> titulos = [
      localizations.home,
      localizations.status,
      localizations.history,
      localizations.shipments,
      localizations.sensors
    ];

    final List<Color> coloresAppBar = [
      Colors.lightBlueAccent,
      Colors.lightBlueAccent,
      Colors.lightBlueAccent,
      Colors.lightBlueAccent,
      Colors.teal,
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(titulos[_paginaActual]),
        backgroundColor: coloresAppBar[_paginaActual],
        elevation: 2.0,
        // --- SELECTOR DE IDIOMA CENTRALIZADO ---
        actions: const [
          LanguageSwitcher(),
          SizedBox(width: 8),
        ],
      ),
      body: IndexedStack(
        index: _paginaActual,
        children: _paginas,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _paginaActual,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color.fromARGB(255, 58, 173, 183),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _paginaActual = index;
          });
        },
        // Las etiquetas de la barra ahora usan traducciones
        items: [
          BottomNavigationBarItem(
              icon: const Icon(Icons.home), label: localizations.home),
          BottomNavigationBarItem(
              icon: const Icon(Icons.airplane_ticket),
              label: localizations.status),
          BottomNavigationBarItem(
              icon: const Icon(Icons.history), label: localizations.history),
          BottomNavigationBarItem(
              icon: const Icon(Icons.local_shipping),
              label: localizations.shipments),
          BottomNavigationBarItem(
              icon: const Icon(Icons.sensors), label: localizations.sensors),
        ],
      ),
    );
  }
}

// --- CONTENIDO DE LA PANTALLA DE INICIO (TRADUCIDO) ---
class PaginaHomeContent extends StatefulWidget {
  const PaginaHomeContent({super.key});
  @override
  State<PaginaHomeContent> createState() => _PaginaHomeContentState();
}

class _PaginaHomeContentState extends State<PaginaHomeContent> {
  String filtro = '';
  late List<Envio> enviosFiltrados;

  @override
  void initState() {
    super.initState();
    enviosFiltrados = listaDeEnvios;
  }

  void _filtrarEnvios(String query) {
    final filtrados = listaDeEnvios.where((envio) {
      final queryLower = query.toLowerCase();
      return envio.producto.toLowerCase().contains(queryLower) ||
          envio.nombrePropietario.toLowerCase().contains(queryLower);
    }).toList();

    setState(() {
      filtro = query;
      enviosFiltrados = filtrados;
    });
  }

  @override
  Widget build(BuildContext context) {
    final hora = DateFormat.jms(AppLocalizations.of(context)!.localeName)
        .format(DateTime.now());
    final localizations = AppLocalizations.of(context)!;

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
                  Text(localizations.admin,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  Text(localizations.lastUpdate(hora),
                      style: const TextStyle(color: Colors.grey)),
                ],
              ),
              const CircleAvatar(
                backgroundColor: Colors.black12,
                child: Icon(Icons.person, size: 32, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              hintText: localizations.searchByProductOrOwner,
              prefixIcon: const Icon(Icons.search),
              border: const OutlineInputBorder(),
            ),
            onChanged: _filtrarEnvios,
          ),
          const SizedBox(height: 20),
          _barraResumenEnvios(context, 6, 4),
          const SizedBox(height: 16),
          _tablaResumen(context, listaDeEnvios.length, 6, 4),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton.icon(
              icon: const Icon(Icons.timer_outlined),
              label: Text(localizations.reminderIn10s),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              onPressed: () {
                NotificationService().scheduleNotification(
                  'Recordatorio de Envío',
                  '¡No olvides revisar el estado de tus envíos!',
                  10,
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(localizations.reminderSet),
                    backgroundColor: Colors.deepPurple,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: enviosFiltrados.length,
              itemBuilder: (context, index) =>
                  _buildEnvioListItem(context, enviosFiltrados[index]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEnvioListItem(BuildContext context, Envio envio) {
    final localizations = AppLocalizations.of(context)!;
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            envio.imagenUrl,
            width: 90,
            height: 60,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.image_not_supported),
          ),
        ),
        title: Text(envio.producto,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text('ID: ${envio.id}'),
            Text('Cantidad: ${envio.cantidad}'),
            Text(localizations.owner(envio.nombrePropietario)),
          ],
        ),
        isThreeLine: true,
      ),
    );
  }

  Widget _tablaResumen(
      BuildContext context, int total, int enTransito, int entregados) {
    final localizations = AppLocalizations.of(context)!;
    return Table(
      border: TableBorder.all(color: Colors.grey.shade300),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TableRow(
          decoration: BoxDecoration(color: Colors.grey.shade200),
          children: [
            Padding(
                padding: const EdgeInsets.all(8),
                child: Text(localizations.orders,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold))),
            Padding(
                padding: const EdgeInsets.all(8),
                child: Text(localizations.inTransit,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold))),
            Padding(
                padding: const EdgeInsets.all(8),
                child: Text(localizations.delivered,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold))),
          ],
        ),
        TableRow(
          children: [
            Padding(
                padding: const EdgeInsets.all(8),
                child: Text('$total', textAlign: TextAlign.center)),
            Padding(
                padding: const EdgeInsets.all(8),
                child: Text('$enTransito', textAlign: TextAlign.center)),
            Padding(
                padding: const EdgeInsets.all(8),
                child: Text('$entregados', textAlign: TextAlign.center)),
          ],
        ),
      ],
    );
  }

  Widget _barraResumenEnvios(
      BuildContext context, int enTransito, int entregados) {
    final localizations = AppLocalizations.of(context)!;
    final total = enTransito + entregados;
    final porcentaje = total == 0 ? 0.0 : entregados / total;
    final anchoBarra = MediaQuery.of(context).size.width - 64;
    final anchoVerde = porcentaje * anchoBarra;
    final anchoNaranja = (1 - porcentaje) * anchoBarra;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(localizations.shipmentsSummary,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
                child: enTransito > 0
                    ? Text(localizations.inTransit,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12))
                    : const SizedBox.shrink(),
              ),
              Container(
                width: anchoVerde,
                height: 24,
                color: Colors.green,
                alignment: Alignment.center,
                child: entregados > 0
                    ? Text(localizations.delivered,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12))
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// --- WIDGET REUTILIZABLE PARA CAMBIAR IDIOMA ---
class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        LanguageButton(locale: Locale('es'), tooltip: 'Español'),
        SizedBox(width: 8),
        LanguageButton(locale: Locale('en'), tooltip: 'English'),
      ],
    );
  }
}

class LanguageButton extends StatelessWidget {
  final Locale locale;
  final String tooltip;

  const LanguageButton(
      {super.key, required this.locale, required this.tooltip});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final bool isSelected = appState.appLocale == locale;

    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: () {
          Provider.of<AppState>(context, listen: false).changeLocale(locale);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color:
                isSelected ? Colors.white.withOpacity(0.9) : Colors.transparent,
            shape: BoxShape.circle,
            border:
                isSelected ? Border.all(color: Colors.white, width: 2) : null,
          ),
          child: Text(
            locale.languageCode.toUpperCase(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.blue.shade900 : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
