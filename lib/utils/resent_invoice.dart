// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:invoice_pay/models/company_model.dart';
import 'package:invoice_pay/models/client_model.dart';
import 'package:invoice_pay/models/invoice_item_model.dart';
import 'package:invoice_pay/models/invoice_model.dart';
import 'package:invoice_pay/providers/invoice_provider.dart';
import 'package:invoice_pay/screens/invoice/wigets/invoice_template.dart';
import 'package:invoice_pay/utils/message.dart';
import 'package:path_provider/path_provider.dart';
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

    final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    await SharePlus.instance.share(
      ShareParams(
        title: 'Invoice #${invoice.number}',
        files: [
          XFile.fromData(pdfBytes, name: fileName, mimeType: 'application/pdf'),
        ],
        text: 'Invoice #${invoice.number} from ${company.name}',
        sharePositionOrigin: Offset.zero & overlay.size,
      ),
    );
  } catch (e) {
    if (context.mounted) {
      showMessage(context, 'Failed to share PDF: $e', isError: true);
    }
  }
}

/// Unified method to send invoice via Email, WhatsApp, or other apps with PDF attachment
Future<void> resendInvoiceAndMarkSent({
  required BuildContext context,
  required ClientModel client,
  required InvoiceModel invoice,
  required CompanyModel company,
  TemplateType template = TemplateType.minimal,
}) async {
  final formattedDue = DateFormat('MMMM dd, yyyy').format(invoice.due);
  final formattedTotal = NumberFormat('#,##0.00').format(invoice.total);

  // Professional & clean message body
  final messageBody =
      '''
Hi ${client.contactName.isNotEmpty ? client.contactName : client.companyName},

Please find your invoice attached for your review.

Invoice Details:
• Invoice: ${invoice.number}
• Amount Due: ${company.currencySymbol}$formattedTotal
• Due Date: $formattedDue

Thank you for your business! We appreciate your prompt payment.

Best regards,
${company.name}
${company.email}
${company.phone}
  ''';

  // Generate PDF
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
      showMessage(context, 'Failed to generate PDF', isError: true);
    }
    return;
  }

  // Save PDF to temporary file for sharing
  final tempDir = await getTemporaryDirectory();
  final pdfFile = File('${tempDir.path}/Invoice_${invoice.number}.pdf');
  await pdfFile.writeAsBytes(pdfBytes);
  final xFile = XFile(pdfFile.path);

  final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

  // Show send options
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
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Text(
              'Send Invoice',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.email_outlined, color: Colors.red),
            title: const Text('Email'),
            subtitle: Text(client.email),
            onTap: () => Navigator.pop(context, 'email'),
          ),
          ListTile(
            leading: const Icon(Icons.chat_bubble_outline, color: Colors.green),
            title: const Text('WhatsApp'),
            subtitle: Text(client.phone),
            onTap: () => Navigator.pop(context, 'whatsapp'),
          ),
          ListTile(
            leading: const Icon(Icons.share_outlined),
            title: const Text('Other Apps'),
            onTap: () => Navigator.pop(context, 'share'),
          ),
          const SizedBox(height: 10),
        ],
      ),
    ),
  );

  if (choice == null || !context.mounted) return;

  bool sent = false;

  switch (choice) {
    case 'email':
      // Try url_launcher first (some devices support attachment in query)
      final emailUri = Uri(
        scheme: 'mailto',
        path: client.email,
        queryParameters: {
          'subject': 'Invoice #${invoice.number} - ${company.name}',
          'body': messageBody,
          'attachment': [xFile.path],
        },
      );

      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri, mode: LaunchMode.externalApplication);
        sent = true;
      }

      // Fallback: Use share_plus (guaranteed attachment)
      if (!sent) {
        await SharePlus.instance.share(
          ShareParams(
            subject: 'Invoice #${invoice.number}',
            files: [xFile],
            text: messageBody,
            sharePositionOrigin: Offset.zero & overlay.size,
          ),
        );
        sent = true;
      }
      break;

    case 'whatsapp':
      // Open WhatsApp with pre-filled message
      final encodedBody = Uri.encodeComponent(messageBody);
      final whatsappUrl =
          'https://wa.me/${client.phone.replaceAll(RegExp(r'[^0-9+]'), '')}?text=$encodedBody';

      if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
        await launchUrl(
          Uri.parse(whatsappUrl),
          mode: LaunchMode.externalApplication,
        );
      }

      // Always follow up with share (so user can attach PDF manually)
      await SharePlus.instance.share(
        ShareParams(
          files: [xFile],
          text: messageBody,
          sharePositionOrigin: Offset.zero & overlay.size,
        ),
      );
      sent = true;
      break;

    case 'share':
      await SharePlus.instance.share(
        ShareParams(
          subject: 'Invoice #${invoice.number}',
          files: [xFile],
          text: messageBody,
          sharePositionOrigin: Offset.zero & overlay.size,
        ),
      );
      sent = true;
      break;
  }

  // Only mark as sent if successfully shared
  if (sent) {
    final updatedInvoice = invoice.copyWith(
      status: InvoiceStatus.sent,
      sentDate: DateTime.now(),
    );

    await context.read<InvoiceProvider>().addActivity(
      updatedInvoice,
      InvoiceActivityType.sent,
    );

    if (context.mounted) {
      showMessage(context, 'Invoice sent successfully!');
    }
  }
}
