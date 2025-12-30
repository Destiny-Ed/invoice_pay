import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:intl/intl.dart';
import 'package:invoice_pay/providers/client_provider.dart';
import 'package:invoice_pay/providers/company_provider.dart';
import 'package:invoice_pay/providers/invoice_provider.dart';
import 'package:invoice_pay/providers/main_activity_provider.dart';
import 'package:invoice_pay/screens/invoice/create_invoice_screen.dart';
import 'package:invoice_pay/screens/invoice/wigets/custom_widgets.dart';
import 'package:invoice_pay/screens/settings/settings_screen.dart';
import 'package:invoice_pay/styles/colors.dart';
import 'package:invoice_pay/utils/app_locales.dart';
import 'package:invoice_pay/utils/greetings.dart';
import 'package:invoice_pay/widgets/invoice_card.dart';
import 'package:invoice_pay/widgets/stats_card.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch invoices and clients on screen load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<InvoiceProvider>().loadInvoices();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocale.dashboard.getString(context)),
        actions: [
          // IconButton(
          //   icon: const Icon(Icons.notifications_outlined),
          //   onPressed: () {},
          // ),
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
      body: Consumer2<InvoiceProvider, CompanyProvider>(
        builder: (context, invoiceProvider, companyProvider, child) {
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

          final goal = companyProvider.company?.monthlyGoal ?? 15000.0;
          final progress = totalRevenue / goal;
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Greeting
                Text(
                  getRichGreeting(),
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                Text(
                  AppLocale.heresYourOverview.getString(context),
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
                            Text(
                              AppLocale.totalRevenue.getString(context),
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                              ),
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
                              child: Text(
                                '+${(progress * 100).toStringAsFixed(0)}%',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '${companyProvider.company?.currencySymbol ?? '\$'}${NumberFormat('#,##0').format(totalRevenue)}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        LinearProgressIndicator(
                          value: progress.clamp(0.0, 1.0),
                          backgroundColor: Colors.white.withOpacity(0.3),
                          color: Colors.white,
                        ),
                        const SizedBox(height: 8),

                        Text(
                          'Target: ${companyProvider.company?.currencySymbol ?? '\$'}${NumberFormat('#,##0').format(goal)} / month • ${(progress * 100).toStringAsFixed(0)}% achieved',
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
                        context,
                        title: AppLocale.outstanding.getString(context),
                        amount: outstanding,
                        count: totalInvoices,
                        color: Colors.orange,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: statCard(
                        context,
                        title: AppLocale.overdue.getString(context),
                        amount: invoiceProvider.invoices
                            .where((i) => i.isOverdue)
                            .fold(0.0, (sum, i) => sum + i.balanceDue),
                        count: overdueCount,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Recent Activity
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocale.recentActivity.getString(context),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        context.read<MainActivityProvider>().currentIndex = 2;
                      },
                      child: Text(AppLocale.seeAll.getString(context)),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Recent Invoices List
                if (invoiceProvider.invoices.isEmpty)
                  emptyState(
                    AppLocale.noInvoices.getString(context),
                    AppLocale.createFirstInvoice.getString(context),
                  )
                else
                  ...invoiceProvider.invoices
                      .take(5)
                      .map((invoice) => InvoiceCard(invoice: invoice)),

                const SizedBox(height: 80),
              ],
            ),
          );
        },
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
