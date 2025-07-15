import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es')
  ];

  /// No description provided for @welcomeMessage.
  ///
  /// In es, this message translates to:
  /// **'BIENVENIDO'**
  String get welcomeMessage;

  /// No description provided for @userHint.
  ///
  /// In es, this message translates to:
  /// **'Usuario'**
  String get userHint;

  /// No description provided for @passwordHint.
  ///
  /// In es, this message translates to:
  /// **'Contraseña'**
  String get passwordHint;

  /// No description provided for @loginButton.
  ///
  /// In es, this message translates to:
  /// **'Entrar'**
  String get loginButton;

  /// No description provided for @invalidCredentials.
  ///
  /// In es, this message translates to:
  /// **'Credenciales no válidas'**
  String get invalidCredentials;

  /// No description provided for @home.
  ///
  /// In es, this message translates to:
  /// **'Inicio'**
  String get home;

  /// No description provided for @status.
  ///
  /// In es, this message translates to:
  /// **'Estado'**
  String get status;

  /// No description provided for @history.
  ///
  /// In es, this message translates to:
  /// **'Historial'**
  String get history;

  /// No description provided for @shipments.
  ///
  /// In es, this message translates to:
  /// **'Envíos'**
  String get shipments;

  /// No description provided for @sensors.
  ///
  /// In es, this message translates to:
  /// **'Sensores'**
  String get sensors;

  /// No description provided for @admin.
  ///
  /// In es, this message translates to:
  /// **'Admin'**
  String get admin;

  /// No description provided for @lastUpdate.
  ///
  /// In es, this message translates to:
  /// **'Última actualización: {time}'**
  String lastUpdate(String time);

  /// No description provided for @searchByProductOrOwner.
  ///
  /// In es, this message translates to:
  /// **'Buscar por producto o propietario'**
  String get searchByProductOrOwner;

  /// No description provided for @shipmentsSummary.
  ///
  /// In es, this message translates to:
  /// **'Resumen de envíos'**
  String get shipmentsSummary;

  /// No description provided for @inTransit.
  ///
  /// In es, this message translates to:
  /// **'En tránsito'**
  String get inTransit;

  /// No description provided for @delivered.
  ///
  /// In es, this message translates to:
  /// **'Entregados'**
  String get delivered;

  /// No description provided for @orders.
  ///
  /// In es, this message translates to:
  /// **'Pedidos'**
  String get orders;

  /// No description provided for @reminderIn10s.
  ///
  /// In es, this message translates to:
  /// **'Recordatorio en 10s'**
  String get reminderIn10s;

  /// No description provided for @reminderSet.
  ///
  /// In es, this message translates to:
  /// **'Recordatorio programado en 10 segundos.'**
  String get reminderSet;

  /// No description provided for @air.
  ///
  /// In es, this message translates to:
  /// **'Aéreos ✈️'**
  String get air;

  /// No description provided for @land.
  ///
  /// In es, this message translates to:
  /// **'Terrestres 🚛'**
  String get land;

  /// No description provided for @searchByOrderId.
  ///
  /// In es, this message translates to:
  /// **'Buscar por ID de Pedido'**
  String get searchByOrderId;

  /// No description provided for @noOrdersFound.
  ///
  /// In es, this message translates to:
  /// **'No se encontraron pedidos.'**
  String get noOrdersFound;

  /// No description provided for @orderId.
  ///
  /// In es, this message translates to:
  /// **'ID Pedido: {id}'**
  String orderId(String id);

  /// No description provided for @owner.
  ///
  /// In es, this message translates to:
  /// **'Propietario: {name}'**
  String owner(String name);

  /// No description provided for @bluetoothDevices.
  ///
  /// In es, this message translates to:
  /// **'Dispositivos Bluetooth'**
  String get bluetoothDevices;

  /// No description provided for @noDevicesFound.
  ///
  /// In es, this message translates to:
  /// **'No se encontraron dispositivos'**
  String get noDevicesFound;

  /// No description provided for @searchDevices.
  ///
  /// In es, this message translates to:
  /// **'Buscar dispositivos'**
  String get searchDevices;

  /// No description provided for @unnamedDevice.
  ///
  /// In es, this message translates to:
  /// **'Sin nombre'**
  String get unnamedDevice;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
