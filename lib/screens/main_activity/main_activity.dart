import 'package:flutter/material.dart';
import 'package:invoice_pay/screens/clients/client_screen.dart';
import 'package:invoice_pay/screens/dashboard/dashboard.dart';
import 'package:invoice_pay/screens/invoice/invoice_screen.dart';
import 'package:invoice_pay/screens/reports/report_screen.dart';
import 'package:invoice_pay/styles/colors.dart';

class MainActivity extends StatefulWidget {
  const MainActivity({super.key});

  @override
  State<MainActivity> createState() => _MainActivityState();
}

class _MainActivityState extends State<MainActivity> {
  int _currentIndex = 0;

  List<Widget> pages = [
    DashboardScreen(),
    ClientsScreen(),
    InvoicesScreen(),
    ReportsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Clients'),
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
          // Navigation logic
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
