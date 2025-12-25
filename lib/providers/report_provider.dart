import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:invoice_pay/models/client_model.dart';
import 'package:invoice_pay/models/invoice_model.dart';
import 'package:invoice_pay/providers/base_provider.dart';
import 'package:invoice_pay/providers/invoice_provider.dart';
import 'package:invoice_pay/providers/client_provider.dart';
import 'package:invoice_pay/styles/colors.dart';

class ReportsViewModel extends BaseViewModel {
  final InvoiceProvider _invoiceProvider;
  final ClientProvider _clientProvider;

  ReportsViewModel(this._invoiceProvider, this._clientProvider) {
    // loadData();
  }

  DateTimeRange? _dateRange;
  DateTimeRange? get dateRange => _dateRange;

  InvoiceStatus? _statusFilter;
  InvoiceStatus? get statusFilter => _statusFilter;

  List<InvoiceModel> get filteredInvoices {
    var list = _invoiceProvider.invoices;

    if (_statusFilter != null) {
      list = list.where((inv) => inv.status == _statusFilter).toList();
    }

    if (_dateRange != null) {
      list = list.where((inv) {
        return inv.issued.isAfter(
              _dateRange!.start.subtract(const Duration(days: 1)),
            ) &&
            inv.issued.isBefore(_dateRange!.end.add(const Duration(days: 1)));
      }).toList();
    }

    return list;
  }

  // Summary Stats
  double get totalRevenue =>
      filteredInvoices.fold(0.0, (sum, inv) => sum + inv.paidAmount);
  double get outstanding =>
      filteredInvoices.fold(0.0, (sum, inv) => sum + inv.balanceDue);
  double get overdue => filteredInvoices
      .where((inv) => inv.isOverdue)
      .fold(0.0, (sum, inv) => sum + inv.balanceDue);

  // Chart Data - Monthly Revenue
  List<FlSpot> get monthlyRevenueSpots {
    final Map<String, double> monthly = {};
    for (var inv in filteredInvoices.where(
      (inv) => inv.status == InvoiceStatus.paid,
    )) {
      final monthKey = DateFormat('MMM yyyy').format(inv.issued);
      monthly[monthKey] = (monthly[monthKey] ?? 0) + inv.paidAmount;
    }

    final sortedKeys = monthly.keys.toList()..sort();
    return sortedKeys.asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), monthly[entry.value]!);
    }).toList();
  }

  List<String> get monthLabels {
    final Map<String, double> monthly = {};
    for (var inv in filteredInvoices.where(
      (inv) => inv.status == InvoiceStatus.paid,
    )) {
      final monthKey = DateFormat('MMM yyyy').format(inv.issued);
      monthly[monthKey] = (monthly[monthKey] ?? 0) + inv.paidAmount;
    }
    return monthly.keys.toList()..sort();
  }

  // Top Clients
  Map<String, double> get topClients {
    final Map<String, double> clientRevenue = {};
    for (var inv in filteredInvoices.where(
      (inv) => inv.status == InvoiceStatus.paid,
    )) {
      final client = _clientProvider.clients.firstWhere(
        (c) => c.id == inv.clientId,
        orElse: () => ClientModel(
          id: '',
          companyName: 'Unknown',
          contactName: '',
          email: '',
          phone: '',
          statusTag: '',
          statusColor: primaryColor,
          actionIcon: Icons.drafts,
        ),
      );
      final name = client.contactName.isEmpty
          ? client.companyName
          : client.contactName;
      clientRevenue[name] = (clientRevenue[name] ?? 0) + inv.paidAmount;
    }

    // Sort and take top 5
    final sorted = clientRevenue.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return Map.fromEntries(sorted.take(5));
  }

  Future<void> loadData() async {
    await _invoiceProvider.loadInvoices();
    await _clientProvider.loadClients();
  }

  void setDateRange(DateTimeRange range) {
    _dateRange = range;
    notifyListeners();
  }

  void setStatusFilter(InvoiceStatus? status) {
    _statusFilter = status;
    notifyListeners();
  }

  void clearFilters() {
    _dateRange = null;
    _statusFilter = null;
    notifyListeners();
  }
}
