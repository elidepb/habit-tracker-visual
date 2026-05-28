// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appName => 'Habit Tracker';

  @override
  String get appNameSuffix => 'Visual';

  @override
  String get navHome => 'Inicio';

  @override
  String get navStatistics => 'Estadísticas';

  @override
  String get navSettings => 'Ajustes';

  @override
  String get homeTitle => 'Hábitos';

  @override
  String get homeStatsTooltip => 'Estadísticas';

  @override
  String get homeNewHabitTooltip => 'Nuevo hábito';

  @override
  String get homeLoadError => 'No se pudieron cargar los hábitos';

  @override
  String get homeYourHabits => 'Tus hábitos';

  @override
  String get homeEmptyTitle => 'Sin hábitos aún';

  @override
  String get homeEmptyBody =>
      'Crea tu primer hábito para empezar a trackear tu progreso.';

  @override
  String get homeEmptyCreateButton => 'Crear hábito';

  @override
  String get greetingMorning => 'Buenos días';

  @override
  String get greetingAfternoon => 'Buenas tardes';

  @override
  String get greetingEvening => 'Buenas noches';

  @override
  String get dailySummaryNoHabits =>
      'Empieza creando tu primer hábito y construye consistencia día a día.';

  @override
  String get dailySummaryAllComplete =>
      '¡Excelente! Completaste todos tus hábitos hoy. Sigue así.';

  @override
  String dailySummaryPartial(int remaining) {
    return 'Vas por buen camino. Te faltan $remaining por completar hoy.';
  }

  @override
  String get dailySummaryNoneComplete =>
      'Aún no has completado hábitos hoy. ¡Da el primer paso!';

  @override
  String get dailySummaryKeepGoing =>
      'Cada check cuenta. Sigue avanzando con tus hábitos.';

  @override
  String dateDisplay(String weekday, int day, String month) {
    return '$weekday, $day de $month';
  }

  @override
  String get statCompleted => 'Completados';

  @override
  String get statProgress => 'Progreso';

  @override
  String get statBestStreak => 'Mejor racha';

  @override
  String get statConsistency => 'Consistencia';

  @override
  String get statActiveDays => 'Días activos';

  @override
  String get statWeeklyAverage => 'Promedio semanal';

  @override
  String get statCompletion => 'Cumplimiento';

  @override
  String get statCurrentStreak => 'Racha actual';

  @override
  String get unitDays => 'días';

  @override
  String get unitPercent => '%';

  @override
  String get heatmapIntensityNone => 'Sin actividad';

  @override
  String get heatmapIntensityCompleted => 'Completado';

  @override
  String get heatmapIntensityLow => 'Baja actividad';

  @override
  String get heatmapIntensityMedium => 'Actividad media';

  @override
  String get heatmapIntensityHigh => 'Alta actividad';

  @override
  String get heatmapIntensityAll => 'Todos completados';

  @override
  String get heatmapIntensityDefault => 'Actividad';

  @override
  String get heatmapAnnualTitle => 'Actividad anual';

  @override
  String heatmapActiveDaysThisYear(int count) {
    return '$count días activos este año';
  }

  @override
  String get heatmapLegendLess => 'Menos';

  @override
  String get heatmapLegendMore => 'Más';

  @override
  String heatmapTooltipNoActivity(String date) {
    return '$date — Sin actividad';
  }

  @override
  String heatmapTooltipLevel(String date, int level) {
    return '$date — Nivel $level';
  }

  @override
  String heatmapTooltipWithIntensity(String date, String intensity) {
    return '$date — $intensity';
  }

  @override
  String get statisticsTitle => 'Estadísticas';

  @override
  String get statisticsEmptyTitle => 'Sin datos aún';

  @override
  String get statisticsEmptyBody =>
      'Crea hábitos y registra checks para ver tus estadísticas globales.';

  @override
  String get statsOverviewTitle => 'Resumen';

  @override
  String get weeklyChartEmpty => 'Sin actividad esta semana';

  @override
  String get weeklyChartTitle => 'Actividad semanal';

  @override
  String get weeklyChartSubtitle =>
      'Checks completados por día (últimos 7 días)';

  @override
  String get habitRankingEmpty => 'Crea hábitos para ver el ranking';

  @override
  String get habitRankingTitle => 'Ranking de hábitos';

  @override
  String get habitRankingSubtitle => 'Ordenados por tasa de cumplimiento';

  @override
  String habitRankingCompletion(int percent) {
    return '$percent% cumplimiento';
  }

  @override
  String get habitDetailEditTooltip => 'Editar';

  @override
  String get habitDetailAnnualActivity => 'Actividad anual';

  @override
  String get habitDetailHistory => 'Historial';

  @override
  String get habitDetailReminder => 'Recordatorio';

  @override
  String get habitDetailEditButton => 'Editar hábito';

  @override
  String get habitDetailDeleteButton => 'Eliminar hábito';

  @override
  String get heatmapDayCompleted => 'Completado';

  @override
  String get heatmapDayNotCompleted => 'Sin completar';

  @override
  String get habitStatusCompletedToday => 'Completado hoy';

  @override
  String get habitStatusPendingToday => 'Pendiente hoy';

  @override
  String habitCurrentStreak(int streak) {
    return 'Racha actual: $streak días';
  }

  @override
  String get habitStatsTitle => 'Estadísticas';

  @override
  String get calendarTapHint =>
      'Toca un día para marcar o desmarcar como completado.';

  @override
  String get formReminderTimeRequired =>
      'Selecciona una hora para el recordatorio';

  @override
  String get formEditTitle => 'Editar hábito';

  @override
  String get formCreateTitle => 'Nuevo hábito';

  @override
  String get formNameLabel => 'Nombre del hábito';

  @override
  String get formNameHint => 'Ej. Leer 30 minutos';

  @override
  String get formSaveChanges => 'Guardar cambios';

  @override
  String get formCreateButton => 'Crear hábito';

  @override
  String get formColorLabel => 'Color';

  @override
  String get formIconLabel => 'Icono';

  @override
  String get formFrequencyLabel => 'Frecuencia';

  @override
  String get reminderTitle => 'Recordatorio';

  @override
  String get reminderSubtitle => 'Recibe un aviso diario';

  @override
  String get timeSelectFallback => 'Seleccionar hora';

  @override
  String get timeEmptyFallback => '—';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Eliminar';

  @override
  String get onboardingWelcomeTitle => 'Bienvenido';

  @override
  String get onboardingWelcomeSubtitle =>
      'Rastrea tus hábitos con un heatmap inspirado en GitHub. Construye consistencia, un día a la vez.';

  @override
  String get onboardingHeatmapTitle => 'Heatmap visual';

  @override
  String get onboardingHeatmapDescription =>
      'Visualiza tu progreso anual de un vistazo.';

  @override
  String get onboardingStreaksTitle => 'Rachas';

  @override
  String get onboardingStreaksDescription =>
      'Mantén la motivación con rachas diarias.';

  @override
  String get onboardingStartButton => 'Comenzar';

  @override
  String get deleteHabitTitle => 'Eliminar hábito';

  @override
  String deleteHabitMessageNamed(String habitName) {
    return '¿Eliminar \"$habitName\"? Esta acción no se puede deshacer.';
  }

  @override
  String get deleteHabitMessageGeneric =>
      'Esta acción no se puede deshacer. ¿Deseas eliminar este hábito?';

  @override
  String get habitNotFound => 'Hábito no encontrado';

  @override
  String checkFeedbackStreak(int streak) {
    return '¡Completado! Racha de $streak días';
  }

  @override
  String get checkFeedbackCompleted => '¡Hábito completado hoy!';

  @override
  String get frequencyDaily => 'Diario';

  @override
  String get frequencyWeekly => 'Semanal';

  @override
  String get frequencyCustom => 'Personalizado';

  @override
  String get validationNameRequired => 'El nombre es obligatorio';

  @override
  String validationNameMaxLength(int max) {
    return 'Máximo $max caracteres';
  }

  @override
  String get notificationChannelName => 'Recordatorios de hábitos';

  @override
  String get notificationChannelDescription =>
      'Avisos diarios para completar tus hábitos';

  @override
  String get notificationReminderTitle => 'Recordatorio de hábito';

  @override
  String notificationReminderBody(String habitName) {
    return 'Es hora de completar: $habitName';
  }

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get settingsAppearanceSection => 'Apariencia';

  @override
  String get settingsThemeTitle => 'Tema';

  @override
  String get settingsThemeSubtitle => 'Elige el modo de color de la aplicación';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Oscuro';

  @override
  String get settingsLanguageSection => 'Idioma';

  @override
  String get settingsLanguageTitle => 'Idioma';

  @override
  String get settingsLanguageSubtitle => 'Elige el idioma de la aplicación';

  @override
  String get languageSystem => 'Sistema';

  @override
  String get languageSpanish => 'Español';

  @override
  String get languageEnglish => 'English';

  @override
  String get settingsNotificationsSection => 'Notificaciones';

  @override
  String get settingsRemindersTitle => 'Recordatorios';

  @override
  String get settingsRemindersSubtitle =>
      'Avisos diarios según la hora de cada hábito';

  @override
  String get settingsNotificationsUnsupported =>
      'Notificaciones no disponibles en esta plataforma.';

  @override
  String get settingsAllowNotifications => 'Permitir notificaciones';

  @override
  String get monthShortJan => 'Ene';

  @override
  String get monthShortFeb => 'Feb';

  @override
  String get monthShortMar => 'Mar';

  @override
  String get monthShortApr => 'Abr';

  @override
  String get monthShortMay => 'May';

  @override
  String get monthShortJun => 'Jun';

  @override
  String get monthShortJul => 'Jul';

  @override
  String get monthShortAug => 'Ago';

  @override
  String get monthShortSep => 'Sep';

  @override
  String get monthShortOct => 'Oct';

  @override
  String get monthShortNov => 'Nov';

  @override
  String get monthShortDec => 'Dic';

  @override
  String get monthLongJan => 'enero';

  @override
  String get monthLongFeb => 'febrero';

  @override
  String get monthLongMar => 'marzo';

  @override
  String get monthLongApr => 'abril';

  @override
  String get monthLongMay => 'mayo';

  @override
  String get monthLongJun => 'junio';

  @override
  String get monthLongJul => 'julio';

  @override
  String get monthLongAug => 'agosto';

  @override
  String get monthLongSep => 'septiembre';

  @override
  String get monthLongOct => 'octubre';

  @override
  String get monthLongNov => 'noviembre';

  @override
  String get monthLongDec => 'diciembre';

  @override
  String get weekdayMonday => 'Lunes';

  @override
  String get weekdayTuesday => 'Martes';

  @override
  String get weekdayWednesday => 'Miércoles';

  @override
  String get weekdayThursday => 'Jueves';

  @override
  String get weekdayFriday => 'Viernes';

  @override
  String get weekdaySaturday => 'Sábado';

  @override
  String get weekdaySunday => 'Domingo';

  @override
  String get weekdayLetterSun => 'D';

  @override
  String get weekdayLetterMon => 'L';

  @override
  String get weekdayLetterTue => 'M';

  @override
  String get weekdayLetterWed => 'X';

  @override
  String get weekdayLetterThu => 'J';

  @override
  String get weekdayLetterFri => 'V';

  @override
  String get weekdayLetterSat => 'S';

  @override
  String get monthCalendarJan => 'Enero';

  @override
  String get monthCalendarFeb => 'Febrero';

  @override
  String get monthCalendarMar => 'Marzo';

  @override
  String get monthCalendarApr => 'Abril';

  @override
  String get monthCalendarMay => 'Mayo';

  @override
  String get monthCalendarJun => 'Junio';

  @override
  String get monthCalendarJul => 'Julio';

  @override
  String get monthCalendarAug => 'Agosto';

  @override
  String get monthCalendarSep => 'Septiembre';

  @override
  String get monthCalendarOct => 'Octubre';

  @override
  String get monthCalendarNov => 'Noviembre';

  @override
  String get monthCalendarDec => 'Diciembre';

  @override
  String get iconActivity => 'Actividad';

  @override
  String get iconExercise => 'Ejercicio';

  @override
  String get iconReading => 'Lectura';

  @override
  String get iconSleep => 'Sueño';

  @override
  String get iconWater => 'Agua';

  @override
  String get iconMind => 'Mente';

  @override
  String get iconHealth => 'Salud';

  @override
  String get iconTime => 'Tiempo';
}
