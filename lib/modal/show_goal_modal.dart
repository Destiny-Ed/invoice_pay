import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:invoice_pay/providers/company_provider.dart';
import 'package:invoice_pay/utils/message.dart';
import 'package:invoice_pay/widgets/custom_button.dart';
import 'package:provider/provider.dart';

void showGoalModal(BuildContext context) {
  final companyProvider = context.read<CompanyProvider>();
  final currentGoal = companyProvider.company?.monthlyGoal ?? 5000.0;
  final controller = TextEditingController(
    text: currentGoal.toStringAsFixed(0),
  );

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
    ),
    builder: (_) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 32,
        left: 32,
        right: 32,
        top: 32,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Set Monthly Revenue Goal',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            'Track your progress on the dashboard',
            style: TextStyle(color: Colors.grey[600]),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: controller,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              prefixText:
                  '  ${companyProvider.company?.currencySymbol ?? '\$'} ',
              hintText: '15000',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              filled: true,
              fillColor: Colors.grey[50],
              contentPadding: const EdgeInsets.symmetric(vertical: 24),
            ),
          ),
          const SizedBox(height: 20),
          CustomButton(
            width: double.infinity,
            onPressed: () {
              final newGoal =
                  double.tryParse(
                    controller.text.replaceAll(RegExp(r'[^0-9]'), ''),
                  ) ??
                  currentGoal;
              companyProvider.updateMonthlyGoal(newGoal);
              Navigator.pop(context);
              showMessage(
                context,
                'Goal updated to \$${NumberFormat('#,##0').format(newGoal)}',
              );
            },

            text: 'Save Goal',
          ),
        ],
      ),
    ),
  );
}
