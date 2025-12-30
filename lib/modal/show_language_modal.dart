import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:invoice_pay/styles/colors.dart';
import 'package:invoice_pay/utils/app_locales.dart';

void showLanguageModal(BuildContext context) {
  final localization = FlutterLocalization.instance;

  final Map<String, String> languages = {
    '': AppLocale.systemDefault.getString(context), // Empty = follow device
    'en': 'English',
    'es': 'Español',
    'pt': 'Português',
    'hi': 'हिन्दी (Hindi)',
    'fr': 'Français',
    'de': 'Deutsch',
    'id': 'Bahasa Indonesia',
  };

  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
    ),
    builder: (_) => DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      expand: false,
      builder: (_, controller) => Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
            child: Text(
              AppLocale.selectLanguage.getString(context),
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: controller,
              itemCount: languages.length,
              itemBuilder: (context, index) {
                final code = languages.keys.elementAt(index);
                final name = languages.values.elementAt(index);
                final isSelected =
                    localization.currentLocale?.languageCode == code ||
                    (code.isEmpty && localization.currentLocale == null);

                return ListTile(
                  title: Text(name),
                  trailing: isSelected
                      ? Icon(Icons.check, color: primaryColor)
                      : null,
                  onTap: () {
                    localization.translate(code); // '' = system default
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        ],
      ),
    ),
  );
}

String getCurrentLanguageName(BuildContext context) {
  final locale = FlutterLocalization.instance.currentLocale;
  if (locale == null) return AppLocale.systemDefault.getString(context);

  switch (locale.languageCode) {
    case 'en':
      return 'English';
    case 'es':
      return 'Español';
    case 'pt':
      return 'Português';
    case 'hi':
      return 'हिन्दी (Hindi)';
    case 'fr':
      return 'Français';
    case 'de':
      return 'Deutsch';
    case 'id':
      return 'Bahasa Indonesia';
    default:
      return locale.languageCode;
  }
}
