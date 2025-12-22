import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:invoice_pay/models/invoice_model.dart';
import 'package:invoice_pay/styles/colors.dart';

class InvoiceListItem extends StatelessWidget {
  final InvoiceModel invoice;

  const InvoiceListItem({super.key, required this.invoice});

  @override
  Widget build(BuildContext context) {
    Color statusColor = Colors.grey;
    String statusText = 'DRAFT';
    switch (invoice.status) {
      case InvoiceStatus.overdue:
        statusColor = Colors.red;
        statusText = 'OVERDUE';
        break;
      case InvoiceStatus.sent:
        statusColor = Colors.blue;
        statusText = 'SENT';
        break;
      case InvoiceStatus.paid:
        statusColor = primaryColor;
        statusText = 'PAID';
        break;
      default:
        break;
      // ... other statuses
    }

    return Card(
      child: ListTile(
        leading: CircleAvatar(backgroundColor: primaryColor),
        title: Text('Invoice #${invoice.number}'),
        subtitle: Text(DateFormat('MMM dd, yyyy').format(invoice.due)),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: statusColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            statusText,
            style: TextStyle(color: statusColor, fontWeight: FontWeight.bold),
          ),
        ),
        onTap: () {},
      ),
    );
  }
}
