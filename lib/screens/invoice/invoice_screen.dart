import 'package:flutter/material.dart';
import 'package:flutter_utilities/flutter_utilities.dart';
import 'package:intl/intl.dart';
import 'package:invoice_pay/config/extension.dart';
import 'package:invoice_pay/screens/invoice/create_invoice_screen.dart';
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
  InvoiceStatus? _selectedStatus;
  DateTime? _startDate;
  DateTime? _endDate;
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<InvoiceProvider>();
    final filteredInvoices = provider.invoices.where((inv) {
      // Status filter
      if (_selectedStatus != null && inv.status != _selectedStatus) {
        return false;
      }

      // Date range filter
      if (_startDate != null && inv.due.isBefore(_startDate!)) return false;
      if (_endDate != null && inv.due.isAfter(_endDate!)) return false;

      // Search by client or number
      if (_searchQuery.isNotEmpty) {
        final lowerQuery = _searchQuery.toLowerCase();
        if (!inv.number.toLowerCase().contains(lowerQuery) &&
            !inv.getClientName(context).toLowerCase().contains(lowerQuery)) {
          return false;
        }
      }

      return true;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoices'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
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
          // Filters Section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Search
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search by number or client...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() => _searchQuery = value);
                  },
                ),

                const SizedBox(height: 16),

                // Status Dropdown
                DropdownButtonFormField<InvoiceStatus>(
                  value: _selectedStatus,
                  hint: const Text('Filter by Status'),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  items: InvoiceStatus.values.map((status) {
                    return DropdownMenuItem(
                      value: status,
                      child: Text(status.name.capitalize()),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() => _selectedStatus = value);
                  },
                ),

                const SizedBox(height: 16),

                // Date Range
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: _startDate ?? DateTime.now(),
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2030),
                          );
                          if (date != null) setState(() => _startDate = date);
                        },
                        child: AbsorbPointer(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Start Date',
                              suffixIcon: const Icon(Icons.calendar_today),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            controller: TextEditingController(
                              text: _startDate != null
                                  ? DateFormat(
                                      'MMM dd, yyyy',
                                    ).format(_startDate!)
                                  : '',
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: _endDate ?? DateTime.now(),
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2030),
                          );
                          if (date != null) setState(() => _endDate = date);
                        },
                        child: AbsorbPointer(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'End Date',
                              suffixIcon: const Icon(Icons.calendar_today),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            controller: TextEditingController(
                              text: _endDate != null
                                  ? DateFormat('MMM dd, yyyy').format(_endDate!)
                                  : '',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Invoices List
          Expanded(
            child: filteredInvoices.isEmpty
                ? const Center(child: Text('No invoices match your filters'))
                : ListView.builder(
                    itemCount: filteredInvoices.length,
                    itemBuilder: (context, index) {
                      return InvoiceCard(invoice: filteredInvoices[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
