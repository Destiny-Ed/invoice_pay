import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:intl/intl.dart';
import 'package:invoice_pay/providers/company_provider.dart';
import 'package:invoice_pay/utils/app_locales.dart';
import 'package:invoice_pay/utils/contants.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:invoice_pay/models/invoice_model.dart';
import 'package:invoice_pay/models/company_model.dart';
import 'package:invoice_pay/models/client_model.dart';
import 'package:printing/printing.dart';

class PdfInvoiceTemplate {
  static Future<pw.Document> generate({
    required BuildContext ctx,
    required InvoiceModel invoice,
    required CompanyModel company,
    required ClientModel client,
    required TemplateType template,
  }) async {
    final pdf = pw.Document();

    pw.ImageProvider? logo;
    try {
      if (company.logoUrl != null) {
        logo = await networkImage(company.logoUrl!);
      } else {
        final logoData = await rootBundle.load('assets/logo.png');
        if (logoData.buffer.asUint8List().isNotEmpty) {
          logo = pw.MemoryImage(logoData.buffer.asUint8List());
        }
      }
    } catch (_) {}

    final accentColor = PdfColor.fromInt(company.primaryColor.value);

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4.copyWith(
          marginLeft: 40,
          marginRight: 40,
          marginTop: 40,
          marginBottom: 40,
        ),
        build: (context) => [
          _buildTemplate(
            ctx: ctx,
            template: template,
            invoice: invoice,
            company: company,
            client: client,
            font: pw.Font.helvetica(),
            accentColor: accentColor,
            logo: logo!,
          ),
        ],
      ),
    );

    return pdf;
  }

  static pw.Widget _buildTemplate({
    required BuildContext ctx,
    required TemplateType template,
    required InvoiceModel invoice,
    required CompanyModel company,
    required ClientModel client,
    required pw.Font font,
    required PdfColor accentColor,
    required pw.ImageProvider logo,
  }) {
    final baseStyle = pw.TextStyle(font: font, fontSize: 12);
    final boldStyle = pw.TextStyle(
      font: font,
      fontSize: 14,
      fontWeight: pw.FontWeight.bold,
    );
    final accentStyle = pw.TextStyle(
      font: font,
      fontSize: 12,
      color: accentColor,
    );

    switch (template) {
      case TemplateType.minimal:
        return MinimalTemplate(
          ctx: ctx,
          invoice: invoice,
          company: company,
          client: client,
          baseStyle: baseStyle,
          boldStyle: boldStyle,
          accentStyle: accentStyle,
          accentColor: accentColor,
          logo: logo,
        );
      case TemplateType.bold:
        return BoldTemplate(
          ctx: ctx,

          invoice: invoice,
          company: company,
          client: client,
          baseStyle: baseStyle,
          boldStyle: boldStyle,
          accentStyle: accentStyle,
          accentColor: accentColor,
          logo: logo,
        );
      case TemplateType.classic:
        return ClassicTemplate(
          ctx: ctx,

          invoice: invoice,
          company: company,
          client: client,
          baseStyle: baseStyle,
          boldStyle: boldStyle,
          accentStyle: accentStyle,
          accentColor: accentColor,
          logo: logo,
        );
      case TemplateType.modern:
        return ModernTemplate(
          ctx: ctx,

          invoice: invoice,
          company: company,
          client: client,
          baseStyle: baseStyle,
          boldStyle: boldStyle,
          accentStyle: accentStyle,
          accentColor: accentColor,
          logo: logo,
        );
      case TemplateType.creative:
        return CreativeTemplate(
          ctx: ctx,

          invoice: invoice,
          company: company,
          client: client,
          baseStyle: baseStyle,
          boldStyle: boldStyle,
          accentStyle: accentStyle,
          accentColor: accentColor,
          logo: logo,
        );
    }
  }
}

// ================= Base Template =================

abstract class BasePdfTemplate extends pw.StatelessWidget {
  final BuildContext ctx;
  final InvoiceModel invoice;
  final CompanyModel company;
  final ClientModel client;
  final pw.TextStyle baseStyle;
  final pw.TextStyle boldStyle;
  final pw.TextStyle accentStyle;
  final PdfColor accentColor;
  final pw.ImageProvider logo;

  BasePdfTemplate({
    required this.ctx,
    required this.invoice,
    required this.company,
    required this.client,
    required this.baseStyle,
    required this.boldStyle,
    required this.accentStyle,
    required this.accentColor,
    required this.logo,
  });

  pw.Widget header();
  pw.Widget billToAndDates();
  pw.Widget itemsTable();
  pw.Widget totals();
  pw.Widget paymentInstructions();
  pw.Widget footer();

  @override
  pw.Widget build(pw.Context context) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        header(),
        pw.SizedBox(height: 30),
        billToAndDates(),
        pw.SizedBox(height: 30),
        itemsTable(),
        pw.SizedBox(height: 30),
        totals(),
        paymentInstructions(),
        pw.SizedBox(height: 20),
        footer(),
      ],
    );
  }

  pw.Widget _tableHeader(
    String text, {
    pw.Alignment align = pw.Alignment.centerLeft,
  }) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(8),
      child: pw.Text(
        text,
        style: boldStyle,
        textAlign: align == pw.Alignment.centerRight
            ? pw.TextAlign.right
            : pw.TextAlign.left,
      ),
    );
  }

  pw.Widget _tableCell(
    String text, {
    pw.Alignment align = pw.Alignment.centerLeft,
  }) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(8),
      child: pw.Text(
        text,
        textAlign: align == pw.Alignment.centerRight
            ? pw.TextAlign.right
            : pw.TextAlign.left,
      ),
    );
  }

  pw.Widget _totalRow(
    String label,
    double value, {
    bool bold = false,
    bool large = false,
    PdfColor? color,
  }) {
    final isNegative = value < 0;
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 6),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            label,
            style: pw.TextStyle(
              fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
              fontSize: large ? 18 : 14,
            ),
          ),
          pw.Text(
            '${isNegative ? '-' : ''}${invoice.currencySymbol ?? CompanyProvider().company?.currencySymbol ?? '\$'}${value.abs().toStringAsFixed(2)}',
            style: pw.TextStyle(
              fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
              fontSize: large ? 20 : 14,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

// ================= Minimal Template =================

class MinimalTemplate extends BasePdfTemplate {
  MinimalTemplate({
    required super.ctx,
    required super.invoice,
    required super.company,
    required super.client,
    required super.baseStyle,
    required super.boldStyle,
    required super.accentStyle,
    required super.accentColor,
    required super.logo,
  });

  @override
  pw.Widget header() {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(
          children: [
            pw.Container(
              height: 80,
              width: 80,
              decoration: pw.BoxDecoration(
                shape: pw.BoxShape.circle,
                image: pw.DecorationImage(image: logo),
              ),
            ),
            pw.SizedBox(width: 16),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(company.name, style: boldStyle.copyWith(fontSize: 22)),
                pw.Text(company.email, style: baseStyle),
                pw.Text(company.phone, style: baseStyle),
                pw.Text(
                  '${company.street}, ${company.city}, ${company.zip}',
                  style: baseStyle,
                ),
              ],
            ),
          ],
        ),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            pw.Text(
              AppLocale.invoices.getString(ctx).replaceAll("s", ""),
              style: boldStyle.copyWith(fontSize: 28),
            ),
            pw.SizedBox(height: 4),
            pw.Text(
              '#${invoice.number}',
              style: baseStyle.copyWith(fontSize: 16),
            ),
            pw.Text(
              '${AppLocale.dates.getString(ctx).replaceAll("s", "")}: ${DateFormat('MMM dd, yyyy').format(invoice.issued)}',
              style: baseStyle.copyWith(fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }

  @override
  pw.Widget billToAndDates() {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                '${AppLocale.billTo.getString(ctx)}:',
                style: boldStyle.copyWith(fontSize: 14),
              ),
              pw.SizedBox(height: 4),
              pw.Text(
                client.companyName,
                style: boldStyle.copyWith(fontSize: 16),
              ),
              if (client.contactName.isNotEmpty)
                pw.Text(client.contactName, style: baseStyle),
              pw.Text(client.email, style: baseStyle),
              pw.Text(client.phone, style: baseStyle),
            ],
          ),
        ),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            pw.Text(
              '${AppLocale.due.getString(ctx)}: ${DateFormat('MMM dd, yyyy').format(invoice.due)}',
              style: baseStyle,
            ),
            pw.Text(
              '${AppLocale.status.getString(ctx)}: ${invoice.status.name.toUpperCase()}',
              style: boldStyle.copyWith(
                fontSize: 12,
                color: invoice.status == InvoiceStatus.paid
                    ? PdfColors.green
                    : invoice.status == InvoiceStatus.overdue
                    ? PdfColors.red
                    : PdfColors.orange,
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  pw.Widget itemsTable() {
    final currency =
        invoice.currencySymbol ??
        CompanyProvider().company?.currencySymbol ??
        '\$';
    return pw.Table(
      border: pw.TableBorder.all(color: PdfColors.grey400),
      children: [
        pw.TableRow(
          decoration: pw.BoxDecoration(color: accentColor.shade(0.2)),
          children: [
            _tableHeader(AppLocale.description.getString(ctx)),
            _tableHeader(
              AppLocale.qty.getString(ctx),
              align: pw.Alignment.centerRight,
            ),
            _tableHeader(
              AppLocale.rate.getString(ctx),
              align: pw.Alignment.centerRight,
            ),
            _tableHeader(
              AppLocale.amount.getString(ctx),
              align: pw.Alignment.centerRight,
            ),
          ],
        ),
        ...invoice.items.asMap().entries.map((entry) {
          final i = entry.key;
          final item = entry.value;
          return pw.TableRow(
            decoration: i % 2 == 0
                ? pw.BoxDecoration(color: PdfColors.grey100)
                : null,
            children: [
              _tableCell(item.description),
              _tableCell(
                item.qty.toStringAsFixed(0),
                align: pw.Alignment.centerRight,
              ),
              _tableCell(
                '$currency${item.rate.toStringAsFixed(2)}',
                align: pw.Alignment.centerRight,
              ),
              _tableCell(
                '$currency${item.amount.toStringAsFixed(2)}',
                align: pw.Alignment.centerRight,
              ),
            ],
          );
        }),
      ],
    );
  }

  @override
  pw.Widget totals() {
    return pw.Align(
      alignment: pw.Alignment.centerRight,
      child: pw.Container(
        width: double.infinity,
        padding: const pw.EdgeInsets.all(16),
        decoration: pw.BoxDecoration(
          color: accentColor.shade(0.05),
          borderRadius: pw.BorderRadius.circular(12),
          border: pw.Border.all(color: accentColor.shade(0.4)),
        ),
        child: pw.Column(
          children: [
            _totalRow(AppLocale.subtotal.getString(ctx), invoice.subtotal),
            _totalRow(
              '${AppLocale.taxPercent.getString(ctx).replaceAll("%", "")} (${invoice.taxPercent.toStringAsFixed(0)}%)',
              invoice.taxAmount,
            ),
            _totalRow(
              '${AppLocale.discountPercent.getString(ctx).replaceAll("%", "")} (${invoice.discountPercent.toStringAsFixed(0)}%)',
              -invoice.discountAmount,
            ),
            pw.Divider(thickness: 1.5, color: accentColor),
            _totalRow(
              AppLocale.totalDue.getString(ctx),
              invoice.total,
              bold: true,
              large: true,
              color: accentColor,
            ),
          ],
        ),
      ),
    );
  }

  @override
  pw.Widget paymentInstructions() {
    if (invoice.paymentMethod.isEmpty) {
      return pw.SizedBox();
    }
    String methodLabel =
        {
          'bank_transfer': AppLocale.bankTransfer.getString(ctx),
          'paypal': AppLocale.payPal.getString(ctx),
          'stripe': AppLocale.stripe.getString(ctx),
          'upi': AppLocale.upi.getString(ctx),
        }[invoice.paymentMethod] ??
        invoice.paymentMethod;
    return pw.Container(
      width: double.infinity,
      margin: const pw.EdgeInsets.only(top: 30),
      padding: const pw.EdgeInsets.all(16),
      decoration: pw.BoxDecoration(
        color: accentColor.shade(0.1),
        borderRadius: pw.BorderRadius.circular(12),
        border: pw.Border.all(color: accentColor.shade(0.4)),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            AppLocale.paymentMethod.getString(ctx),
            style: boldStyle.copyWith(fontSize: 14),
          ),
          pw.SizedBox(height: 4),
          pw.Text(methodLabel, style: accentStyle),
          if (invoice.paymentDetails.isNotEmpty) ...[
            pw.SizedBox(height: 8),
            pw.Text(
              AppLocale.paymentDetails.getString(ctx),
              style: boldStyle.copyWith(fontSize: 14),
            ),
            pw.SizedBox(height: 4),
            pw.Text(invoice.paymentDetails, style: baseStyle),
          ],
        ],
      ),
    );
  }

  @override
  pw.Widget footer() {
    return pw.Center(
      child: pw.Column(
        children: [
          pw.Text(
            AppLocale.thankYouFooter.getString(ctx),
            style: baseStyle.copyWith(
              fontStyle: pw.FontStyle.italic,
              color: PdfColors.grey700,
            ),
          ),
          pw.SizedBox(height: 20),
          pw.UrlLink(
            child: pw.Text(
              AppLocale.proudlyPoweredBy.getString(ctx),
              style: baseStyle.copyWith(
                fontStyle: pw.FontStyle.italic,
                color: PdfColors.grey700,
              ),
            ),
            destination: appUrl,
          ),
        ],
      ),
    );
  }
}

// ================= Other Templates =================

class BoldTemplate extends MinimalTemplate {
  BoldTemplate({
    required super.ctx,
    required super.invoice,
    required super.company,
    required super.client,
    required super.baseStyle,
    required super.boldStyle,
    required super.accentStyle,
    required super.accentColor,
    required super.logo,
  });
  @override
  pw.Widget build(pw.Context context) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(30),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: accentColor, width: 4),
        borderRadius: pw.BorderRadius.circular(16),
      ),
      child: super.build(context),
    );
  }
}

class ClassicTemplate extends MinimalTemplate {
  ClassicTemplate({
    required super.ctx,
    required super.invoice,
    required super.company,
    required super.client,
    required super.baseStyle,
    required super.boldStyle,
    required super.accentStyle,
    required super.accentColor,
    required super.logo,
  });
  @override
  pw.Widget build(pw.Context context) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          company.name.toUpperCase(),
          style: boldStyle.copyWith(fontSize: 28),
        ),
        pw.Divider(thickness: 2),
        pw.SizedBox(height: 20),
        super.build(context),
      ],
    );
  }
}

class ModernTemplate extends MinimalTemplate {
  ModernTemplate({
    required super.ctx,
    required super.invoice,
    required super.company,
    required super.client,
    required super.baseStyle,
    required super.boldStyle,
    required super.accentStyle,
    required super.accentColor,
    required super.logo,
  });
  @override
  pw.Widget build(pw.Context context) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(company.name, style: boldStyle.copyWith(fontSize: 26)),
            pw.Container(
              padding: const pw.EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 8,
              ),
              color: accentColor,
              child: pw.Text(
                AppLocale.invoices
                    .getString(ctx)
                    .replaceAll("s", "")
                    .toUpperCase(),
                style: pw.TextStyle(
                  color: PdfColors.white,
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        pw.SizedBox(height: 30),
        super.build(context),
      ],
    );
  }
}

class CreativeTemplate extends MinimalTemplate {
  CreativeTemplate({
    required super.ctx,
    required super.invoice,
    required super.company,
    required super.client,
    required super.baseStyle,
    required super.boldStyle,
    required super.accentStyle,
    required super.accentColor,
    required super.logo,
  });

  @override
  pw.Widget build(pw.Context context) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        // Colored header
        pw.Container(
          width: double.infinity,
          padding: const pw.EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          color: accentColor,
          child: pw.Text(
            company.name,
            style: pw.TextStyle(
              color: PdfColors.white,
              fontSize: 28,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        ),

        pw.SizedBox(height: 20),

        // Invoice number
        pw.Text(
          '${AppLocale.invoices.getString(ctx).replaceAll("s", "").toUpperCase()} #${invoice.number}',
          style: boldStyle.copyWith(fontSize: 22),
        ),
        pw.SizedBox(height: 20),

        // Now call parent build (MinimalTemplate) safely
        super.build(context),
      ],
    );
  }
}
