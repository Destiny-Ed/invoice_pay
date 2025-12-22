import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:invoice_pay/providers/client_provider.dart';
import 'package:invoice_pay/providers/invoice_provider.dart';
import 'package:invoice_pay/screens/invoice/create_invoice_screen.dart';
import 'package:invoice_pay/screens/invoice/payment_reminder_screen.dart';
import 'package:invoice_pay/screens/settings/settings_screen.dart';
import 'package:invoice_pay/styles/colors.dart';
import 'package:invoice_pay/widgets/invoice_card.dart';
import 'package:invoice_pay/widgets/stats_card.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final invoiceProvider = context.watch<InvoiceProvider>();
    final clientProvider = context.watch<ClientProvider>();

    final totalRevenue = invoiceProvider.invoices.fold(
      0.0,
      (sum, inv) => sum + inv.paidAmount,
    );
    final outstanding = invoiceProvider.invoices.fold(
      0.0,
      (sum, inv) => sum + inv.balanceDue,
    );
    final overdueCount = invoiceProvider.invoices
        .where((inv) => inv.isOverdue)
        .length;
    final totalInvoices = invoiceProvider.invoices.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting
            Text(
              'Good morning!',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const Text(
              'Here\'s your overview',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            // Total Revenue Card
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: primaryColor,
                  // gradient: LinearGradient(
                  //   colors: [
                  //     primaryColor.withOpacity(0.2),
                  //     primaryColor.withOpacity(0.1),
                  //   ],
                  //   begin: Alignment.topLeft,
                  //   end: Alignment.bottomRight,
                  // ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Revenue',
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            '+12%',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '\$${NumberFormat('#,##0').format(totalRevenue)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    LinearProgressIndicator(
                      value: 0.75,
                      backgroundColor: Colors.white.withOpacity(0.3),
                      color: Colors.white,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Target: \$15,000 / month',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Stats Row
            Row(
              children: [
                Expanded(
                  child: statCard(
                    title: 'Outstanding',
                    amount: outstanding,
                    count: totalInvoices,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: statCard(
                    title: 'Overdue',
                    amount: invoiceProvider.invoices
                        .where((i) => i.isOverdue)
                        .fold(0.0, (sum, i) => sum + i.balanceDue),
                    count: overdueCount,
                    color: Colors.red,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Recent Activity
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent Activity',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentRemindersScreen(),
                      ),
                    );
                  },
                  child: const Text('See All'),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Recent Invoices List
            if (invoiceProvider.invoices.isEmpty)
              const Center(
                child: Text('No invoices yet. Create your first one!'),
              )
            else
              ...invoiceProvider.invoices
                  .take(5)
                  .map((invoice) => InvoiceCard(invoice: invoice)),

            const SizedBox(height: 100),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewInvoiceScreen()),
          );
        },
        child: const Icon(Icons.add, size: 32),
      ),
      
    );
  }
}
