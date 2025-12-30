import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:invoice_pay/config/extension.dart';
import 'package:invoice_pay/utils/app_locales.dart';
import 'package:invoice_pay/utils/resent_invoice.dart';
import 'package:provider/provider.dart';

import '../../providers/invoice_provider.dart';
import '../../providers/company_provider.dart';

class InvoicePreviewScreen extends StatefulWidget {
  final bool fromAdd;
  const InvoicePreviewScreen({super.key, this.fromAdd = false});

  @override
  State<InvoicePreviewScreen> createState() => _InvoicePreviewScreenState();
}

class _InvoicePreviewScreenState extends State<InvoicePreviewScreen> {
  File? pdfFile;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _buildPdf();
  }

  Future<void> _buildPdf() async {
    final invoiceProvider = context.read<InvoiceProvider>();
    final company = context.read<CompanyProvider>().company!;
    final client = invoiceProvider.singleInvoice?.getClient(context)!;

    if (client == null) return;

    final file = await invoiceProvider.generatePdf(
      invoice: widget.fromAdd
          ? invoiceProvider.previewInvoice(context)
          : invoiceProvider.singleInvoice ??
                invoiceProvider.previewInvoice(context),
      company: company,
      client: client,
    );

    setState(() {
      pdfFile = file;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final invoiceProvider = context.read<InvoiceProvider>();
    final invoice = widget.fromAdd
        ? invoiceProvider.previewInvoice(context)
        : invoiceProvider.singleInvoice;

    final company = context.read<CompanyProvider>().company!;
    final client = invoice?.getClient(context)!;

    return Scaffold(
      appBar: AppBar(
        title:   Text(AppLocale.invoicePreview.getString(context)),
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf_outlined),
            onPressed: () => downloadInvoicePdf(
              context: context,
              invoice: invoice!,
              company: company,
              client: client!,
              template: invoice.templateType,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () => shareInvoicePdf(
              context: context,
              invoice: invoice!,
              company: company,
              client: client!,
              template: invoice.templateType,
            ),
          ),
        ],
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : PDFView(
              filePath: pdfFile!.path,
              enableSwipe: true,
              swipeHorizontal: false,
              autoSpacing: true,
              pageFling: true,
            ),
    );
  }
}
