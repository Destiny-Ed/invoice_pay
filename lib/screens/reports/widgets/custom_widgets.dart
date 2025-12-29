import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:invoice_pay/providers/company_provider.dart';
import 'package:invoice_pay/styles/colors.dart';
import 'package:provider/provider.dart';

Widget summaryCard(
  BuildContext context,
  String title,
  double amount,
  IconData icon,
  Color color, {
  bool isFullWidth = false,
}) {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(24),
      gradient: LinearGradient(
        colors: [color.withOpacity(0.8), color],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.15),
          blurRadius: 15,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.white, size: 36),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
          ],
        ),
        Text(
          '${context.read<CompanyProvider>().company?.currencySymbol ?? '\$'}${NumberFormat('#,##0').format(amount)}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

Widget filterChip(String label, bool selected, VoidCallback onTap) {
  return FilterChip(
    label: Text(label),
    selected: selected,
    onSelected: (_) => onTap(),
    selectedColor: primaryColor.withOpacity(0.2),
    checkmarkColor: primaryColor,
    backgroundColor: Colors.white,
    elevation: selected ? 4 : 0,
    shadowColor: Colors.black.withOpacity(0.1),
    labelStyle: TextStyle(
      color: selected ? primaryColor : Colors.grey[700],
      fontWeight: selected ? FontWeight.bold : FontWeight.w500,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
      side: BorderSide(color: selected ? primaryColor : Colors.grey[300]!),
    ),
  );
}
