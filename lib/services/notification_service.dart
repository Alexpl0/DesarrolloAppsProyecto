import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  // Hacemos esta clase un Singleton para asegurar que solo haya una instancia.
  static final NotificationService _notificationService =
      NotificationService._internal();
  factory NotificationService() {
    return _notificationService;
  }
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    // --- Configuración para Android ---
    // Debes tener un ícono llamado 'app_icon.png' en android/app/src/main/res/drawable/
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('app_icon');

    // --- Configuración para iOS ---
    const DarwinInitializationSettings darwinInitializationSettings =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      iOS: darwinInitializationSettings,
    );

    // Inicializa el plugin de notificaciones
    await _notificationsPlugin.initialize(initializationSettings);

    // Inicializa las zonas horarias
    tz.initializeTimeZones();
  }

  // Método para mostrar una notificación de prueba inmediata
  Future<void> showNotification(String title, String body) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'main_channel', // ID del canal
      'Main Channel', // Nombre del canal
      channelDescription: 'Canal principal de notificaciones',
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    await _notificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails,
    );
  }

  // Método para programar una notificación
  Future<void> scheduleNotification(
      String title, String body, int seconds) async {
    await _notificationsPlugin.zonedSchedule(
      1,
      title,
      body,
      tz.TZDateTime.now(tz.local).add(Duration(seconds: seconds)),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'scheduled_channel',
          'Scheduled Channel',
          channelDescription: 'Canal para notificaciones programadas',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
