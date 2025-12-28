import 'package:flutter/material.dart';
import 'package:invoice_pay/providers/client_provider.dart';
import 'package:invoice_pay/providers/main_activity_provider.dart';
import 'package:invoice_pay/screens/clients/client_screen.dart';
import 'package:invoice_pay/screens/dashboard/dashboard.dart';
import 'package:invoice_pay/screens/invoice/invoice_screen.dart';
import 'package:invoice_pay/screens/reports/report_screen.dart';
import 'package:invoice_pay/styles/colors.dart';
import 'package:provider/provider.dart';
import 'package:upgrader/upgrader.dart';

class MainActivity extends StatefulWidget {
  const MainActivity({super.key});

  @override
  State<MainActivity> createState() => _MainActivityState();
}

class _MainActivityState extends State<MainActivity> {
  List<Widget> pages = [
    DashboardScreen(),
    ClientsScreen(),
    InvoicesScreen(),
    ReportsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    // Fetch invoices and clients on screen load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ClientProvider>().loadClients();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainActivityProvider>(
      builder: (context, model, child) {
        return UpgradeAlert(
          child: Scaffold(
            body: pages[model.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: primaryColor,
              unselectedItemColor: Colors.grey,
              currentIndex: model.currentIndex,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                  icon: Icon(Icons.people),
                  label: 'Clients',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.receipt_long),
                  label: 'Invoices',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.bar_chart),
                  label: 'Reports',
                ),
              ],
              onTap: (index) {
                model.currentIndex = index;
              },
            ),
          ),
        );
      },
    );
  }
}
