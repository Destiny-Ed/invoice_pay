import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:invoice_pay/providers/auth_provider.dart';
import 'package:invoice_pay/providers/client_provider.dart';
import 'package:invoice_pay/providers/company_provider.dart';
import 'package:invoice_pay/providers/invoice_provider.dart';
import 'package:invoice_pay/providers/main_activity_provider.dart';
import 'package:invoice_pay/providers/report_provider.dart';
import 'package:invoice_pay/providers/settings_provider.dart';
import 'package:invoice_pay/screens/onboarding/splash.dart';
import 'package:invoice_pay/styles/colors.dart';
import 'package:invoice_pay/utils/app_version.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await AppVersion.init();
  runApp(
    MultiProvider(
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
    ),
  );
}
