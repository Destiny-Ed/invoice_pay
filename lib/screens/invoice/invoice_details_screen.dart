import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:invoice_pay/models/invoice_item_model.dart';
import 'package:invoice_pay/styles/colors.dart';
import 'package:provider/provider.dart';
import 'package:invoice_pay/models/invoice_model.dart';
import 'package:invoice_pay/models/client_model.dart';
import 'package:invoice_pay/providers/client_provider.dart';

class InvoiceDetailScreen extends StatelessWidget {
  final InvoiceModel invoice;

  const InvoiceDetailScreen({super.key, required this.invoice});

  @override
  Widget build(BuildContext context) {
    final clientProvider = Provider.of<ClientProvider>(context);
    final ClientModel? client = clientProvider.clients.firstWhere(
      (c) => c.id == invoice.clientId,
      orElse: () => ClientModel(
        id: '',
        companyName: 'Unknown Client',
        contactName: '',
        email: '',
        phone: '',
        statusTag: "",
        statusColor: Colors.blue,
        actionIcon: Icons.cleaning_services,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Invoice #${invoice.number}'),
        actions: [
          TextButton(
            onPressed: () {
              // Edit invoice logic
            },
            child: const Text('Edit', style: TextStyle(color: primaryColor)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Overdue Badge
            if (invoice.isOverdue)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Text(
                  'Overdue',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            const SizedBox(height: 12),

            // Balance Due
            Text(
              '\$${NumberFormat('#,###.00').format(invoice.balanceDue)}',
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            Text(
              'Due ${DateFormat('MMM dd, yyyy').format(invoice.due)}',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),

            const SizedBox(height: 32),

            // Action Chips
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _actionChip(
                  icon: Icons.notifications,
                  label: 'Remind',
                  onTap: () {
                    // Send reminder
                  },
                ),
                _actionChip(
                  icon: Icons.percent,
                  label: 'Late Fee',
                  onTap: () {
                    // Add late fee
                  },
                ),
                _actionChip(
                  icon: Icons.preview,
                  label: 'Preview',
                  onTap: () {
                    // Show PDF preview
                  },
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Billed To
            const Text(
              'BILLED TO',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: primaryColor.withOpacity(0.2),
                child: Text(
                  client!.companyName.isNotEmpty
                      ? client.companyName[0].toUpperCase()
                      : '?',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(client.companyName),
              subtitle: Text(client.email),
              trailing: IconButton(
                icon: const Icon(Icons.arrow_forward_ios, size: 16),
                onPressed: () {
                  // Navigate to client detail
                },
              ),
            ),

            const SizedBox(height: 32),

            // Dates
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _dateColumn('Issued Date', invoice.issued),
                _dateColumn('Due Date', invoice.due, isDue: true),
              ],
            ),

            const SizedBox(height: 32),

            // Services
            const Text(
              'Services',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...invoice.items.map((item) => _serviceItem(item)).toList(),

            const SizedBox(height: 32),

            // Summary
            const Text(
              'Summary',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _summaryRow('Subtotal', invoice.subtotal),
            _summaryRow(
              'Tax (${invoice.taxPercent.toStringAsFixed(0)}%)',
              invoice.taxAmount,
            ),
            _summaryRow(
              'Discount (${invoice.discountPercent.toStringAsFixed(0)}%)',
              -invoice.discountAmount,
            ),
            const Divider(height: 40, thickness: 1),
            _summaryRow('Total', invoice.total, isBold: true),

            const SizedBox(height: 40),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // Export PDF
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      side: const BorderSide(color: Colors.grey),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text('Export PDF'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Resend invoice
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Resend Invoice',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),

            // Activity Log (Example)
            _activityItem(
              'Partial Payment',
              'Oct 26, 10:00 AM • +\$500.00',
              primaryColor,
            ),
            _activityItem('Invoice Viewed', 'Oct 25, 9:12 AM', Colors.blue),
            _activityItem('Invoice Sent', 'Oct 24, 2:30 PM', Colors.grey),

            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _actionChip({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 20, color: Colors.grey[700]),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  Widget _dateColumn(String label, DateTime date, {bool isDue = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 4),
        Text(
          DateFormat('MMM dd, yyyy').format(date),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isDue
                ? (invoice.isOverdue ? Colors.red : Colors.black)
                : Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _serviceItem(InvoiceItemModel item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.description,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${item.qty} hrs × \$${item.rate.toStringAsFixed(2)}',
                style: TextStyle(color: Colors.grey[600]),
              ),
              Text(
                '\$${item.amount.toStringAsFixed(2)}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, double value, {bool isBold = false}) {
    final bool isNegative = value < 0;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: 16,
            ),
          ),
          Text(
            '${isNegative ? '-' : ''}\$${NumberFormat('#,###.00').format(value.abs())}',
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _activityItem(String title, String subtitle, Color color) {
    return ListTile(
      leading: CircleAvatar(radius: 8, backgroundColor: color),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle, style: TextStyle(color: Colors.grey[600])),
    );
  }
}
