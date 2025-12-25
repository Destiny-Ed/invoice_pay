import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:invoice_pay/providers/company_provider.dart';
import 'package:invoice_pay/utils/message.dart';
import 'package:invoice_pay/widgets/custom_button.dart';
import 'package:provider/provider.dart';

void showGoalModal(BuildContext context) {
  final controller = TextEditingController(
    text:
        context.read<CompanyProvider>().company?.monthlyGoal.toStringAsFixed(
          0,
        ) ??
        '15000',
  );

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
    ),
    builder: (_) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Set Monthly Goal',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'Motivate yourself with a clear target',
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 22),

            TextFormField(
              controller: controller,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                prefixText: '\$',
                hintText: '15000',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                filled: true,
                fillColor: Colors.grey[50],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                onPressed: () {
                  final goal =
                      double.tryParse(controller.text.replaceAll(',', '')) ??
                      15000.0;
                  context.read<CompanyProvider>().updateMonthlyGoal(goal);
                  Navigator.pop(context);
                  showMessage(
                    context,
                    'Goal updated to \$${NumberFormat('#,##0').format(goal)}',
                  );
                },
                text: "Save Goal",
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
