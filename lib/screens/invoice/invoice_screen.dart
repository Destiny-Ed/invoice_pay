import 'package:flutter/material.dart';
import 'package:flutter_utilities/flutter_utilities.dart';
import 'package:intl/intl.dart';
import 'package:invoice_pay/providers/auth_provider.dart';
import 'package:invoice_pay/screens/invoice/create_invoice_screen.dart';
import 'package:invoice_pay/screens/invoice/wigets/custom_widgets.dart';
import 'package:invoice_pay/widgets/busy_overlay.dart';
import 'package:provider/provider.dart';
import 'package:invoice_pay/models/invoice_model.dart';
import 'package:invoice_pay/providers/invoice_provider.dart';
import 'package:invoice_pay/widgets/invoice_card.dart';

class InvoicesScreen extends StatefulWidget {
  const InvoicesScreen({super.key});

  @override
  State<InvoicesScreen> createState() => _InvoicesScreenState();
}

class _InvoicesScreenState extends State<InvoicesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<InvoiceProvider>().loadInvoices();
  }

  @override
  Widget build(BuildContext context) {
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
      body: Consumer<InvoiceProvider>(
        builder: (context, invoiceProvider, child) {
          return Column(
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
                        filterChip(
                          'All',
                          invoiceProvider.listSelectedStatus == null,
                          () => invoiceProvider.setListStatusFilter(null),
                        ),
                        ...InvoiceStatus.values.map(
                          (status) => filterChip(
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
                          child: dateButton(
                            'From',
                            invoiceProvider.listStartDate,
                            () async {
                              final picked = await showDatePicker(
                                context: context,
                                initialDate:
                                    invoiceProvider.listStartDate ??
                                    DateTime.now(),
                                firstDate: DateTime(2020),
                                lastDate: DateTime(2030),
                              );
                              invoiceProvider.setListStartDate(picked);
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: dateButton(
                            'To',
                            invoiceProvider.listEndDate,
                            () async {
                              final picked = await showDatePicker(
                                context: context,
                                initialDate:
                                    invoiceProvider.listEndDate ??
                                    DateTime.now(),
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
                    ? const BusyOverlay(
                        show: true,
                        child: SizedBox(height: double.infinity),
                      )
                    : invoiceProvider.filteredInvoices(context).isEmpty
                    ? emptyState()
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: invoiceProvider
                            .filteredInvoices(context)
                            .length,
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
          );
        },
      ),
    );
  }
}
