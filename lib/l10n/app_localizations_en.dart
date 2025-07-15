// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get welcomeMessage => 'WELCOME';

  @override
  String get userHint => 'User';

  @override
  String get passwordHint => 'Password';

  @override
  String get loginButton => 'Login';

  @override
  String get invalidCredentials => 'Invalid credentials';

  @override
  String get home => 'Home';

  @override
  String get status => 'Status';

  @override
  String get history => 'History';

  @override
  String get shipments => 'Shipments';

  @override
  String get sensors => 'Sensors';

  @override
  String get admin => 'Admin';

  @override
  String lastUpdate(String time) {
    return 'Last update: $time';
  }

  @override
  String get searchByProductOrOwner => 'Search by product or owner';

  @override
  String get shipmentsSummary => 'Shipments Summary';

  @override
  String get inTransit => 'In Transit';

  @override
  String get delivered => 'Delivered';

  @override
  String get orders => 'Orders';

  @override
  String get reminderIn10s => 'Reminder in 10s';

  @override
  String get reminderSet => 'Reminder set for 10 seconds.';

  @override
  String get air => 'Air ✈️';

  @override
  String get land => 'Land 🚛';

  @override
  String get searchByOrderId => 'Search by Order ID';

  @override
  String get noOrdersFound => 'No orders found.';

  @override
  String orderId(String id) {
    return 'Order ID: $id';
  }

  @override
  String owner(String name) {
    return 'Owner: $name';
  }

  @override
  String get bluetoothDevices => 'Bluetooth Devices';

  @override
  String get noDevicesFound => 'No devices found';

  @override
  String get searchDevices => 'Search devices';

  @override
  String get unnamedDevice => 'Unnamed';
}
