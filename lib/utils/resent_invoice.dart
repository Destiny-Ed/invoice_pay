// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:invoice_pay/models/company_model.dart';
import 'package:invoice_pay/models/client_model.dart';
import 'package:invoice_pay/models/invoice_item_model.dart';
import 'package:invoice_pay/models/invoice_model.dart';
import 'package:invoice_pay/providers/invoice_provider.dart';
import 'package:invoice_pay/screens/invoice/wigets/invoice_template.dart';
import 'package:invoice_pay/utils/message.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

/// Generate PDF bytes for a given invoice
Future<Uint8List> generateInvoicePdf({
  required InvoiceModel invoice,
  required CompanyModel company,
  required ClientModel client,
  TemplateType template = TemplateType.minimal,
}) async {
  final pdf = await PdfInvoiceTemplate.generate(
    invoice: invoice,
    company: company,
    client: client,
    template: template,
  );
  return pdf.save();
}

/// Download or save PDF using native print/share dialog
Future<void> downloadInvoicePdf({
  required BuildContext context,
  required InvoiceModel invoice,
  required CompanyModel company,
  required ClientModel client,
  TemplateType template = TemplateType.minimal,
}) async {
  try {
    final pdfBytes = await generateInvoicePdf(
      invoice: invoice,
      company: company,
      client: client,
      template: template,
    );

    await Printing.sharePdf(
      bytes: pdfBytes,
      filename: 'Invoice_${invoice.number}.pdf',
    );
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to download PDF: $e')));
    }
  }
}

/// Share PDF with other apps
Future<void> shareInvoicePdf({
  required BuildContext context,
  required InvoiceModel invoice,
  required CompanyModel company,
  required ClientModel client,
  TemplateType template = TemplateType.minimal,
}) async {
  try {
    final pdfBytes = await generateInvoicePdf(
      invoice: invoice,
      company: company,
      client: client,
      template: template,
    );

    final fileName = 'Invoice_${invoice.number}.pdf';

    await Share.shareXFiles([
      XFile.fromData(pdfBytes, name: fileName, mimeType: 'application/pdf'),
    ], text: 'Invoice #${invoice.number} from ${company.name}');
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to share PDF: $e')));
    }
  }
}

/// modal for sending invoice via email, WhatsApp, or other apps
Future<void> resendInvoiceAndMarkSent({
  required BuildContext context,
  required ClientModel client,
  required InvoiceModel invoice,
  required CompanyModel company,
  TemplateType template = TemplateType.minimal,
}) async {
  final formattedDue = DateFormat('MMM dd, yyyy').format(invoice.due);
  final formattedTotal = invoice.total.toStringAsFixed(2);

  final messageBody =
      '''
Hi ${client.contactName.isEmpty ? client.companyName : client.contactName},

Please find your invoice attached.

Invoice #: ${invoice.number}
Amount: ${company.currencySymbol}$formattedTotal
Due Date: $formattedDue

Thank you for your business!
${company.name}
  ''';

  Uint8List pdfBytes;
  try {
    final pdfDoc = await PdfInvoiceTemplate.generate(
      invoice: invoice,
      company: company,
      client: client,
      template: template,
    );
    pdfBytes = await pdfDoc.save();
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to generate PDF: $e')));
    }
    return;
  }

  final choice = await showModalBottomSheet<String>(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (_) => SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Text(
              'Send Invoice',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.email),
            title: const Text('Email'),
            subtitle: Text(client.email),
            onTap: () => Navigator.pop(context, 'email'),
          ),
          ListTile(
            leading: const Icon(Icons.chat),
            title: const Text('WhatsApp'),
            subtitle: Text(client.phone),
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

  if (choice == null) return;

  switch (choice) {
    case 'email':
      final emailUri = Uri(
        scheme: 'mailto',
        path: client.email,
        queryParameters: {
          'subject': 'Invoice #${invoice.number}',
          'body': messageBody,
        },
      );
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      }
      break;

    case 'whatsapp':
      final whatsappUrl =
          'https://wa.me/${client.phone.replaceAll(RegExp(r'[^0-9]'), '')}?text=${Uri.encodeComponent(messageBody)}';
      if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
        await launchUrl(Uri.parse(whatsappUrl));
      }
      break;

    case 'share':
      if (context.mounted) {
        final overlay =
            Overlay.of(context).context.findRenderObject() as RenderBox;
        await Share.shareXFiles(
          [
            XFile.fromData(
              pdfBytes,
              name: 'Invoice_${invoice.number}.pdf',
              mimeType: 'application/pdf',
            ),
          ],
          text: messageBody,
          sharePositionOrigin: Offset.zero & overlay.size,
        );
      }
      break;
  }

  final updatedInvoice = invoice.copyWith(
    status: InvoiceStatus.sent, // auto becomes Pending if getter is implemented
    sentDate: DateTime.now(),
  );
  // Add sent activity
  await context.read<InvoiceProvider>().addActivity(
    updatedInvoice,
    InvoiceActivityType.sent,
  );

  showMessage(context, 'Invoice sent successfully!');
}
