import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:invoice_pay/models/invoice_item_model.dart';
import 'package:invoice_pay/models/invoice_model.dart';
import 'package:invoice_pay/providers/company_provider.dart';
import 'package:invoice_pay/providers/invoice_provider.dart';
import 'package:invoice_pay/utils/app_locales.dart';
import 'package:invoice_pay/utils/message.dart';
import 'package:invoice_pay/widgets/custom_button.dart';
import 'package:provider/provider.dart';

void showRecordPayment(BuildContext context, InvoiceModel currentInvoice) {
  final controller = TextEditingController();
  final formKey = GlobalKey<FormState>();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
    ),
    builder: (_) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        left: 20,
        right: 20,
        top: 20,
      ),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
              Text(
              AppLocale.recordPayment.getString(context),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Invoice #${currentInvoice.number}',
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Payment Amount',
                prefixText:
                    '${context.read<CompanyProvider>().company?.currencySymbol ?? '\$'} ',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                filled: true,
                fillColor: Colors.grey[50],
              ),
              validator: (v) {
                final amount = double.tryParse(v ?? '');
                if (amount == null || amount <= 0) return 'Enter valid amount';

                if (amount > currentInvoice.balanceDue.ceil()) {
                  return 'Cannot exceed balance';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                onPressed: () async {
                  if (!formKey.currentState!.validate()) return;

                  final payment = double.parse(controller.text);
                  final newPaid = currentInvoice.paidAmount + payment;

                  final updatedStatus = newPaid >= currentInvoice.total
                      ? InvoiceStatus.paid
                      : InvoiceStatus.partial;

                  final updatedInvoice = currentInvoice.copyWith(
                    paidAmount: newPaid,
                    status: updatedStatus,
                  );

                  // await context.read<InvoiceProvider>().updateInvoice(
                  //   updatedInvoice,
                  // );
                  // Add payment activity
                  await context.read<InvoiceProvider>().addActivity(
                    updatedInvoice,
                    InvoiceActivityType.paymentReceived,
                    amount: payment,
                  );
                  Navigator.pop(context);
                  showMessage(
                    context,
                    'Payment of ${context.read<CompanyProvider>().company?.currencySymbol ?? '\$'}${payment.toStringAsFixed(2)} recorded!',
                  );
                },
                text: AppLocale.recordPayment.getString(context),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
