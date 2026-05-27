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

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
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
    Locale('es'),
  ];

  /// No description provided for @appName.
  ///
  /// In es, this message translates to:
  /// **'Habit Tracker'**
  String get appName;

  /// No description provided for @appNameSuffix.
  ///
  /// In es, this message translates to:
  /// **'Visual'**
  String get appNameSuffix;

  /// No description provided for @navHome.
  ///
  /// In es, this message translates to:
  /// **'Inicio'**
  String get navHome;

  /// No description provided for @navStatistics.
  ///
  /// In es, this message translates to:
  /// **'Estadísticas'**
  String get navStatistics;

  /// No description provided for @navSettings.
  ///
  /// In es, this message translates to:
  /// **'Ajustes'**
  String get navSettings;

  /// No description provided for @homeTitle.
  ///
  /// In es, this message translates to:
  /// **'Hábitos'**
  String get homeTitle;

  /// No description provided for @homeStatsTooltip.
  ///
  /// In es, this message translates to:
  /// **'Estadísticas'**
  String get homeStatsTooltip;

  /// No description provided for @homeNewHabitTooltip.
  ///
  /// In es, this message translates to:
  /// **'Nuevo hábito'**
  String get homeNewHabitTooltip;

  /// No description provided for @homeLoadError.
  ///
  /// In es, this message translates to:
  /// **'No se pudieron cargar los hábitos'**
  String get homeLoadError;

  /// No description provided for @homeYourHabits.
  ///
  /// In es, this message translates to:
  /// **'Tus hábitos'**
  String get homeYourHabits;

  /// No description provided for @homeEmptyTitle.
  ///
  /// In es, this message translates to:
  /// **'Sin hábitos aún'**
  String get homeEmptyTitle;

  /// No description provided for @homeEmptyBody.
  ///
  /// In es, this message translates to:
  /// **'Crea tu primer hábito para empezar a trackear tu progreso.'**
  String get homeEmptyBody;

  /// No description provided for @homeEmptyCreateButton.
  ///
  /// In es, this message translates to:
  /// **'Crear hábito'**
  String get homeEmptyCreateButton;

  /// No description provided for @greetingMorning.
  ///
  /// In es, this message translates to:
  /// **'Buenos días'**
  String get greetingMorning;

  /// No description provided for @greetingAfternoon.
  ///
  /// In es, this message translates to:
  /// **'Buenas tardes'**
  String get greetingAfternoon;

  /// No description provided for @greetingEvening.
  ///
  /// In es, this message translates to:
  /// **'Buenas noches'**
  String get greetingEvening;

  /// No description provided for @dailySummaryNoHabits.
  ///
  /// In es, this message translates to:
  /// **'Empieza creando tu primer hábito y construye consistencia día a día.'**
  String get dailySummaryNoHabits;

  /// No description provided for @dailySummaryAllComplete.
  ///
  /// In es, this message translates to:
  /// **'¡Excelente! Completaste todos tus hábitos hoy. Sigue así.'**
  String get dailySummaryAllComplete;

  /// No description provided for @dailySummaryPartial.
  ///
  /// In es, this message translates to:
  /// **'Vas por buen camino. Te faltan {remaining} por completar hoy.'**
  String dailySummaryPartial(int remaining);

  /// No description provided for @dailySummaryNoneComplete.
  ///
  /// In es, this message translates to:
  /// **'Aún no has completado hábitos hoy. ¡Da el primer paso!'**
  String get dailySummaryNoneComplete;

  /// No description provided for @dailySummaryKeepGoing.
  ///
  /// In es, this message translates to:
  /// **'Cada check cuenta. Sigue avanzando con tus hábitos.'**
  String get dailySummaryKeepGoing;

  /// No description provided for @dateDisplay.
  ///
  /// In es, this message translates to:
  /// **'{weekday}, {day} de {month}'**
  String dateDisplay(String weekday, int day, String month);

  /// No description provided for @statCompleted.
  ///
  /// In es, this message translates to:
  /// **'Completados'**
  String get statCompleted;

  /// No description provided for @statProgress.
  ///
  /// In es, this message translates to:
  /// **'Progreso'**
  String get statProgress;

  /// No description provided for @statBestStreak.
  ///
  /// In es, this message translates to:
  /// **'Mejor racha'**
  String get statBestStreak;

  /// No description provided for @statConsistency.
  ///
  /// In es, this message translates to:
  /// **'Consistencia'**
  String get statConsistency;

  /// No description provided for @statActiveDays.
  ///
  /// In es, this message translates to:
  /// **'Días activos'**
  String get statActiveDays;

  /// No description provided for @statWeeklyAverage.
  ///
  /// In es, this message translates to:
  /// **'Promedio semanal'**
  String get statWeeklyAverage;

  /// No description provided for @statCompletion.
  ///
  /// In es, this message translates to:
  /// **'Cumplimiento'**
  String get statCompletion;

  /// No description provided for @statCurrentStreak.
  ///
  /// In es, this message translates to:
  /// **'Racha actual'**
  String get statCurrentStreak;

  /// No description provided for @unitDays.
  ///
  /// In es, this message translates to:
  /// **'días'**
  String get unitDays;

  /// No description provided for @unitPercent.
  ///
  /// In es, this message translates to:
  /// **'%'**
  String get unitPercent;

  /// No description provided for @heatmapIntensityNone.
  ///
  /// In es, this message translates to:
  /// **'Sin actividad'**
  String get heatmapIntensityNone;

  /// No description provided for @heatmapIntensityCompleted.
  ///
  /// In es, this message translates to:
  /// **'Completado'**
  String get heatmapIntensityCompleted;

  /// No description provided for @heatmapIntensityLow.
  ///
  /// In es, this message translates to:
  /// **'Baja actividad'**
  String get heatmapIntensityLow;

  /// No description provided for @heatmapIntensityMedium.
  ///
  /// In es, this message translates to:
  /// **'Actividad media'**
  String get heatmapIntensityMedium;

  /// No description provided for @heatmapIntensityHigh.
  ///
  /// In es, this message translates to:
  /// **'Alta actividad'**
  String get heatmapIntensityHigh;

  /// No description provided for @heatmapIntensityAll.
  ///
  /// In es, this message translates to:
  /// **'Todos completados'**
  String get heatmapIntensityAll;

  /// No description provided for @heatmapIntensityDefault.
  ///
  /// In es, this message translates to:
  /// **'Actividad'**
  String get heatmapIntensityDefault;

  /// No description provided for @heatmapAnnualTitle.
  ///
  /// In es, this message translates to:
  /// **'Actividad anual'**
  String get heatmapAnnualTitle;

  /// No description provided for @heatmapActiveDaysThisYear.
  ///
  /// In es, this message translates to:
  /// **'{count} días activos este año'**
  String heatmapActiveDaysThisYear(int count);

  /// No description provided for @heatmapLegendLess.
  ///
  /// In es, this message translates to:
  /// **'Menos'**
  String get heatmapLegendLess;

  /// No description provided for @heatmapLegendMore.
  ///
  /// In es, this message translates to:
  /// **'Más'**
  String get heatmapLegendMore;

  /// No description provided for @heatmapTooltipNoActivity.
  ///
  /// In es, this message translates to:
  /// **'{date} — Sin actividad'**
  String heatmapTooltipNoActivity(String date);

  /// No description provided for @heatmapTooltipLevel.
  ///
  /// In es, this message translates to:
  /// **'{date} — Nivel {level}'**
  String heatmapTooltipLevel(String date, int level);

  /// No description provided for @heatmapTooltipWithIntensity.
  ///
  /// In es, this message translates to:
  /// **'{date} — {intensity}'**
  String heatmapTooltipWithIntensity(String date, String intensity);

  /// No description provided for @statisticsTitle.
  ///
  /// In es, this message translates to:
  /// **'Estadísticas'**
  String get statisticsTitle;

  /// No description provided for @statisticsEmptyTitle.
  ///
  /// In es, this message translates to:
  /// **'Sin datos aún'**
  String get statisticsEmptyTitle;

  /// No description provided for @statisticsEmptyBody.
  ///
  /// In es, this message translates to:
  /// **'Crea hábitos y registra checks para ver tus estadísticas globales.'**
  String get statisticsEmptyBody;

  /// No description provided for @statsOverviewTitle.
  ///
  /// In es, this message translates to:
  /// **'Resumen'**
  String get statsOverviewTitle;

  /// No description provided for @weeklyChartEmpty.
  ///
  /// In es, this message translates to:
  /// **'Sin actividad esta semana'**
  String get weeklyChartEmpty;

  /// No description provided for @weeklyChartTitle.
  ///
  /// In es, this message translates to:
  /// **'Actividad semanal'**
  String get weeklyChartTitle;

  /// No description provided for @weeklyChartSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Checks completados por día (últimos 7 días)'**
  String get weeklyChartSubtitle;

  /// No description provided for @habitRankingEmpty.
  ///
  /// In es, this message translates to:
  /// **'Crea hábitos para ver el ranking'**
  String get habitRankingEmpty;

  /// No description provided for @habitRankingTitle.
  ///
  /// In es, this message translates to:
  /// **'Ranking de hábitos'**
  String get habitRankingTitle;

  /// No description provided for @habitRankingSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Ordenados por tasa de cumplimiento'**
  String get habitRankingSubtitle;

  /// No description provided for @habitRankingCompletion.
  ///
  /// In es, this message translates to:
  /// **'{percent}% cumplimiento'**
  String habitRankingCompletion(int percent);

  /// No description provided for @habitDetailEditTooltip.
  ///
  /// In es, this message translates to:
  /// **'Editar'**
  String get habitDetailEditTooltip;

  /// No description provided for @habitDetailAnnualActivity.
  ///
  /// In es, this message translates to:
  /// **'Actividad anual'**
  String get habitDetailAnnualActivity;

  /// No description provided for @habitDetailHistory.
  ///
  /// In es, this message translates to:
  /// **'Historial'**
  String get habitDetailHistory;

  /// No description provided for @habitDetailReminder.
  ///
  /// In es, this message translates to:
  /// **'Recordatorio'**
  String get habitDetailReminder;

  /// No description provided for @habitDetailEditButton.
  ///
  /// In es, this message translates to:
  /// **'Editar hábito'**
  String get habitDetailEditButton;

  /// No description provided for @habitDetailDeleteButton.
  ///
  /// In es, this message translates to:
  /// **'Eliminar hábito'**
  String get habitDetailDeleteButton;

  /// No description provided for @heatmapDayCompleted.
  ///
  /// In es, this message translates to:
  /// **'Completado'**
  String get heatmapDayCompleted;

  /// No description provided for @heatmapDayNotCompleted.
  ///
  /// In es, this message translates to:
  /// **'Sin completar'**
  String get heatmapDayNotCompleted;

  /// No description provided for @habitStatusCompletedToday.
  ///
  /// In es, this message translates to:
  /// **'Completado hoy'**
  String get habitStatusCompletedToday;

  /// No description provided for @habitStatusPendingToday.
  ///
  /// In es, this message translates to:
  /// **'Pendiente hoy'**
  String get habitStatusPendingToday;

  /// No description provided for @habitCurrentStreak.
  ///
  /// In es, this message translates to:
  /// **'Racha actual: {streak} días'**
  String habitCurrentStreak(int streak);

  /// No description provided for @habitStatsTitle.
  ///
  /// In es, this message translates to:
  /// **'Estadísticas'**
  String get habitStatsTitle;

  /// No description provided for @calendarTapHint.
  ///
  /// In es, this message translates to:
  /// **'Toca un día para marcar o desmarcar como completado.'**
  String get calendarTapHint;

  /// No description provided for @formReminderTimeRequired.
  ///
  /// In es, this message translates to:
  /// **'Selecciona una hora para el recordatorio'**
  String get formReminderTimeRequired;

  /// No description provided for @formEditTitle.
  ///
  /// In es, this message translates to:
  /// **'Editar hábito'**
  String get formEditTitle;

  /// No description provided for @formCreateTitle.
  ///
  /// In es, this message translates to:
  /// **'Nuevo hábito'**
  String get formCreateTitle;

  /// No description provided for @formNameLabel.
  ///
  /// In es, this message translates to:
  /// **'Nombre del hábito'**
  String get formNameLabel;

  /// No description provided for @formNameHint.
  ///
  /// In es, this message translates to:
  /// **'Ej. Leer 30 minutos'**
  String get formNameHint;

  /// No description provided for @formSaveChanges.
  ///
  /// In es, this message translates to:
  /// **'Guardar cambios'**
  String get formSaveChanges;

  /// No description provided for @formCreateButton.
  ///
  /// In es, this message translates to:
  /// **'Crear hábito'**
  String get formCreateButton;

  /// No description provided for @formColorLabel.
  ///
  /// In es, this message translates to:
  /// **'Color'**
  String get formColorLabel;

  /// No description provided for @formIconLabel.
  ///
  /// In es, this message translates to:
  /// **'Icono'**
  String get formIconLabel;

  /// No description provided for @formFrequencyLabel.
  ///
  /// In es, this message translates to:
  /// **'Frecuencia'**
  String get formFrequencyLabel;

  /// No description provided for @reminderTitle.
  ///
  /// In es, this message translates to:
  /// **'Recordatorio'**
  String get reminderTitle;

  /// No description provided for @reminderSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Recibe un aviso diario'**
  String get reminderSubtitle;

  /// No description provided for @timeSelectFallback.
  ///
  /// In es, this message translates to:
  /// **'Seleccionar hora'**
  String get timeSelectFallback;

  /// No description provided for @timeEmptyFallback.
  ///
  /// In es, this message translates to:
  /// **'—'**
  String get timeEmptyFallback;

  /// No description provided for @cancel.
  ///
  /// In es, this message translates to:
  /// **'Cancelar'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In es, this message translates to:
  /// **'Eliminar'**
  String get delete;

  /// No description provided for @onboardingWelcomeTitle.
  ///
  /// In es, this message translates to:
  /// **'Bienvenido'**
  String get onboardingWelcomeTitle;

  /// No description provided for @onboardingWelcomeSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Rastrea tus hábitos con un heatmap inspirado en GitHub. Construye consistencia, un día a la vez.'**
  String get onboardingWelcomeSubtitle;

  /// No description provided for @onboardingHeatmapTitle.
  ///
  /// In es, this message translates to:
  /// **'Heatmap visual'**
  String get onboardingHeatmapTitle;

  /// No description provided for @onboardingHeatmapDescription.
  ///
  /// In es, this message translates to:
  /// **'Visualiza tu progreso anual de un vistazo.'**
  String get onboardingHeatmapDescription;

  /// No description provided for @onboardingStreaksTitle.
  ///
  /// In es, this message translates to:
  /// **'Rachas'**
  String get onboardingStreaksTitle;

  /// No description provided for @onboardingStreaksDescription.
  ///
  /// In es, this message translates to:
  /// **'Mantén la motivación con rachas diarias.'**
  String get onboardingStreaksDescription;

  /// No description provided for @onboardingStartButton.
  ///
  /// In es, this message translates to:
  /// **'Comenzar'**
  String get onboardingStartButton;

  /// No description provided for @deleteHabitTitle.
  ///
  /// In es, this message translates to:
  /// **'Eliminar hábito'**
  String get deleteHabitTitle;

  /// No description provided for @deleteHabitMessageNamed.
  ///
  /// In es, this message translates to:
  /// **'¿Eliminar \"{habitName}\"? Esta acción no se puede deshacer.'**
  String deleteHabitMessageNamed(String habitName);

  /// No description provided for @deleteHabitMessageGeneric.
  ///
  /// In es, this message translates to:
  /// **'Esta acción no se puede deshacer. ¿Deseas eliminar este hábito?'**
  String get deleteHabitMessageGeneric;

  /// No description provided for @habitNotFound.
  ///
  /// In es, this message translates to:
  /// **'Hábito no encontrado'**
  String get habitNotFound;

  /// No description provided for @checkFeedbackStreak.
  ///
  /// In es, this message translates to:
  /// **'¡Completado! Racha de {streak} días'**
  String checkFeedbackStreak(int streak);

  /// No description provided for @checkFeedbackCompleted.
  ///
  /// In es, this message translates to:
  /// **'¡Hábito completado hoy!'**
  String get checkFeedbackCompleted;

  /// No description provided for @frequencyDaily.
  ///
  /// In es, this message translates to:
  /// **'Diario'**
  String get frequencyDaily;

  /// No description provided for @frequencyWeekly.
  ///
  /// In es, this message translates to:
  /// **'Semanal'**
  String get frequencyWeekly;

  /// No description provided for @frequencyCustom.
  ///
  /// In es, this message translates to:
  /// **'Personalizado'**
  String get frequencyCustom;

  /// No description provided for @validationNameRequired.
  ///
  /// In es, this message translates to:
  /// **'El nombre es obligatorio'**
  String get validationNameRequired;

  /// No description provided for @validationNameMaxLength.
  ///
  /// In es, this message translates to:
  /// **'Máximo {max} caracteres'**
  String validationNameMaxLength(int max);

  /// No description provided for @notificationChannelName.
  ///
  /// In es, this message translates to:
  /// **'Recordatorios de hábitos'**
  String get notificationChannelName;

  /// No description provided for @notificationChannelDescription.
  ///
  /// In es, this message translates to:
  /// **'Avisos diarios para completar tus hábitos'**
  String get notificationChannelDescription;

  /// No description provided for @notificationReminderTitle.
  ///
  /// In es, this message translates to:
  /// **'Recordatorio de hábito'**
  String get notificationReminderTitle;

  /// No description provided for @notificationReminderBody.
  ///
  /// In es, this message translates to:
  /// **'Es hora de completar: {habitName}'**
  String notificationReminderBody(String habitName);

  /// No description provided for @settingsTitle.
  ///
  /// In es, this message translates to:
  /// **'Ajustes'**
  String get settingsTitle;

  /// No description provided for @settingsAppearanceSection.
  ///
  /// In es, this message translates to:
  /// **'Apariencia'**
  String get settingsAppearanceSection;

  /// No description provided for @settingsThemeTitle.
  ///
  /// In es, this message translates to:
  /// **'Tema'**
  String get settingsThemeTitle;

  /// No description provided for @settingsThemeSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Elige el modo de color de la aplicación'**
  String get settingsThemeSubtitle;

  /// No description provided for @themeSystem.
  ///
  /// In es, this message translates to:
  /// **'Sistema'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In es, this message translates to:
  /// **'Claro'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In es, this message translates to:
  /// **'Oscuro'**
  String get themeDark;

  /// No description provided for @settingsLanguageSection.
  ///
  /// In es, this message translates to:
  /// **'Idioma'**
  String get settingsLanguageSection;

  /// No description provided for @settingsLanguageTitle.
  ///
  /// In es, this message translates to:
  /// **'Idioma'**
  String get settingsLanguageTitle;

  /// No description provided for @settingsLanguageSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Elige el idioma de la aplicación'**
  String get settingsLanguageSubtitle;

  /// No description provided for @languageSystem.
  ///
  /// In es, this message translates to:
  /// **'Sistema'**
  String get languageSystem;

  /// No description provided for @languageSpanish.
  ///
  /// In es, this message translates to:
  /// **'Español'**
  String get languageSpanish;

  /// No description provided for @languageEnglish.
  ///
  /// In es, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @settingsNotificationsSection.
  ///
  /// In es, this message translates to:
  /// **'Notificaciones'**
  String get settingsNotificationsSection;

  /// No description provided for @settingsRemindersTitle.
  ///
  /// In es, this message translates to:
  /// **'Recordatorios'**
  String get settingsRemindersTitle;

  /// No description provided for @settingsRemindersSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Avisos diarios según la hora de cada hábito'**
  String get settingsRemindersSubtitle;

  /// No description provided for @settingsNotificationsUnsupported.
  ///
  /// In es, this message translates to:
  /// **'Notificaciones no disponibles en esta plataforma.'**
  String get settingsNotificationsUnsupported;

  /// No description provided for @settingsAllowNotifications.
  ///
  /// In es, this message translates to:
  /// **'Permitir notificaciones'**
  String get settingsAllowNotifications;

  /// No description provided for @monthShortJan.
  ///
  /// In es, this message translates to:
  /// **'Ene'**
  String get monthShortJan;

  /// No description provided for @monthShortFeb.
  ///
  /// In es, this message translates to:
  /// **'Feb'**
  String get monthShortFeb;

  /// No description provided for @monthShortMar.
  ///
  /// In es, this message translates to:
  /// **'Mar'**
  String get monthShortMar;

  /// No description provided for @monthShortApr.
  ///
  /// In es, this message translates to:
  /// **'Abr'**
  String get monthShortApr;

  /// No description provided for @monthShortMay.
  ///
  /// In es, this message translates to:
  /// **'May'**
  String get monthShortMay;

  /// No description provided for @monthShortJun.
  ///
  /// In es, this message translates to:
  /// **'Jun'**
  String get monthShortJun;

  /// No description provided for @monthShortJul.
  ///
  /// In es, this message translates to:
  /// **'Jul'**
  String get monthShortJul;

  /// No description provided for @monthShortAug.
  ///
  /// In es, this message translates to:
  /// **'Ago'**
  String get monthShortAug;

  /// No description provided for @monthShortSep.
  ///
  /// In es, this message translates to:
  /// **'Sep'**
  String get monthShortSep;

  /// No description provided for @monthShortOct.
  ///
  /// In es, this message translates to:
  /// **'Oct'**
  String get monthShortOct;

  /// No description provided for @monthShortNov.
  ///
  /// In es, this message translates to:
  /// **'Nov'**
  String get monthShortNov;

  /// No description provided for @monthShortDec.
  ///
  /// In es, this message translates to:
  /// **'Dic'**
  String get monthShortDec;

  /// No description provided for @monthLongJan.
  ///
  /// In es, this message translates to:
  /// **'enero'**
  String get monthLongJan;

  /// No description provided for @monthLongFeb.
  ///
  /// In es, this message translates to:
  /// **'febrero'**
  String get monthLongFeb;

  /// No description provided for @monthLongMar.
  ///
  /// In es, this message translates to:
  /// **'marzo'**
  String get monthLongMar;

  /// No description provided for @monthLongApr.
  ///
  /// In es, this message translates to:
  /// **'abril'**
  String get monthLongApr;

  /// No description provided for @monthLongMay.
  ///
  /// In es, this message translates to:
  /// **'mayo'**
  String get monthLongMay;

  /// No description provided for @monthLongJun.
  ///
  /// In es, this message translates to:
  /// **'junio'**
  String get monthLongJun;

  /// No description provided for @monthLongJul.
  ///
  /// In es, this message translates to:
  /// **'julio'**
  String get monthLongJul;

  /// No description provided for @monthLongAug.
  ///
  /// In es, this message translates to:
  /// **'agosto'**
  String get monthLongAug;

  /// No description provided for @monthLongSep.
  ///
  /// In es, this message translates to:
  /// **'septiembre'**
  String get monthLongSep;

  /// No description provided for @monthLongOct.
  ///
  /// In es, this message translates to:
  /// **'octubre'**
  String get monthLongOct;

  /// No description provided for @monthLongNov.
  ///
  /// In es, this message translates to:
  /// **'noviembre'**
  String get monthLongNov;

  /// No description provided for @monthLongDec.
  ///
  /// In es, this message translates to:
  /// **'diciembre'**
  String get monthLongDec;

  /// No description provided for @weekdayMonday.
  ///
  /// In es, this message translates to:
  /// **'Lunes'**
  String get weekdayMonday;

  /// No description provided for @weekdayTuesday.
  ///
  /// In es, this message translates to:
  /// **'Martes'**
  String get weekdayTuesday;

  /// No description provided for @weekdayWednesday.
  ///
  /// In es, this message translates to:
  /// **'Miércoles'**
  String get weekdayWednesday;

  /// No description provided for @weekdayThursday.
  ///
  /// In es, this message translates to:
  /// **'Jueves'**
  String get weekdayThursday;

  /// No description provided for @weekdayFriday.
  ///
  /// In es, this message translates to:
  /// **'Viernes'**
  String get weekdayFriday;

  /// No description provided for @weekdaySaturday.
  ///
  /// In es, this message translates to:
  /// **'Sábado'**
  String get weekdaySaturday;

  /// No description provided for @weekdaySunday.
  ///
  /// In es, this message translates to:
  /// **'Domingo'**
  String get weekdaySunday;

  /// No description provided for @weekdayLetterSun.
  ///
  /// In es, this message translates to:
  /// **'D'**
  String get weekdayLetterSun;

  /// No description provided for @weekdayLetterMon.
  ///
  /// In es, this message translates to:
  /// **'L'**
  String get weekdayLetterMon;

  /// No description provided for @weekdayLetterTue.
  ///
  /// In es, this message translates to:
  /// **'M'**
  String get weekdayLetterTue;

  /// No description provided for @weekdayLetterWed.
  ///
  /// In es, this message translates to:
  /// **'X'**
  String get weekdayLetterWed;

  /// No description provided for @weekdayLetterThu.
  ///
  /// In es, this message translates to:
  /// **'J'**
  String get weekdayLetterThu;

  /// No description provided for @weekdayLetterFri.
  ///
  /// In es, this message translates to:
  /// **'V'**
  String get weekdayLetterFri;

  /// No description provided for @weekdayLetterSat.
  ///
  /// In es, this message translates to:
  /// **'S'**
  String get weekdayLetterSat;

  /// No description provided for @monthCalendarJan.
  ///
  /// In es, this message translates to:
  /// **'Enero'**
  String get monthCalendarJan;

  /// No description provided for @monthCalendarFeb.
  ///
  /// In es, this message translates to:
  /// **'Febrero'**
  String get monthCalendarFeb;

  /// No description provided for @monthCalendarMar.
  ///
  /// In es, this message translates to:
  /// **'Marzo'**
  String get monthCalendarMar;

  /// No description provided for @monthCalendarApr.
  ///
  /// In es, this message translates to:
  /// **'Abril'**
  String get monthCalendarApr;

  /// No description provided for @monthCalendarMay.
  ///
  /// In es, this message translates to:
  /// **'Mayo'**
  String get monthCalendarMay;

  /// No description provided for @monthCalendarJun.
  ///
  /// In es, this message translates to:
  /// **'Junio'**
  String get monthCalendarJun;

  /// No description provided for @monthCalendarJul.
  ///
  /// In es, this message translates to:
  /// **'Julio'**
  String get monthCalendarJul;

  /// No description provided for @monthCalendarAug.
  ///
  /// In es, this message translates to:
  /// **'Agosto'**
  String get monthCalendarAug;

  /// No description provided for @monthCalendarSep.
  ///
  /// In es, this message translates to:
  /// **'Septiembre'**
  String get monthCalendarSep;

  /// No description provided for @monthCalendarOct.
  ///
  /// In es, this message translates to:
  /// **'Octubre'**
  String get monthCalendarOct;

  /// No description provided for @monthCalendarNov.
  ///
  /// In es, this message translates to:
  /// **'Noviembre'**
  String get monthCalendarNov;

  /// No description provided for @monthCalendarDec.
  ///
  /// In es, this message translates to:
  /// **'Diciembre'**
  String get monthCalendarDec;

  /// No description provided for @iconActivity.
  ///
  /// In es, this message translates to:
  /// **'Actividad'**
  String get iconActivity;

  /// No description provided for @iconExercise.
  ///
  /// In es, this message translates to:
  /// **'Ejercicio'**
  String get iconExercise;

  /// No description provided for @iconReading.
  ///
  /// In es, this message translates to:
  /// **'Lectura'**
  String get iconReading;

  /// No description provided for @iconSleep.
  ///
  /// In es, this message translates to:
  /// **'Sueño'**
  String get iconSleep;

  /// No description provided for @iconWater.
  ///
  /// In es, this message translates to:
  /// **'Agua'**
  String get iconWater;

  /// No description provided for @iconMind.
  ///
  /// In es, this message translates to:
  /// **'Mente'**
  String get iconMind;

  /// No description provided for @iconHealth.
  ///
  /// In es, this message translates to:
  /// **'Salud'**
  String get iconHealth;

  /// No description provided for @iconTime.
  ///
  /// In es, this message translates to:
  /// **'Tiempo'**
  String get iconTime;
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
    'that was used.',
  );
}
