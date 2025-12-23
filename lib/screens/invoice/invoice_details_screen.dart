import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:invoice_pay/models/invoice_item_model.dart';
import 'package:invoice_pay/providers/invoice_provider.dart';
import 'package:invoice_pay/screens/invoice/create_invoice_screen.dart';
import 'package:invoice_pay/screens/invoice/invoice_preview.dart';
import 'package:invoice_pay/screens/invoice/wigets/record_payment_modal.dart';
import 'package:invoice_pay/utils/message.dart';
import 'package:invoice_pay/utils/resent_invoice.dart';
import 'package:invoice_pay/widgets/custom_button.dart';
import 'package:provider/provider.dart';
import 'package:invoice_pay/models/invoice_model.dart';
import 'package:invoice_pay/models/client_model.dart';
import 'package:invoice_pay/providers/client_provider.dart';
import 'package:invoice_pay/styles/colors.dart';

class InvoiceDetailScreen extends StatelessWidget {
  final InvoiceModel invoice;

  const InvoiceDetailScreen({super.key, required this.invoice});

  @override
  Widget build(BuildContext context) {
    final clientProvider = context.watch<ClientProvider>();
    final ClientModel client = clientProvider.clients.firstWhere(
      (c) => c.id == invoice.clientId,
      orElse: () => ClientModel(
        id: '',
        companyName: 'Unknown Client',
        contactName: '',
        email: '',
        phone: '',
        website: '',
        notes: '',
        outstandingBalance: 0,
        statusTag: '',
        statusColor: Colors.grey,
        actionIcon: Icons.person,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text('#${invoice.number}'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) async {
              if (value == 'edit') {
                // Navigate to edit screen (use same NewInvoiceScreen with pre-filled data)
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => NewInvoiceScreen(invoiceToEdit: invoice),
                  ),
                );
              } else if (value == 'delete') {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Delete Invoice?'),
                    content: Text(
                      'Are you sure you want to delete invoice #${invoice.number}? This cannot be undone.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text(
                          'Delete',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                );

                if (confirm == true) {
                  final success = await context
                      .read<InvoiceProvider>()
                      .deleteInvoice(invoice.id);
                  if (success && context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Invoice deleted')),
                    );
                    Navigator.pop(context); // Go back to list
                  }
                }
              }
            },
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: 'edit',
                child: Row(
                  children: [
                    Icon(Icons.edit),
                    SizedBox(width: 12),
                    Text('Edit Invoice'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete, color: Colors.red),
                    SizedBox(width: 12),
                    Text('Delete Invoice', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Badge
            if (invoice.status == InvoiceStatus.overdue)
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
                  'OVERDUE',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            else if (invoice.status == InvoiceStatus.paid)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Text(
                  'PAID',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

            const SizedBox(height: 10),

            // Amount Due
            Text(
              '\$${NumberFormat('#,##0.00').format(invoice.balanceDue)}',
              style: TextStyle(
                fontSize: 38,
                fontWeight: FontWeight.bold,
                color: invoice.isOverdue ? Colors.red : Colors.black87,
              ),
            ),
            Text(
              'Due ${DateFormat('MMM dd, yyyy').format(invoice.due)}',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),

            const SizedBox(height: 20),

            // Quick Actions
            Wrap(
              spacing: 10,
              runSpacing: 10,
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _actionChip(
                  icon: Icons.notifications_active,
                  label: 'Remind',
                  onTap: () =>
                      resendInvoiceAndMarkSent(context, client, invoice),
                ),
                _actionChip(
                  icon: Icons.preview,
                  label: 'Preview',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const InvoicePreviewScreen(),
                    ),
                  ),
                ),
                if (invoice.balanceDue > 0)
                  _actionChip(
                    icon: Icons.preview,
                    label: 'Record Payment',
                    onTap: () => showRecordPayment(context, invoice),
                  ),
              ],
            ),

            const SizedBox(height: 20),

            // Billed To
            const Text(
              'BILLED TO',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: primaryColor.withOpacity(0.2),
                    child: Text(
                      (client.companyName).isNotEmpty
                          ? client.companyName[0].toUpperCase()
                          : '?',
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          client.companyName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if ((client.contactName).isNotEmpty)
                          Text(client.contactName),
                        Text(client.email),
                        Text(client.phone),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Dates
            Row(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _infoCard(
                  'Issued',
                  DateFormat('MMM dd, yyyy').format(invoice.issued),
                ),
                _infoCard(
                  'Due',
                  DateFormat('MMM dd, yyyy').format(invoice.due),
                  highlight: invoice.isOverdue,
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Line Items
            const Text(
              'Items',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ...invoice.items.map((item) => _itemRow(item)),

            const SizedBox(height: 20),

            // Summary
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.05),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: primaryColor.withOpacity(0.3)),
              ),
              child: Column(
                children: [
                  _summaryRow('Subtotal', invoice.subtotal),
                  _summaryRow(
                    'Tax (${invoice.taxPercent.toStringAsFixed(0)}%)',
                    invoice.taxAmount,
                  ),
                  _summaryRow(
                    'Discount (${invoice.discountPercent.toStringAsFixed(0)}%)',
                    -invoice.discountAmount,
                  ),
                  const Divider(),
                  _summaryRow('Total Due', invoice.total, isLarge: true),
                  if (invoice.paidAmount > 0)
                    _summaryRow(
                      'Amount Paid',
                      invoice.paidAmount,
                      color: Colors.green,
                    ),
                  _summaryRow(
                    'Balance Due',
                    invoice.balanceDue,
                    isLarge: true,
                    color: invoice.balanceDue > 0 ? Colors.red : Colors.green,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Main Actions
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    bgColor: greyColor,
                    icon: Icons.picture_as_pdf,
                    onPressed: () {},
                    text: "Export PDF",
                  ),
                ),

                const SizedBox(width: 16),
                Expanded(
                  child: CustomButton(
                    onPressed: () {
                      resendInvoiceAndMarkSent(context, client, invoice);
                    },
                    text: "Resend Invoice",
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Activity Timeline
            const Text(
              'Activity',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            if (invoice.status != InvoiceStatus.draft)
              _activityItem(
                'Invoice Sent',
                DateFormat('MMM dd, yyyy • h:mm a').format(invoice.sentDate!),
                Icons.send,
                Colors.blue,
              ),
            if (invoice.paidAmount > 0)
              _activityItem(
                'Payment Received',
                '+\$${invoice.paidAmount.toStringAsFixed(2)}',
                Icons.payment,
                Colors.green,
              ),
            _activityItem(
              'Invoice Created',
              DateFormat('MMM dd, yyyy').format(invoice.issued),
              Icons.note_add,
              Colors.grey,
            ),

            const SizedBox(height: 50),
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
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: primaryColor, size: 22),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoCard(String label, String value, {bool highlight = false}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: highlight ? Border.all(color: Colors.red, width: 2) : null,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
            Text(
              value,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemRow(InvoiceItemModel item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.description,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${item.qty} × \$${item.rate.toStringAsFixed(2)}',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          Text(
            '\$${item.amount.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(
    String label,
    double value, {
    Color? color,
    bool isLarge = false,
  }) {
    final isNegative = value < 0;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isLarge ? 16 : 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            '${isNegative ? '-' : ''}\$${NumberFormat('#,##0.00').format(value.abs())}',
            style: TextStyle(
              fontSize: isLarge ? 20 : 14,
              fontWeight: FontWeight.bold,
              color: color ?? (isLarge ? primaryColor : Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget _activityItem(
    String title,
    String subtitle,
    IconData icon,
    Color color,
  ) {
    return ListTile(
      leading: CircleAvatar(
        radius: 20,
        backgroundColor: color.withOpacity(0.1),
        child: Icon(icon, color: color, size: 16),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle),
    );
  }
}
