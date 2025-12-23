import 'package:flutter/material.dart';
import 'package:flutter_utilities/flutter_utilities.dart';
import 'package:intl/intl.dart';
import 'package:invoice_pay/providers/auth_provider.dart';
import 'package:invoice_pay/screens/invoice/create_invoice_screen.dart';
import 'package:provider/provider.dart';
import 'package:invoice_pay/models/invoice_model.dart';
import 'package:invoice_pay/providers/invoice_provider.dart';
import 'package:invoice_pay/widgets/invoice_card.dart';
import 'package:invoice_pay/styles/colors.dart';

class InvoicesScreen extends StatefulWidget {
  const InvoicesScreen({super.key});

  @override
  State<InvoicesScreen> createState() => _InvoicesScreenState();
}

class _InvoicesScreenState extends State<InvoicesScreen> {
  @override
  initState() {
    super.initState();
    context.read<InvoiceProvider>().loadInvoices();
  }

  @override
  Widget build(BuildContext context) {
    final invoiceProvider = context.read<InvoiceProvider>();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Invoices'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewInvoiceScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Filters Card
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                ),
              ],
            ),
            child: Column(
              children: [
                // Search
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search invoices...',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.grey[50],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: invoiceProvider.setListSearchQuery,
                ),

                const SizedBox(height: 20),

                // Status Chips
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    _filterChip(
                      'All',
                      invoiceProvider.listSelectedStatus == null,
                      () => invoiceProvider.setListStatusFilter(null),
                    ),
                    ...InvoiceStatus.values.map(
                      (status) => _filterChip(
                        status.name.capitalize(),
                        invoiceProvider.listSelectedStatus == status,
                        () => invoiceProvider.setListStatusFilter(status),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Date Range
                Row(
                  children: [
                    Expanded(
                      child: _dateButton(
                        'From',
                        invoiceProvider.listStartDate,
                        () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate:
                                invoiceProvider.listStartDate ?? DateTime.now(),
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2030),
                          );
                          invoiceProvider.setListStartDate(picked);
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _dateButton(
                        'To',
                        invoiceProvider.listEndDate,
                        () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate:
                                invoiceProvider.listEndDate ?? DateTime.now(),
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2030),
                          );
                          invoiceProvider.setListEndDate(picked);
                        },
                      ),
                    ),
                    if (invoiceProvider.listStartDate != null ||
                        invoiceProvider.listEndDate != null)
                      IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: invoiceProvider.clearListFilters,
                      ),
                  ],
                ),
              ],
            ),
          ),

          // List
          Expanded(
            child: invoiceProvider.viewState == ViewState.Busy
                ? const Center(child: CircularProgressIndicator())
                : invoiceProvider.filteredInvoices(context).isEmpty
                ? _emptyState()
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: invoiceProvider.filteredInvoices(context).length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: InvoiceCard(
                          invoice: invoiceProvider.filteredInvoices(
                            context,
                          )[index],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _emptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.receipt_long_outlined, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          const Text(
            'No invoices',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Create your first invoice to get started',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _filterChip(String label, bool selected, VoidCallback onTap) {
    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onTap(),
      selectedColor: primaryColor.withOpacity(0.2),
      checkmarkColor: primaryColor,
      backgroundColor: Colors.grey[100],
      labelStyle: TextStyle(
        color: selected ? primaryColor : Colors.grey[700],
        fontWeight: selected ? FontWeight.bold : FontWeight.normal,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    );
  }

  Widget _dateButton(String label, DateTime? date, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          children: [
            Icon(Icons.calendar_today, color: Colors.grey[600]),
            const SizedBox(width: 12),
            Text(
              date == null ? label : DateFormat('dd MMM yyyy').format(date),
              style: TextStyle(
                fontWeight: date == null ? FontWeight.normal : FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
