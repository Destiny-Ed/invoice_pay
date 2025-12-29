import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:invoice_pay/providers/company_provider.dart';
import 'package:provider/provider.dart';

Widget statCard(
  BuildContext context, {
  required String title,
  required double amount,
  required int count,
  required Color color,
}) {
  return Card(
    elevation: 6,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    child: Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: color.withOpacity(0.1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.account_balance_wallet, color: color, size: 32),
          const SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '${context.read<CompanyProvider>().company?.currencySymbol ?? '\$'}${NumberFormat('#,##0').format(amount)}',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text('$count invoices', style: TextStyle(color: Colors.grey[600])),
        ],
      ),
    ),
  );
}
