import 'package:flutter/foundation.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

Future<void> configureLocalTimezone() async {
  tz.initializeTimeZones();

  if (kIsWeb) return;

  try {
    final timeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZone.identifier));
  } catch (error) {
    debugPrint('No se pudo configurar la zona horaria local: $error');
  }
}
