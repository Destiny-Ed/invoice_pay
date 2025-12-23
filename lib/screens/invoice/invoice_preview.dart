// screens/invoices/invoice_preview_screen.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:invoice_pay/models/company_model.dart';
import 'package:invoice_pay/models/client_model.dart';
import 'package:invoice_pay/models/invoice_item_model.dart';
import 'package:invoice_pay/providers/company_provider.dart';
import 'package:invoice_pay/providers/invoice_provider.dart';
import 'package:invoice_pay/styles/colors.dart';

class InvoicePreviewScreen extends StatelessWidget {
  const InvoicePreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final invoiceProvider = context.watch<InvoiceProvider>();
    final companyProvider = context.watch<CompanyProvider>();
    final company = companyProvider.company;

    final width = MediaQuery.of(context).size.width;
    final isSmallScreen = width < 700;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Invoice Preview'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
        actions: const [
          Icon(Icons.share_outlined),
          SizedBox(width: 8),
          Icon(Icons.picture_as_pdf_outlined),
          SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 900),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  blurRadius: 24,
                  offset: const Offset(0, 10),
                  color: Colors.black.withOpacity(0.08),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _header(company, invoiceProvider),
                const SizedBox(height: 48),

                _detailsSection(
                  isSmallScreen,
                  company,
                  invoiceProvider.draftSelectedClient,
                  invoiceProvider,
                ),

                const SizedBox(height: 48),

                safeText(
                  'Items',
                  fontSize: 20,
                  weight: FontWeight.bold,
                ),
                const SizedBox(height: 16),

                isSmallScreen
                    ? Column(
                        children: invoiceProvider.draftItems
                            .map(_mobileItemRow)
                            .toList(),
                      )
                    : _desktopItemTable(invoiceProvider),

                const SizedBox(height: 48),

                _summarySection(invoiceProvider, isSmallScreen),

                const SizedBox(height: 48),

                Center(
                  child: safeText(
                    'Thank you for your business!',
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ===================== HEADER =====================

  Widget _header(CompanyModel? company, InvoiceProvider provider) {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.center,
      runSpacing: 24,
      spacing: 24,
      children: [
        _companyLogo(company),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            safeText(
              'INVOICE',
              fontSize: 32,
              weight: FontWeight.bold,
              color: primaryColor,
              maxLines: 1,
            ),
            safeText(
              provider.draftInvoiceNumber,
              fontSize: 16,
              maxLines: 1,
            ),
          ],
        ),
      ],
    );
  }

  Widget _companyLogo(CompanyModel? company) {
    if (company?.logoUrl?.isNotEmpty == true) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(
          company!.logoUrl!,
          width: 96,
          height: 96,
          fit: BoxFit.contain,
        ),
      );
    }

    return Container(
      width: 96,
      height: 96,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(16),
      ),
      alignment: Alignment.center,
      child: safeText(
        company?.name.isNotEmpty == true
            ? company!.name[0].toUpperCase()
            : 'I',
        fontSize: 40,
        weight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  // ===================== DETAILS =====================

  Widget _detailsSection(
    bool isSmall,
    CompanyModel? company,
    ClientModel? client,
    InvoiceProvider provider,
  ) {
    final children = [
      Expanded(child: _detailCard('From', company)),
      Expanded(child: _detailCard('Bill To', client)),
      _datesCard(provider),
    ];

    return isSmall
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children
                .map((e) => Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: e,
                    ))
                .toList(),
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              children[0],
              const SizedBox(width: 32),
              children[1],
              const SizedBox(width: 32),
              children[2],
            ],
          );
  }

  Widget _detailCard(String title, dynamic entity) {
    final isCompany = entity is CompanyModel?;
    final name = isCompany
        ? entity?.name ?? 'Your Business'
        : entity?.companyName ?? 'Client';
    final email = entity?.email ?? '';
    final phone = entity?.phone ?? '';
    final address = isCompany
        ? '${entity?.street ?? ''}\n${entity?.city ?? ''} ${entity?.zip ?? ''}'
        : entity?.contactName ?? '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        safeText(title, weight: FontWeight.bold),
        const SizedBox(height: 12),
        safeText(name, fontSize: 18, weight: FontWeight.bold, maxLines: 2),
        if (address.trim().isNotEmpty)
          safeText(address, color: Colors.grey[700], maxLines: 3),
        if (email.isNotEmpty)
          safeText(email, color: Colors.grey[700], maxLines: 1),
        if (phone.isNotEmpty)
          safeText(phone, color: Colors.grey[700], maxLines: 1),
      ],
    );
  }

  Widget _datesCard(InvoiceProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _dateRow('Issued', provider.draftIssuedDate),
        const SizedBox(height: 12),
        _dateRow('Due', provider.draftDueDate),
      ],
    );
  }

  Widget _dateRow(String label, DateTime date) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        safeText(label, weight: FontWeight.w600),
        const SizedBox(width: 12),
        safeText(DateFormat('dd MMM yyyy').format(date)),
      ],
    );
  }

  // ===================== ITEMS =====================

  Widget _desktopItemTable(InvoiceProvider provider) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowColor:
            MaterialStateProperty.all(primaryColor.withOpacity(0.08)),
        columns: const [
          DataColumn(label: Text('Description')),
          DataColumn(label: Text('Qty'), numeric: true),
          DataColumn(label: Text('Rate'), numeric: true),
          DataColumn(label: Text('Amount'), numeric: true),
        ],
        rows: provider.draftItems.map((item) {
          return DataRow(cells: [
            DataCell(
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 300),
                child: safeText(
                  item.description.isEmpty ? '—' : item.description,
                  maxLines: 3,
                ),
              ),
            ),
            DataCell(Text(item.qty.toStringAsFixed(0))),
            DataCell(Text('\$${item.rate.toStringAsFixed(2)}')),
            DataCell(
              Text(
                '\$${item.amount.toStringAsFixed(2)}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ]);
        }).toList(),
      ),
    );
  }

  Widget _mobileItemRow(InvoiceItemModel item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          safeText(
            item.description.isEmpty ? '—' : item.description,
            weight: FontWeight.bold,
            maxLines: 3,
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 16,
            runSpacing: 8,
            children: [
              safeText('Qty: ${item.qty.toStringAsFixed(0)}'),
              safeText('Rate: \$${item.rate.toStringAsFixed(2)}'),
              safeText(
                'Amount: \$${item.amount.toStringAsFixed(2)}',
                weight: FontWeight.bold,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ===================== SUMMARY =====================

  Widget _summarySection(InvoiceProvider provider, bool isSmall) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        width: isSmall ? double.infinity : 420,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: primaryColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: primaryColor.withOpacity(0.2)),
        ),
        child: Column(
          children: [
            _summaryRow('Subtotal', provider.draftSubtotal),
            _summaryRow(
              'Tax (${provider.draftTaxPercent.toStringAsFixed(0)}%)',
              provider.draftTaxAmount,
            ),
            _summaryRow(
              'Discount (${provider.draftDiscountPercent.toStringAsFixed(0)}%)',
              -provider.draftDiscountAmount,
            ),
            const Divider(height: 32),
            _summaryRow(
              'Total Due',
              provider.draftTotal,
              isLarge: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryRow(String label, double value, {bool isLarge = false}) {
    final negative = value < 0;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          safeText(
            label,
            fontSize: isLarge ? 18 : 16,
            weight: FontWeight.w600,
          ),
          safeText(
            '${negative ? '-' : ''}\$${NumberFormat('#,##0.00').format(value.abs())}',
            fontSize: isLarge ? 26 : 18,
            weight: FontWeight.bold,
            color: isLarge ? primaryColor : Colors.black,
          ),
        ],
      ),
    );
  }
}

// ===================== SAFE TEXT =====================

Widget safeText(
  String text, {
  double fontSize = 14,
  FontWeight weight = FontWeight.normal,
  Color? color,
  int maxLines = 2,
}) {
  return Text(
    text,
    maxLines: maxLines,
    overflow: TextOverflow.ellipsis,
    softWrap: true,
    style: TextStyle(
      fontSize: fontSize,
      fontWeight: weight,
      color: color,
    ),
  );
}
