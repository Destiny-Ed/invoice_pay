import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:invoice_pay/models/invoice_model.dart';
import 'package:invoice_pay/providers/auth_provider.dart';
import 'package:invoice_pay/providers/report_provider.dart';
import 'package:invoice_pay/widgets/busy_overlay.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import 'package:invoice_pay/styles/colors.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ReportsViewModel>(
      builder: (context, vm, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Reports'),
            actions: [
              IconButton(
                icon: const Icon(Icons.date_range),
                onPressed: () async {
                  final picked = await showDateRangePicker(
                    context: context,
                    firstDate: DateTime(2020),
                    lastDate: DateTime.now(),
                    initialDateRange: vm.dateRange,
                  );
                  if (picked != null) vm.setDateRange(picked);
                },
              ),
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {
                  final text =
                      '''
InvoicePay Report
Period: ${vm.dateRange != null ? '${DateFormat('MMM dd').format(vm.dateRange!.start)} - ${DateFormat('MMM dd, yyyy').format(vm.dateRange!.end)}' : 'All Time'}

Total Revenue: \$${NumberFormat('#,##0').format(vm.totalRevenue)}
Outstanding: \$${NumberFormat('#,##0').format(vm.outstanding)}
Overdue: \$${NumberFormat('#,##0').format(vm.overdue)}

Generated from InvoicePay
                    ''';
                  Share.share(text, subject: 'InvoicePay Report');
                },
              ),
            ],
          ),
          body: BusyOverlay(
            show: vm.viewState == ViewState.Busy,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title & Period
                  const Text(
                    'Financial Reports',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    vm.dateRange != null
                        ? '${DateFormat('MMM dd').format(vm.dateRange!.start)} - ${DateFormat('MMM dd, yyyy').format(vm.dateRange!.end)}'
                        : 'All Time',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),

                  const SizedBox(height: 32),

                  // Summary Cards
                  Row(
                    children: [
                      Expanded(
                        child: _summaryCard(
                          'Total Revenue',
                          vm.totalRevenue,
                          Icons.trending_up,
                          Colors.green,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _summaryCard(
                          'Outstanding',
                          vm.outstanding,
                          Icons.account_balance_wallet,
                          Colors.orange,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _summaryCard(
                    'Overdue',
                    vm.overdue,
                    Icons.warning_amber,
                    Colors.red,
                    isFullWidth: true,
                  ),

                  const SizedBox(height: 40),

                  // Status Filter Chips
                  const Text(
                    'Filter by Status',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10,
                    children: [
                      FilterChip(
                        label: const Text('All'),
                        selected: vm.statusFilter == null,
                        onSelected: (_) => vm.setStatusFilter(null),
                        selectedColor: primaryColor.withOpacity(0.2),
                      ),
                      ...InvoiceStatus.values.map((status) {
                        return FilterChip(
                          label: Text(_statusLabel(status)),
                          selected: vm.statusFilter == status,
                          onSelected: (_) => vm.setStatusFilter(status),
                          selectedColor: primaryColor.withOpacity(0.2),
                        );
                      }),
                    ],
                  ),

                  const SizedBox(height: 40),

                  // Revenue Chart
                  const Text(
                    'Revenue Trend',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 320,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 20,
                        ),
                      ],
                    ),
                    child: vm.monthlyRevenueSpots.isEmpty
                        ? const Center(
                            child: Text('No revenue data for selected period'),
                          )
                        : LineChart(
                            LineChartData(
                              gridData: FlGridData(show: true),
                              titlesData: FlTitlesData(
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 50,
                                  ),
                                ),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: (value, meta) {
                                      final index = value.toInt();
                                      if (index < 0 ||
                                          index >= vm.monthLabels.length)
                                        return const Text('');
                                      return Padding(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: Text(
                                          vm.monthLabels[index],
                                          style: const TextStyle(fontSize: 11),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                topTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                rightTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                              ),
                              borderData: FlBorderData(show: false),
                              lineBarsData: [
                                LineChartBarData(
                                  spots: vm.monthlyRevenueSpots,
                                  isCurved: true,
                                  color: primaryColor,
                                  barWidth: 4,
                                  dotData: FlDotData(show: true),
                                  belowBarData: BarAreaData(
                                    show: true,
                                    color: primaryColor.withOpacity(0.2),
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),

                  const SizedBox(height: 40),

                  // Top Clients
                  const Text(
                    'Top Clients',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  if (vm.topClients.isEmpty)
                    const Text('No paid invoices yet')
                  else
                    ...vm.topClients.entries.map((entry) {
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey[300],
                            child: Text(entry.key[0].toUpperCase()),
                          ),
                          title: Text(
                            entry.key,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          trailing: Text(
                            '\$${NumberFormat('#,##0').format(entry.value)}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      );
                    }),

                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _summaryCard(
    String title,
    double amount,
    IconData icon,
    Color color, {
    bool isFullWidth = false,
  }) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: isFullWidth ? double.infinity : null,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [color.withOpacity(0.8), color],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.white, size: 32),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              '\$${NumberFormat('#,##0').format(amount)}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _statusLabel(InvoiceStatus status) {
    switch (status) {
      case InvoiceStatus.paid:
        return 'Paid';
      case InvoiceStatus.overdue:
        return 'Overdue';
      case InvoiceStatus.partial:
        return 'Partial';
      case InvoiceStatus.pending:
        return 'Pending';
      case InvoiceStatus.sent:
        return 'Sent';
      case InvoiceStatus.draft:
        return 'Draft';
    }
  }
}
