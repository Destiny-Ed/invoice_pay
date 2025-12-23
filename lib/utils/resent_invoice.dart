import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:invoice_pay/models/client_model.dart';
import 'package:invoice_pay/models/invoice_model.dart';
import 'package:invoice_pay/providers/company_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> resendInvoice(
  BuildContext context,
  ClientModel client,
  InvoiceModel invoice,
) async {
  final subject =
      'Invoice #${invoice.number} from ${context.read<CompanyProvider>().company?.name ?? 'Your Business'}';
  final body =
      '''
Hi ${client.contactName.isEmpty ? client.companyName : client.contactName},

Please find your invoice attached.

Invoice #: ${invoice.number}
Amount Due: \$${invoice.total.toStringAsFixed(2)}
Due Date: ${DateFormat('MMM dd, yyyy').format(invoice.due)}

Thank you!
    ''';

  final emailUrl = Uri.encodeFull(
    'mailto:${client.email}?subject=$subject&body=$body',
  );
  final whatsappUrl =
      'https://wa.me/${client.phone.replaceAll(RegExp(r'[^0-9]'), '')}?text=$body';

  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (_) => SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.email_outlined),
            title: const Text('Send via Email'),
            onTap: () async {
              if (await canLaunchUrl(Uri.parse(emailUrl))) {
                await launchUrl(Uri.parse(emailUrl));
              }
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.chat),
            title: const Text('Send via WhatsApp'),
            onTap: () async {
              if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
                await launchUrl(Uri.parse(whatsappUrl));
              }
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.share),
            title: const Text('Share Link'),
            onTap: () {
              Share.share(
                'Check your invoice: Invoice #${invoice.number} - Due: \$${invoice.total}',
              );
              Navigator.pop(context);
            },
          ),
        ],
      ),
    ),
  );
}
