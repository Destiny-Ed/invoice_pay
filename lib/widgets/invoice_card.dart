import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:invoice_pay/config/extension.dart';
import 'package:invoice_pay/models/invoice_model.dart';
import 'package:invoice_pay/providers/company_provider.dart';
import 'package:invoice_pay/screens/invoice/invoice_details_screen.dart';
import 'package:provider/provider.dart';

class InvoiceCard extends StatelessWidget {
  final InvoiceModel invoice;

  const InvoiceCard({super.key, required this.invoice});

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(invoice.status);
    final statusText = _getStatusText(invoice.status);

    final client = invoice.getClient(context);

    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InvoiceDetailScreen(invoiceId: invoice.id),
            ),
          );
        },
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Status Icon
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _getStatusIcon(invoice.status),
                  color: statusColor,
                  size: 28,
                ),
              ),

              const SizedBox(width: 16),

              // Main Content
              Expanded(
                child: Column(
                  spacing: 2,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SelectableText(
                          "${client?.contactName} - ${client?.companyName}",
                          style: const TextStyle(
                            fontSize: 12,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SelectableText(
                          '#${invoice.number}',
                          style: const TextStyle(
                            fontSize: 12,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),

                    Text(
                      'Due ${DateFormat('MMM dd, yyyy').format(invoice.due)}',
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),

                    const SizedBox(height: 12),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${invoice.currencySymbol ?? context.read<CompanyProvider>().company?.currencySymbol ?? '\$'}${NumberFormat('#,##0.00').format(invoice.balanceDue)}',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: invoice.isOverdue
                                ? Colors.red
                                : Colors.black87,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: statusColor.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            statusText,
                            style: TextStyle(
                              color: statusColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // Chevron
              Icon(Icons.chevron_right, color: Colors.grey[400]),
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(InvoiceStatus status) {
    switch (status) {
      case InvoiceStatus.paid:
        return Colors.green;
      case InvoiceStatus.overdue:
        return Colors.red;
      case InvoiceStatus.partial:
        return Colors.orange;
      case InvoiceStatus.sent:
      case InvoiceStatus.pending:
        return Colors.blue;
      case InvoiceStatus.draft:
        return Colors.grey;
    }
  }

  String _getStatusText(InvoiceStatus status) {
    switch (status) {
      case InvoiceStatus.paid:
        return 'PAID';
      case InvoiceStatus.overdue:
        return 'OVERDUE';
      case InvoiceStatus.partial:
        return 'PARTIAL';
      case InvoiceStatus.sent:
        return "SENT";
      case InvoiceStatus.pending:
        return 'PENDING';
      case InvoiceStatus.draft:
        return 'DRAFT';
    }
  }

  IconData _getStatusIcon(InvoiceStatus status) {
    switch (status) {
      case InvoiceStatus.paid:
        return Icons.check_circle;
      case InvoiceStatus.overdue:
        return Icons.warning_amber;
      case InvoiceStatus.partial:
        return Icons.account_balance_wallet;
      case InvoiceStatus.sent:
      case InvoiceStatus.pending:
        return Icons.send;
      case InvoiceStatus.draft:
        return Icons.drafts;
    }
  }
}
