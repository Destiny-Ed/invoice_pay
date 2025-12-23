import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:invoice_pay/models/invoice_model.dart';
import 'package:invoice_pay/providers/auth_provider.dart';
import 'package:invoice_pay/providers/report_provider.dart';
import 'package:invoice_pay/screens/reports/widgets/custom_widgets.dart';
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
        final isSmallScreen = MediaQuery.of(context).size.width < 600;
        return Scaffold(
          backgroundColor: Colors.grey[50],
          appBar: AppBar(
            title: const Text(
              'Financial Overview',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0,
            actions: [
              IconButton(
                icon: const Icon(Icons.date_range_outlined),
                onPressed: () async {
                  final picked = await showDateRangePicker(
                    context: context,
                    firstDate: DateTime(2020),
                    lastDate: DateTime.now(),
                    initialDateRange: vm.dateRange,
                    builder: (context, child) => Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: Theme.of(
                          context,
                        ).colorScheme.copyWith(primary: primaryColor),
                      ),
                      child: child!,
                    ),
                  );
                  if (picked != null) vm.setDateRange(picked);
                },
              ),
              IconButton(
                icon: const Icon(Icons.share_outlined),
                onPressed: () {
                  final period = vm.dateRange != null
                      ? '${DateFormat('MMM dd').format(vm.dateRange!.start)} - ${DateFormat('MMM dd, yyyy').format(vm.dateRange!.end)}'
                      : 'All Time';

                  final text =
                      '''
📊 InvoicePay Financial Report

📅 Period: $period
💰 Total Revenue: \$${NumberFormat('#,##0').format(vm.totalRevenue)}
⚠️ Outstanding: \$${NumberFormat('#,##0').format(vm.outstanding)}
🔴 Overdue: \$${NumberFormat('#,##0').format(vm.overdue)}

Generated with ❤️ by InvoicePay
                  ''';
                  Share.share(text, subject: 'InvoicePay Report - $period');
                },
              ),
            ],
          ),
          body: BusyOverlay(
            show: vm.viewState == ViewState.Busy,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Text(
                    vm.dateRange != null
                        ? '${DateFormat('MMMM dd').format(vm.dateRange!.start)} – ${DateFormat('MMMM dd, yyyy').format(vm.dateRange!.end)}'
                        : 'All Time',
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                  ),

                  const SizedBox(height: 20),

                  // Summary Cards
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: isSmallScreen ? 1 : 2,
                    childAspectRatio: isSmallScreen ? 3.5 : 3,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: [
                      summaryCard(
                        'Total Revenue',
                        vm.totalRevenue,
                        Icons.trending_up,
                        Colors.green,
                      ),
                      summaryCard(
                        'Outstanding',
                        vm.outstanding,
                        Icons.account_balance_wallet,
                        Colors.orange,
                      ),
                      summaryCard(
                        'Overdue',
                        vm.overdue,
                        Icons.warning_amber,
                        Colors.red,
                        isFullWidth: true,
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Status Filter
                  // const Text(
                  //   'Filter by Status',
                  //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  // ),
                  // const SizedBox(height: 16),
                  // Wrap(
                  //   spacing: 12,
                  //   runSpacing: 12,
                  //   children: [
                  //     filterChip(
                  //       'All',
                  //       vm.statusFilter == null,
                  //       () => vm.setStatusFilter(null),
                  //     ),
                  //     ...InvoiceStatus.values.map(
                  //       (status) => filterChip(
                  //         _statusLabel(status),
                  //         vm.statusFilter == status,
                  //         () => vm.setStatusFilter(status),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(height: 20),

                  // Revenue Trend Chart
                  const Text(
                    'Revenue Trend',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 360,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: vm.monthlyRevenueSpots.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.bar_chart,
                                  size: 60,
                                  color: Colors.grey[400],
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'No revenue data',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                Text(
                                  'Complete some invoices to see trends',
                                  style: TextStyle(color: Colors.grey[500]),
                                ),
                              ],
                            ),
                          )
                        : LineChart(
                            LineChartData(
                              gridData: FlGridData(
                                show: true,
                                drawVerticalLine: true,
                                horizontalInterval: null,
                                verticalInterval: null,
                                getDrawingHorizontalLine: (value) => FlLine(
                                  color: Colors.grey[200]!,
                                  strokeWidth: 1,
                                ),
                                getDrawingVerticalLine: (value) => FlLine(
                                  color: Colors.grey[200]!,
                                  strokeWidth: 1,
                                ),
                              ),
                              titlesData: FlTitlesData(
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 60,
                                    getTitlesWidget: (value, meta) => Text(
                                      '\$${value.toInt()}',
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    interval: 1,
                                    getTitlesWidget: (value, meta) {
                                      final index = value.toInt();
                                      if (index < 0 ||
                                          index >= vm.monthLabels.length) {
                                        return const Text('');
                                      }
                                      return Padding(
                                        padding: const EdgeInsets.only(top: 12),
                                        child: Text(
                                          vm.monthLabels[index],
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                topTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                rightTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                              ),
                              borderData: FlBorderData(show: false),
                              minX: 0,
                              maxX: (vm.monthLabels.length - 1).toDouble(),
                              minY: 0,
                              lineBarsData: [
                                LineChartBarData(
                                  spots: vm.monthlyRevenueSpots,
                                  isCurved: true,
                                  color: primaryColor,
                                  barWidth: 5,
                                  isStrokeCapRound: true,
                                  dotData: FlDotData(
                                    show: true,
                                    getDotPainter:
                                        (spot, percent, bar, index) =>
                                            FlDotCirclePainter(
                                              radius: 6,
                                              color: Colors.white,
                                              strokeWidth: 3,
                                              strokeColor: primaryColor,
                                            ),
                                  ),
                                  belowBarData: BarAreaData(
                                    show: true,
                                    color: primaryColor.withOpacity(0.15),
                                  ),
                                ),
                              ],
                              lineTouchData: LineTouchData(
                                touchTooltipData: LineTouchTooltipData(
                                  getTooltipColor: (touchedSpot) =>
                                      Colors.black87,
                                  getTooltipItems: (touchedSpots) {
                                    return touchedSpots.map((spot) {
                                      return LineTooltipItem(
                                        '\$${spot.y.toStringAsFixed(0)}',
                                        const TextStyle(
                                          color: greyColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      );
                                    }).toList();
                                  },
                                ),
                              ),
                            ),
                          ),
                  ),

                  const SizedBox(height: 20),

                  // Top Clients
                  const Text(
                    'Top Clients',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  if (vm.topClients.isEmpty)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child: Column(
                          children: [
                            Icon(
                              Icons.people_outline,
                              size: 60,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No client data yet',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    ...vm.topClients.entries.map((entry) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 12,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 28,
                              backgroundColor: primaryColor.withOpacity(0.1),
                              child: Text(
                                entry.key[0].toUpperCase(),
                                style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                entry.key,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Text(
                              '\$${NumberFormat('#,##0').format(entry.value)}',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
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
