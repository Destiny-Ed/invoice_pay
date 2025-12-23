import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:invoice_pay/config/extension.dart';
import 'package:invoice_pay/modal/single_select_modal.dart';
import 'package:invoice_pay/models/invoice_item_model.dart';
import 'package:invoice_pay/models/invoice_model.dart';
import 'package:invoice_pay/providers/auth_provider.dart';
import 'package:invoice_pay/screens/invoice/invoice_preview.dart';
import 'package:invoice_pay/widgets/busy_overlay.dart';
import 'package:invoice_pay/widgets/custom_button.dart';
import 'package:provider/provider.dart';
import 'package:invoice_pay/models/client_model.dart';
import 'package:invoice_pay/providers/client_provider.dart';
import 'package:invoice_pay/providers/invoice_provider.dart';
import 'package:invoice_pay/styles/colors.dart';
import 'package:invoice_pay/utils/message.dart';
import 'package:uuid/uuid.dart';

class NewInvoiceScreen extends StatefulWidget {
  final ClientModel? client;
  final InvoiceModel? invoiceToEdit;

  const NewInvoiceScreen({super.key, this.client, this.invoiceToEdit});

  @override
  State<NewInvoiceScreen> createState() => _NewInvoiceScreenState();
}

class _NewInvoiceScreenState extends State<NewInvoiceScreen> {
  @override
  void initState() {
    super.initState();
    _init(context);
  }

  void _init(BuildContext context) async {
    final invoiceProvider = context.read<InvoiceProvider>();

    // Initialize draft if coming from client detail
    if (widget.client != null && invoiceProvider.draftSelectedClient == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        invoiceProvider.selectDraftClient(widget.client!);
      });
    }
    if (widget.invoiceToEdit != null) {
      // Pre-fill all draft fields from invoiceToEdit
      WidgetsBinding.instance.addPostFrameCallback((_) {
        invoiceProvider.updateDraftInvoiceNumber(widget.invoiceToEdit!.number);
        invoiceProvider.updateDraftIssuedDate(widget.invoiceToEdit!.issued);
        invoiceProvider.updateDraftDueDate(widget.invoiceToEdit!.due);
        invoiceProvider.selectDraftClient(
          widget.invoiceToEdit!.getClient(context)!,
        );
        invoiceProvider.draftItems.clear();
        invoiceProvider.draftItems.addAll(widget.invoiceToEdit!.items);
        invoiceProvider.updateDraftTaxPercent(widget.invoiceToEdit!.taxPercent);
        invoiceProvider.updateDraftDiscountPercent(
          widget.invoiceToEdit!.discountPercent,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Invoice'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const InvoicePreviewScreen()),
              );
            },
            child: const Text('Preview', style: TextStyle(color: primaryColor)),
          ),
        ],
      ),
      body: Consumer2<InvoiceProvider, ClientProvider>(
        builder: (context, invoiceProvider, clientProvider, _) {
          return BusyOverlay(
            show: invoiceProvider.viewState == ViewState.Busy,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'New Invoice',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Professional invoices in seconds',
                    style: TextStyle(color: Colors.grey[600]),
                  ),

                  const SizedBox(height: 40),

                  // Invoice Number
                  TextField(
                    controller:
                        TextEditingController(
                            text: invoiceProvider.draftInvoiceNumber,
                          )
                          ..selection = TextSelection.fromPosition(
                            TextPosition(
                              offset: invoiceProvider.draftInvoiceNumber.length,
                            ),
                          ),
                    decoration: InputDecoration(
                      labelText: 'Invoice Number',
                      prefixIcon: const Icon(Icons.tag),
                      filled: true,
                      fillColor: Colors.grey[50],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onChanged: invoiceProvider.updateDraftInvoiceNumber,
                  ),

                  const SizedBox(height: 32),

                  // Template Selection
                  const Text(
                    'Choose Template',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 180,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: invoiceProvider.templates.length,
                      itemBuilder: (context, index) {
                        final template = invoiceProvider.templates[index];
                        final isSelected =
                            template == invoiceProvider.draftSelectedTemplate;
                        return GestureDetector(
                          onTap: () =>
                              invoiceProvider.selectDraftTemplate(template),
                          child: Container(
                            width: 140,
                            margin: const EdgeInsets.only(right: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isSelected
                                    ? primaryColor
                                    : Colors.grey[300]!,
                                width: isSelected ? 3 : 1,
                              ),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.receipt_long,
                                  size: 60,
                                  color: isSelected
                                      ? primaryColor
                                      : Colors.grey,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  template,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: isSelected
                                        ? primaryColor
                                        : Colors.grey[700],
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Client Selection
                  const Text(
                    'Client',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () async {
                      final clients = clientProvider.clients;
                      final selectedName = await showSingleSelectModal(
                        context: context,
                        title: 'Select Client',
                        items: clients
                            .map(
                              (c) => c.contactName.isEmpty
                                  ? c.companyName
                                  : '${c.contactName} • ${c.companyName}',
                            )
                            .toList(),
                        selectedItem:
                            invoiceProvider.draftSelectedClient == null
                            ? null
                            : (invoiceProvider
                                      .draftSelectedClient!
                                      .contactName
                                      .isEmpty
                                  ? invoiceProvider
                                        .draftSelectedClient!
                                        .companyName
                                  : '${invoiceProvider.draftSelectedClient!.contactName} • ${invoiceProvider.draftSelectedClient!.companyName}'),
                      );
                      if (selectedName != null) {
                        final selectedClient = clients.firstWhere(
                          (c) =>
                              (c.contactName.isEmpty
                                  ? c.companyName
                                  : '${c.contactName} • ${c.companyName}') ==
                              selectedName,
                        );
                        invoiceProvider.selectDraftClient(selectedClient);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 20,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: invoiceProvider.draftSelectedClient == null
                              ? Colors.grey[400]!
                              : primaryColor,
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.person_outline, color: Colors.grey),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              invoiceProvider.draftSelectedClient == null
                                  ? 'Select a client'
                                  : (invoiceProvider
                                            .draftSelectedClient!
                                            .contactName
                                            .isEmpty
                                        ? invoiceProvider
                                              .draftSelectedClient!
                                              .companyName
                                        : invoiceProvider
                                              .draftSelectedClient!
                                              .contactName),
                              style: TextStyle(
                                fontSize: 16,
                                color:
                                    invoiceProvider.draftSelectedClient == null
                                    ? Colors.grey[600]
                                    : Colors.black87,
                              ),
                            ),
                          ),
                          const Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Dates
                  const Text(
                    'Dates',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _dateField(
                          context,
                          'Issued',
                          invoiceProvider.draftIssuedDate,
                          invoiceProvider.updateDraftIssuedDate,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _dateField(
                          context,
                          'Due',
                          invoiceProvider.draftDueDate,
                          invoiceProvider.updateDraftDueDate,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Line Items
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Line Items',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: invoiceProvider.addDraftItem,
                        icon: const Icon(Icons.add_circle, color: primaryColor),
                        label: const Text(
                          'Add Item',
                          style: TextStyle(color: primaryColor),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ...invoiceProvider.draftItems.asMap().entries.map(
                    (e) => _itemCard(e.value, e.key, invoiceProvider),
                  ),

                  const SizedBox(height: 32),

                  // Tax & Discount
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Tax %',
                            suffixText: '%',
                            filled: true,
                            fillColor: Colors.grey[50],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onChanged: (v) => invoiceProvider
                              .updateDraftTaxPercent(double.tryParse(v) ?? 0.0),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Discount %',
                            suffixText: '%',
                            filled: true,
                            fillColor: Colors.grey[50],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onChanged: (v) =>
                              invoiceProvider.updateDraftDiscountPercent(
                                double.tryParse(v) ?? 0.0,
                              ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),

                  // Summary
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: primaryColor.withOpacity(0.3)),
                    ),
                    child: Column(
                      children: [
                        _summaryRow('Subtotal', invoiceProvider.draftSubtotal),
                        _summaryRow(
                          'Tax (${invoiceProvider.draftTaxPercent.toStringAsFixed(0)}%)',
                          invoiceProvider.draftTaxAmount,
                        ),
                        _summaryRow(
                          'Discount (${invoiceProvider.draftDiscountPercent.toStringAsFixed(0)}%)',
                          -invoiceProvider.draftDiscountAmount,
                        ),
                        const Divider(),
                        _summaryRow(
                          'Total Due',
                          invoiceProvider.draftTotal,
                          isBold: true,
                          isLarge: true,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Generate Button
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      bgColor: invoiceProvider.canCreateDraftInvoice
                          ? primaryColor
                          : greyColor,
                      onPressed: invoiceProvider.canCreateDraftInvoice
                          ? () async {
                              final newInvoice = InvoiceModel(
                                id: widget.invoiceToEdit?.id ?? Uuid().v4(),
                                number: invoiceProvider.draftInvoiceNumber
                                    .trim(),
                                clientId:
                                    invoiceProvider.draftSelectedClient!.id,
                                issued: invoiceProvider.draftIssuedDate,
                                due: invoiceProvider.draftDueDate,
                                items: invoiceProvider.draftItems,
                                taxPercent: invoiceProvider.draftTaxPercent,
                                discountPercent:
                                    invoiceProvider.draftDiscountPercent,
                              );

                              final success = widget.invoiceToEdit == null
                                  ? await invoiceProvider.addInvoice(newInvoice)
                                  : await invoiceProvider.updateInvoice(
                                      newInvoice,
                                    );

                              if (!success && context.mounted) {
                                showMessage(
                                  context,
                                  invoiceProvider.errorMessage,
                                );
                                return;
                              }

                              if (success && context.mounted) {
                                showMessage(
                                  context,
                                  'Invoice created successfully!',
                                );
                                invoiceProvider.resetDraft();
                              }
                            }
                          : null,

                      text: "Generate & Send",
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _dateField(
    BuildContext context,
    String label,
    DateTime date,
    Function(DateTime) onPicked,
  ) {
    return GestureDetector(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: date,
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (picked != null) onPicked(picked);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          children: [
            Icon(Icons.calendar_today, color: Colors.grey[600]),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
                Text(
                  DateFormat('dd MMM yyyy').format(date),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemCard(InvoiceItemModel item, int index, InvoiceProvider provider) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Item Description',
                    hintText: 'e.g. Website Design - Phase 1',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onChanged: (v) =>
                      provider.updateDraftItemDescription(index, v),
                ),
              ),
              if (provider.draftItems.length > 1)
                IconButton(
                  onPressed: () => provider.removeDraftItem(index),
                  icon: const Icon(Icons.delete, color: Colors.red),
                ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Column(
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Qty"),
                    SizedBox(
                      height: 50,
                      child: Row(
                        spacing: 10,
                        children: [
                          GestureDetector(
                            onTap: () => provider.decrementDraftQuantity(index),
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: greyColor.withOpacity(0.3),
                              ),
                              child: const Icon(Icons.remove),
                            ),
                          ),
                          Container(
                            width: 10,
                            alignment: Alignment.center,
                            child: Text(
                              item.qty.toStringAsFixed(0),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => provider.incrementDraftQuantity(index),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: greyColor.withOpacity(0.3),
                              ),
                              padding: const EdgeInsets.all(2),
                              child: const Icon(Icons.add),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Rate"),
                    SizedBox(
                      height: 50,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: '0',
                          prefixText: '\$ ',
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onChanged: (v) => provider.updateDraftItemRate(
                          index,
                          double.tryParse(v) ?? 0.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),

              Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("Amount"),
                  Container(
                    height: 50,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      '\$${NumberFormat('#,##0.00').format(item.amount.abs())}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(
    String label,
    double value, {
    bool isBold = false,
    bool isLarge = false,
  }) {
    final isNegative = value < 0;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isLarge ? 16 : 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            '${isNegative ? '-' : ''}\$${NumberFormat('#,##0.00').format(value.abs())}',
            style: TextStyle(
              fontSize: isLarge ? 20 : 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
              color: isLarge ? primaryColor : null,
            ),
          ),
        ],
      ),
    );
  }
}
