// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get welcomeMessage => 'BIENVENIDO';

  @override
  String get userHint => 'Usuario';

  @override
  String get passwordHint => 'Contraseña';

  @override
  String get loginButton => 'Entrar';

  @override
  String get invalidCredentials => 'Credenciales no válidas';

  @override
  String get home => 'Inicio';

  @override
  String get status => 'Estado';

  @override
  String get history => 'Historial';

  @override
  String get shipments => 'Envíos';

  @override
  String get sensors => 'Sensores';

  @override
  String get admin => 'Admin';

  @override
  String lastUpdate(String time) {
    return 'Última actualización: $time';
  }

  @override
  String get searchByProductOrOwner => 'Buscar por producto o propietario';

  @override
  String get shipmentsSummary => 'Resumen de envíos';

  @override
  String get inTransit => 'En tránsito';

  @override
  String get delivered => 'Entregados';

  @override
  String get orders => 'Pedidos';

  @override
  String get reminderIn10s => 'Recordatorio en 10s';

  @override
  String get reminderSet => 'Recordatorio programado en 10 segundos.';

  @override
  String get air => 'Aéreos ✈️';

  @override
  String get land => 'Terrestres 🚛';

  @override
  String get searchByOrderId => 'Buscar por ID de Pedido';

  @override
  String get noOrdersFound => 'No se encontraron pedidos.';

  @override
  String orderId(String id) {
    return 'ID Pedido: $id';
  }

  @override
  String owner(String name) {
    return 'Propietario: $name';
  }

  @override
  String get bluetoothDevices => 'Dispositivos Bluetooth';

  @override
  String get noDevicesFound => 'No se encontraron dispositivos';

  @override
  String get searchDevices => 'Buscar dispositivos';

  @override
  String get unnamedDevice => 'Sin nombre';
}
