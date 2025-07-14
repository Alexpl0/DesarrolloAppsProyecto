// Punto de entrada principal de la aplicación Flutter
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Importa las traducciones generadas

// Se ajustan las rutas de importación para ser relativas a la carpeta 'lib'.
import 'screens/PaginaEnvios.dart';
import 'screens/PaginaHistorial.dart';
import 'screens/PaginaHome.dart';
import 'screens/PaginaStatus.dart';
import 'login/login.dart';
import 'screens/DeviceSelectionScreen.dart';

// Proveedor de estado para manejar el idioma de la app.
class AppState extends ChangeNotifier {
  Locale _appLocale = const Locale('es');
  Locale get appLocale => _appLocale;

  void changeLocale(Locale newLocale) {
    if (_appLocale == newLocale) return;
    _appLocale = newLocale;
    notifyListeners();
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppState()),
      ],
      child: const RastreoSensorApp(),
    ),
  );
}

// Widget principal que configura la aplicación completa
class RastreoSensorApp extends StatelessWidget {
  const RastreoSensorApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rastreo + Sensores',

      // --- CONFIGURACIÓN PARA INTERNACIONALIZACIÓN (i18n) ---
      locale: appState.appLocale,
      supportedLocales: const [
        Locale('es', ''), // Español
        Locale('en', ''), // Inglés
      ],
      localizationsDelegates: const [
        // --- DELEGADO DE NUESTRAS TRADUCCIONES ---
        AppLocalizations.delegate,
        // Delegados para los widgets de Flutter
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(
            255,
            58,
            173,
            183,
          ),
        ),
        scaffoldBackgroundColor: Colors.grey[100],
        useMaterial3: true,
      ),

      initialRoute: '/',
      routes: {
        '/': (context) => const Login(),
        '/PaginaHome': (context) => const PaginaHome(),
        '/PaginaStatus': (context) => const PaginaStatus(),
        '/PaginaHistorial': (context) => const PaginaHistorial(),
        '/BluetoothDeviceSelection': (context) => const DeviceSelectionScreen(),
        '/PaginaEnvios': (context) => const PaginaEnvios(),
      },
    );
  }
}
