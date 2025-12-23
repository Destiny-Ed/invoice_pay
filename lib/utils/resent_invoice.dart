import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:invoice_pay/models/client_model.dart';
import 'package:invoice_pay/models/invoice_model.dart';
import 'package:invoice_pay/providers/invoice_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> resendInvoiceAndMarkSent(
  BuildContext context,
  ClientModel client,
  InvoiceModel currentInvoice,
) async {
  // First: Resend via email/WhatsApp
  final subject = 'Invoice #${currentInvoice.number}';
  final body =
      '''
Hi ${client.contactName.isEmpty ? client.companyName : client.contactName},

Please find your invoice below.

Amount: \$${currentInvoice.total.toStringAsFixed(2)}
Due: ${DateFormat('MMM dd, yyyy').format(currentInvoice.due)}

Thank you!
    ''';

  final emailUrl = Uri.encodeFull(
    'mailto:${client.email}?subject=$subject&body=$body',
  );
  final whatsappUrl =
      'https://wa.me/${client.phone.replaceAll(RegExp(r'[^0-9]'), '')}?text=$body';

  final choice = await showModalBottomSheet<String>(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (_) => SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.email),
            title: const Text('Email'),
            onTap: () => Navigator.pop(context, 'email'),
          ),
          ListTile(
            leading: const Icon(Icons.chat),
            title: const Text('WhatsApp'),
            onTap: () => Navigator.pop(context, 'whatsapp'),
          ),
          ListTile(
            leading: const Icon(Icons.share),
            title: const Text('Other Apps'),
            onTap: () => Navigator.pop(context, 'share'),
          ),
        ],
      ),
    ),
  );

  if (choice == 'email' && await canLaunchUrl(Uri.parse(emailUrl))) {
    await launchUrl(Uri.parse(emailUrl));
  } else if (choice == 'whatsapp' &&
      await canLaunchUrl(Uri.parse(whatsappUrl))) {
    await launchUrl(Uri.parse(whatsappUrl));
  } else if (choice == 'share') {
    Share.share(body);
  }

  // After sending: Update status to Sent → Pending
  final updatedInvoice = currentInvoice.copyWith(
    status: InvoiceStatus.sent, // Will auto become Pending in getter
    sentDate: DateTime.now(),
  );

  await context.read<InvoiceProvider>().updateInvoice(updatedInvoice);
}
