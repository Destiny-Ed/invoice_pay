import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:invoice_pay/utils/app_locales.dart';

/// Returns a greeting based on current time:
/// Good Morning (5:00 - 11:59)
/// Good Afternoon (12:00 - 16:59)
/// Good Evening (17:00 - 20:59)
/// Good Night (21:00 - 4:59)

String getGreeting(BuildContext context) {
  final hour = DateTime.now().hour;

  if (hour >= 5 && hour < 12) {
    return AppLocale.goodMorning.getString(context);
  } else if (hour >= 12 && hour < 17) {
    return AppLocale.goodAfternoon.getString(context);
  } else if (hour >= 17 && hour < 21) {
    return AppLocale.goodEvening.getString(context);
  } else {
    return AppLocale.goodNight.getString(context);
  }
}

/// Optional: More personal with emoji
String getRichGreeting(BuildContext context) {
  final hour = DateTime.now().hour;

  if (hour >= 5 && hour < 12) {
    return '${AppLocale.goodMorning.getString(context)} ☀️';
  } else if (hour >= 12 && hour < 17) {
    return '${AppLocale.goodAfternoon.getString(context)} 🌤️';
  } else if (hour >= 17 && hour < 21) {
    return '${AppLocale.goodEvening.getString(context)} 🌅';
  } else {
    return '${AppLocale.goodNight.getString(context)}! 🌙';
  }
}
