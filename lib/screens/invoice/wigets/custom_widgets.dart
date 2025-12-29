import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:invoice_pay/models/invoice_item_model.dart';
import 'package:invoice_pay/providers/company_provider.dart';
import 'package:invoice_pay/providers/invoice_provider.dart';
import 'package:invoice_pay/styles/colors.dart';
import 'package:provider/provider.dart';

Widget emptyState(String title, String subtitle) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.receipt_long_outlined, size: 80, color: Colors.grey[400]),
        const SizedBox(height: 16),
        Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(subtitle, style: TextStyle(color: Colors.grey[600])),
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
    backgroundColor: Colors.grey[100],
    labelStyle: TextStyle(
      color: selected ? primaryColor : Colors.grey[700],
      fontWeight: selected ? FontWeight.bold : FontWeight.normal,
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
  );
}

Widget dateButton(String label, DateTime? date, VoidCallback onTap) {
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

Widget dateField(
  BuildContext context,
  String label,
  DateTime date,
  Function(DateTime) onPicked,
) {
  return GestureDetector(
    onTap: () async {
      final picked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
      );
      if (picked != null) onPicked(picked);
    },
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          Icon(Icons.calendar_today, color: Colors.grey[600]),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
              Text(
                DateFormat('dd MMM yyyy').format(date),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget itemCard(
  BuildContext context,
  InvoiceItemModel item,
  int index,
  InvoiceProvider provider,
) {
  return Container(
    margin: const EdgeInsets.only(bottom: 20),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),
      boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
      ],
    ),
    child: Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Item Description',
                  hintText: 'e.g. Website Design - Phase 1',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onChanged: (v) => provider.updateDraftItemDescription(index, v),
              ),
            ),
            if (provider.draftItems.length > 1)
              IconButton(
                onPressed: () => provider.removeDraftItem(index),
                icon: const Icon(Icons.delete, color: Colors.red),
              ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Qty"),
                  SizedBox(
                    height: 50,
                    child: Row(
                      spacing: 10,
                      children: [
                        GestureDetector(
                          onTap: () => provider.decrementDraftQuantity(index),
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: greyColor.withOpacity(0.3),
                            ),
                            child: const Icon(Icons.remove),
                          ),
                        ),
                        Container(
                          width: 10,
                          alignment: Alignment.center,
                          child: Text(
                            item.qty.toStringAsFixed(0),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => provider.incrementDraftQuantity(index),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: greyColor.withOpacity(0.3),
                            ),
                            padding: const EdgeInsets.all(2),
                            child: const Icon(Icons.add),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Rate"),
                  SizedBox(
                    height: 50,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: '0',
                        prefixText:
                            '${context.read<CompanyProvider>().company?.currencySymbol ?? '\$'} ',
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onChanged: (v) => provider.updateDraftItemRate(
                        index,
                        double.tryParse(v) ?? 0.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),

            Expanded(
              child: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("Amount"),
                  Container(
                    height: 50,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      '${context.read<CompanyProvider>().company?.currencySymbol ?? '\$'}${NumberFormat('#,##0.00').format(item.amount.abs())}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget summaryRow(
  BuildContext context,
  String label,
  double value, {
  bool isBold = false,
  bool isLarge = false,
}) {
  final isNegative = value < 0;
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label,
            maxLines: 2,
            style: TextStyle(
              fontSize: isLarge ? 16 : 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
        Expanded(
          child: Text(
            '${isNegative ? '-' : ''}${context.read<CompanyProvider>().company?.currencySymbol ?? '\$'}${NumberFormat('#,##0.00').format(value.abs())}',
            maxLines: 2,
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: isLarge ? 20 : 16,

              fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
              color: isLarge ? primaryColor : null,
            ),
          ),
        ),
      ],
    ),
  );
}
