import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sensor_bluetooth_app/l10n/app_localizations.dart'
    show AppLocalizations;
//import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Importamos nuestros servicios
import 'services/preferences_service.dart';
import 'services/notification_service.dart'; // Importamos el servicio de notificaciones

import 'screens/PaginaEnvios.dart';
import 'screens/PaginaHistorial.dart';
import 'screens/PaginaHome.dart';
import 'screens/PaginaStatus.dart';
import 'login/login.dart';
import 'screens/DeviceSelectionScreen.dart';

class AppState extends ChangeNotifier {
  final PreferencesService _preferencesService;
  late Locale _appLocale;

  AppState(this._preferencesService, this._appLocale);

  Locale get appLocale => _appLocale;

  Future<void> changeLocale(Locale newLocale) async {
    if (_appLocale == newLocale) return;
    _appLocale = newLocale;
    notifyListeners();
    await _preferencesService.saveLanguage(newLocale.languageCode);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final preferencesService = PreferencesService();
  final initialLocale = await preferencesService.loadLanguage();

  // --- INICIALIZAR SERVICIO DE NOTIFICACIONES ---
  await NotificationService().init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AppState(preferencesService, initialLocale),
        ),
      ],
      child: const RastreoSensorApp(),
    ),
  );
}

class RastreoSensorApp extends StatelessWidget {
  const RastreoSensorApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rastreo + Sensores',
      locale: appState.appLocale,
      supportedLocales: const [
        Locale('es', ''),
        Locale('en', ''),
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
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
