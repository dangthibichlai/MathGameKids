import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

const String notificationChannelId = 'ff247_channel';
const String FCM_TOPIC_DEFAULT = 'fcm_all';
const String NOTIFICATION_KEY = 'notification_key';
const String NOTIFICATION_TITLE = 'title';
const String NOTIFICATION_BODY = 'body';

Locale localeResolutionCallback(Locale? locale, Iterable<Locale> supportedLocales) {
  if (locale == null) {
    return supportedLocales.first;
  }
  for (final supportedLocale in supportedLocales) {
    if (supportedLocale.languageCode == locale.languageCode) {
      return supportedLocale;
    }
  }
  return supportedLocales.first;
}

List<LocalizationsDelegate> localizationsDelegates = [
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
  DefaultCupertinoLocalizations.delegate,
];

const String PasswordAppStore = 'e2a68251d00248f3a60766c922ddb55a';

const String FeaturesToolCollection = 'Featured';
