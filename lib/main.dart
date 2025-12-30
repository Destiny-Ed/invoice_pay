import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:invoice_pay/firebase_options.dart';
import 'package:invoice_pay/providers/auth_provider.dart';
import 'package:invoice_pay/providers/client_provider.dart';
import 'package:invoice_pay/providers/company_provider.dart';
import 'package:invoice_pay/providers/invoice_provider.dart';
import 'package:invoice_pay/providers/main_activity_provider.dart';
import 'package:invoice_pay/providers/report_provider.dart';
import 'package:invoice_pay/providers/settings_provider.dart';
import 'package:invoice_pay/screens/onboarding/splash.dart';
import 'package:invoice_pay/styles/colors.dart';
import 'package:invoice_pay/utils/app_locales.dart';
import 'package:invoice_pay/utils/app_version.dart';
import 'package:provider/provider.dart';

void main() {
  runZonedGuarded<Future<void>>(() async {
    _initApp();
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
}

void _initApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterLocalization.instance.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  await AppVersion.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    localization.init(
      mapLocales: const [
        MapLocale('en', AppLocale.EN), // English
        MapLocale('es', AppLocale.ES), // Spanish
        MapLocale('pt', AppLocale.PT), // Portuguese
        MapLocale('hi', AppLocale.HI), // Hindi
        MapLocale('fr', AppLocale.FR), // French
        MapLocale('de', AppLocale.DE), // German
        MapLocale('id', AppLocale.ID), // Indonesian
      ],
      initLanguageCode: 'en',
    );
    localization.onTranslatedLanguage = _onTranslatedLanguage;
  }

  // the setState function here is a must to add
  void _onTranslatedLanguage(Locale? locale) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ClientProvider()),
        ChangeNotifierProvider(create: (_) => InvoiceProvider()),
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
        ChangeNotifierProvider(create: (_) => AuthenticationProviderImpl()),
        ChangeNotifierProvider(create: (_) => CompanyProvider()),
        ChangeNotifierProvider(create: (_) => MainActivityProvider()),

        // ViewModels depend on raw providers — create after them
        ChangeNotifierProxyProvider2<
          InvoiceProvider,
          ClientProvider,
          ReportsViewModel
        >(
          create: (_) => ReportsViewModel(
            InvoiceProvider(), // Will be updated below
            ClientProvider(),
          ),
          update: (_, invoiceProvider, clientProvider, previous) =>
              ReportsViewModel(invoiceProvider, clientProvider),
        ),

        // Add other ViewModels similarly
        // ChangeNotifierProxyProvider<InvoiceProvider, InvoicesViewModel>(
        //   create: (_) => InvoicesViewModel(InvoiceProvider()),
        //   update: (_, invoiceProvider, previous) => InvoicesViewModel(invoiceProvider),
        // ),
      ],
      child: MaterialApp(
        title: 'Invoice Pay',
        debugShowCheckedModeBanner: false,
        supportedLocales: localization.supportedLocales,
        localizationsDelegates: localization.localizationsDelegates,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.blue,
          ).copyWith(secondary: primaryColor),
        ),
        home: Builder(
          builder: (context) {
            final MediaQueryData data = MediaQuery.of(context);

            return MediaQuery(
              data: data.copyWith(
                textScaler: TextScaler.linear(
                  data.textScaleFactor.clamp(0.85, 0.90),
                ),
              ),
              child: SplashScreen(),
            );
          },
        ),
      ),
    );
  }
}
