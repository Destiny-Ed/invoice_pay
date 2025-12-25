import 'package:flutter/material.dart';
import 'package:invoice_pay/models/client_model.dart';
import 'package:invoice_pay/models/company_model.dart';
import 'package:invoice_pay/models/invoice_model.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

class PdfInvoiceTemplate {
  static pw.Widget build({
    required InvoiceModel invoice,
    required CompanyModel company,
    required ClientModel client,
    required TemplateType template,
  }) {
    switch (template) {
      case TemplateType.bold:
        return _bold(invoice, company, client);
      case TemplateType.classic:
        return _classic(invoice, company, client);
      case TemplateType.modern:
        return _modern(invoice, company, client);
      case TemplateType.creative:
        return _creative(invoice, company, client);
      case TemplateType.minimal:
      default:
        return _minimal(invoice, company, client);
    }
  }

  // ==========================================================
  // MINIMAL
  // ==========================================================

  static pw.Widget _minimal(
    InvoiceModel invoice,
    CompanyModel company,
    ClientModel client,
  ) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _header(company, invoice),
        pw.SizedBox(height: 24),
        _billTo(client),
        pw.SizedBox(height: 24),
        _itemsTable(invoice),
        pw.Divider(),
        _totals(invoice),
      ],
    );
  }

  // ==========================================================
  // BOLD
  // ==========================================================

  static pw.Widget _bold(
    InvoiceModel invoice,
    CompanyModel company,
    ClientModel client,
  ) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(24),
      decoration: pw.BoxDecoration(border: pw.Border.all(width: 2)),
      child: _minimal(invoice, company, client),
    );
  }

  // ==========================================================
  // CLASSIC
  // ==========================================================

  static pw.Widget _classic(
    InvoiceModel invoice,
    CompanyModel company,
    ClientModel client,
  ) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          company.name.toUpperCase(),
          style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 8),
        pw.Text(company.email),
        pw.SizedBox(height: 24),
        _minimal(invoice, company, client),
      ],
    );
  }

  // ==========================================================
  // MODERN
  // ==========================================================

  static pw.Widget _modern(
    InvoiceModel invoice,
    CompanyModel company,
    ClientModel client,
  ) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(
              company.name,
              style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
            ),
            pw.Container(
              padding: const pw.EdgeInsets.all(8),
              color: PdfColors.grey300,
              child: pw.Text('INVOICE'),
            ),
          ],
        ),
        pw.SizedBox(height: 32),
        _minimal(invoice, company, client),
      ],
    );
  }

  // ==========================================================
  // CREATIVE
  // ==========================================================

  static pw.Widget _creative(
    InvoiceModel invoice,
    CompanyModel company,
    ClientModel client,
  ) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(24),
      color: PdfColors.grey100,
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            company.name,
            style: pw.TextStyle(
              fontSize: 26,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.blue,
            ),
          ),
          pw.SizedBox(height: 24),
          _minimal(invoice, company, client),
        ],
      ),
    );
  }

  // ==========================================================
  // COMPONENTS
  // ==========================================================

  static pw.Widget _header(CompanyModel company, InvoiceModel invoice) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              company.name,
              style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
            ),
            pw.Text(company.email),
          ],
        ),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            pw.Text('Invoice #${invoice.number}'),
            pw.Text(
              'Due: ${invoice.due.toLocal().toString().split(' ').first}',
            ),
          ],
        ),
      ],
    );
  }

  static pw.Widget _billTo(ClientModel client) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('Bill To', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        pw.Text(client.companyName),
        pw.Text(client.email),
      ],
    );
  }

  static pw.Widget _itemsTable(InvoiceModel invoice) {
    return pw.Column(
      children: invoice.items.map((item) {
        return pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Expanded(child: pw.Text(item.description)),
            pw.Text('\$${item.amount.toStringAsFixed(2)}'),
          ],
        );
      }).toList(),
    );
  }

  static pw.Widget _totals(InvoiceModel invoice) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw.SizedBox(height: 12),
        pw.Text('Subtotal: \$${invoice.subtotal.toStringAsFixed(2)}'),
        pw.Text('Tax: \$${invoice.taxAmount.toStringAsFixed(2)}'),
        pw.Text(
          'Total: \$${invoice.total.toStringAsFixed(2)}',
          style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
        ),
      ],
    );
  }
}

class InvoiceTemplate extends StatelessWidget {
  final TemplateType templateType;
  final InvoiceModel invoice;
  final CompanyModel company;
  final ClientModel client;

  const InvoiceTemplate({
    super.key,
    required this.templateType,
    required this.invoice,
    required this.company,
    required this.client,
  });

  @override
  Widget build(BuildContext context) {
    switch (templateType) {
      case TemplateType.bold:
        return _bold();
      case TemplateType.classic:
        return _classic();
      case TemplateType.modern:
        return _modern();
      case TemplateType.creative:
        return _creative();
      case TemplateType.minimal:
      default:
        return _minimal();
    }
  }

  /// ---------- Templates ----------

  Widget _minimal() {
    return _base(
      headerStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    );
  }

  Widget _bold() {
    return _base(
      headerStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
    );
  }

  Widget _classic() {
    return _base(
      headerStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        fontFamily: 'serif',
      ),
    );
  }

  Widget _modern() {
    return _base(
      headerStyle: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.1,
      ),
    );
  }

  Widget _creative() {
    return _base(
      headerStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.deepPurple,
      ),
    );
  }

  /// ---------- Shared Layout ----------
  Widget _base({required TextStyle headerStyle}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(company.name, style: headerStyle),
          const SizedBox(height: 4),
          Text(
            'Invoice #${invoice.number}',
            style: const TextStyle(fontSize: 10),
          ),

          const SizedBox(height: 8),
          Text(
            'Bill To: ${client.companyName}',
            style: const TextStyle(fontSize: 10),
          ),

          const Divider(height: 16),

          ...invoice.items
              .take(3)
              .map(
                (e) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        e.description,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 10),
                      ),
                    ),
                    Text(
                      '\$${e.amount.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              ),

          const Spacer(),

          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              'Total: \$${invoice.total.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
