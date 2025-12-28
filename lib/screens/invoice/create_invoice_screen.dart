import 'package:flutter/material.dart';
import 'package:invoice_pay/config/extension.dart';
import 'package:invoice_pay/modal/single_select_modal.dart';
import 'package:invoice_pay/models/invoice_model.dart';
import 'package:invoice_pay/providers/auth_provider.dart';
import 'package:invoice_pay/screens/invoice/invoice_preview.dart';
import 'package:invoice_pay/screens/invoice/wigets/custom_widgets.dart';
import 'package:invoice_pay/widgets/busy_overlay.dart';
import 'package:invoice_pay/widgets/custom_button.dart';
import 'package:invoice_pay/widgets/custom_text_field.dart';
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
        invoiceProvider.toggleDraftReceivePayment(
          widget.invoiceToEdit!.receivePayment,
        );
        invoiceProvider.setDraftPaymentMethod(
          widget.invoiceToEdit!.paymentMethod,
        );
        invoiceProvider.updateDraftPaymentDetails(
          widget.invoiceToEdit!.paymentDetails,
        );
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        invoiceProvider.updateDraftInvoiceNumber(
          "INV-${DateTime.now().millisecondsSinceEpoch}",
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create Invoice'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const InvoicePreviewScreen(fromAdd: true),
                  ),
                );
              },
              child: const Text(
                'Preview',
                style: TextStyle(color: primaryColor),
              ),
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
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Professional invoices in seconds',
                      style: TextStyle(color: Colors.grey[600]),
                    ),

                    const SizedBox(height: 20),

                    // Invoice Number
                    CustomTextField(
                      TextEditingController(
                          text: invoiceProvider.draftInvoiceNumber,
                        )
                        ..selection = TextSelection.fromPosition(
                          TextPosition(
                            offset: invoiceProvider.draftInvoiceNumber.length,
                          ),
                        ),
                      password: false,
                      prefixIcon: const Icon(Icons.tag),
                      onPress: invoiceProvider.updateDraftInvoiceNumber,
                    ),

                    const SizedBox(height: 20),

                    // Template Selection
                    // ================= TEMPLATE SELECTION =================
                    // const Text(
                    //   'Choose Template',
                    //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    // ),
                    // const SizedBox(height: 16),

                    // SizedBox(
                    //   height: 220,
                    //   child: ListView.builder(
                    //     scrollDirection: Axis.horizontal,
                    //     itemCount: invoiceProvider.templates.length,
                    //     itemBuilder: (context, index) {
                    //       final templateName = invoiceProvider.templates[index];
                    //       final isSelected =
                    //           templateName ==
                    //           invoiceProvider.draftSelectedTemplate;

                    //       final templateType = TemplateType.values.firstWhere(
                    //         (e) => e.name == templateName,
                    //       );

                    //       return GestureDetector(
                    //         onTap: () =>
                    //             invoiceProvider.selectDraftTemplate(templateName),
                    //         child: AnimatedContainer(
                    //           duration: const Duration(milliseconds: 200),
                    //           width: 180,
                    //           margin: const EdgeInsets.only(right: 16),
                    //           padding: const EdgeInsets.all(12),
                    //           decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(20),
                    //             border: Border.all(
                    //               color: isSelected
                    //                   ? primaryColor
                    //                   : Colors.grey[300]!,
                    //               width: isSelected ? 3 : 1,
                    //             ),
                    //             color: Colors.white,
                    //             boxShadow: [
                    //               BoxShadow(
                    //                 color: Colors.black.withOpacity(0.06),
                    //                 blurRadius: 12,
                    //               ),
                    //             ],
                    //           ),
                    //           child: Column(
                    //             children: [
                    //               Expanded(
                    //                 child: IgnorePointer(
                    //                   child: InvoiceTemplatePreview(
                    //                     templateType: templateType,
                    //                     invoice: invoiceProvider.previewInvoice(
                    //                       context,
                    //                     ),
                    //                     company: context
                    //                         .read<CompanyProvider>()
                    //                         .company!,
                    //                     client:
                    //                         invoiceProvider.draftSelectedClient ??
                    //                         ClientModel.empty(),
                    //                   ),
                    //                 ),
                    //               ),
                    //               const SizedBox(height: 8),
                    //               Text(
                    //                 templateName.toUpperCase(),
                    //                 style: TextStyle(
                    //                   fontWeight: FontWeight.bold,
                    //                   color: isSelected
                    //                       ? primaryColor
                    //                       : Colors.grey[700],
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // ),
                    const SizedBox(height: 20),

                    // Client Selection
                    const Text(
                      'Client',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: () async {
                        final clients = clientProvider.clients;
                        final selectedName = await showSingleClientSelectModal(
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
                            const Icon(
                              Icons.person_outline,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                invoiceProvider.draftSelectedClient == null
                                    ? 'Select a client'
                                    : invoiceProvider
                                          .draftSelectedClient!
                                          .contactName
                                          .isEmpty
                                    ? invoiceProvider
                                          .draftSelectedClient!
                                          .companyName
                                    : invoiceProvider
                                          .draftSelectedClient!
                                          .contactName,
                                style: TextStyle(
                                  fontSize: 16,
                                  color:
                                      invoiceProvider.draftSelectedClient ==
                                          null
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

                    const SizedBox(height: 20),

                    // Dates
                    const Text(
                      'Dates',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: dateField(
                            context,
                            'Issued',
                            invoiceProvider.draftIssuedDate,
                            invoiceProvider.updateDraftIssuedDate,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: dateField(
                            context,
                            'Due',
                            invoiceProvider.draftDueDate,
                            invoiceProvider.updateDraftDueDate,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

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
                          icon: const Icon(
                            Icons.add_circle,
                            color: primaryColor,
                          ),
                          label: const Text(
                            'Add Item',
                            style: TextStyle(color: primaryColor),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ...invoiceProvider.draftItems.asMap().entries.map(
                      (e) => itemCard(e.value, e.key, invoiceProvider),
                    ),

                    const SizedBox(height: 20),

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
                            onChanged: (v) =>
                                invoiceProvider.updateDraftTaxPercent(
                                  double.tryParse(v) ?? 0.0,
                                ),
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

                    const SizedBox(height: 20),

                    // Receive Payment Toggle
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: SwitchListTile(
                        title: const Text(
                          'Accept Payment with Invoice',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: const Text('Include payment instructions'),
                        value: invoiceProvider.draftReceivePayment,
                        onChanged: invoiceProvider.toggleDraftReceivePayment,
                        activeColor: primaryColor,
                      ),
                    ),

                    if (invoiceProvider.draftReceivePayment) ...[
                      const SizedBox(height: 20),
                      const Text(
                        'Payment Method',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          _paymentMethodChip(
                            'Bank Transfer',
                            'bank_transfer',
                            invoiceProvider,
                          ),
                          _paymentMethodChip(
                            'PayPal',
                            'paypal',
                            invoiceProvider,
                          ),
                          _paymentMethodChip(
                            'Stripe',
                            'stripe',
                            invoiceProvider,
                          ),
                          _paymentMethodChip('UPI', 'upi', invoiceProvider),
                        ],
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        decoration: InputDecoration(
                          labelText: _getPaymentLabel(
                            invoiceProvider.draftPaymentMethod,
                          ),
                          hintText: _getPaymentHint(
                            invoiceProvider.draftPaymentMethod,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          filled: true,
                          fillColor: Colors.grey[50],
                        ),
                        onChanged: invoiceProvider.updateDraftPaymentDetails,
                      ),
                    ],

                    const SizedBox(height: 40),

                    // Summary
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: primaryColor.withOpacity(0.3),
                        ),
                      ),
                      child: Column(
                        children: [
                          summaryRow('Subtotal', invoiceProvider.draftSubtotal),
                          summaryRow(
                            'Tax (${invoiceProvider.draftTaxPercent.toStringAsFixed(0)}%)',
                            invoiceProvider.draftTaxAmount,
                          ),
                          summaryRow(
                            'Discount (${invoiceProvider.draftDiscountPercent.toStringAsFixed(0)}%)',
                            -invoiceProvider.draftDiscountAmount,
                          ),
                          const Divider(),
                          summaryRow(
                            'Total Due',
                            invoiceProvider.draftTotal,
                            isBold: true,
                            isLarge: true,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 40),

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
                                  id:
                                      widget.invoiceToEdit?.id ??
                                      const Uuid().v4(),
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
                                  receivePayment:
                                      invoiceProvider.draftReceivePayment,
                                  paymentMethod:
                                      invoiceProvider.draftPaymentMethod,
                                  paymentDetails:
                                      invoiceProvider.draftPaymentDetails,
                                  templateType: TemplateType.values.firstWhere(
                                    (e) =>
                                        e.name ==
                                        invoiceProvider.draftSelectedTemplate,
                                    orElse: () => TemplateType.minimal,
                                  ),
                                );

                                final success = widget.invoiceToEdit == null
                                    ? await invoiceProvider.addInvoice(
                                        newInvoice,
                                      )
                                    : await invoiceProvider.updateInvoice(
                                        newInvoice,
                                      );

                                if (success && context.mounted) {
                                  showMessage(
                                    context,
                                    widget.invoiceToEdit == null
                                        ? 'Invoice created!'
                                        : 'Invoice updated!',
                                  );
                                  invoiceProvider.resetDraft();
                                  Navigator.pop(context);
                                }
                              }
                            : null,
                        text: widget.invoiceToEdit == null
                            ? "Generate & Send"
                            : "Update Invoice",
                      ),
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _paymentMethodChip(
    String label,
    String value,
    InvoiceProvider provider,
  ) {
    final isSelected = provider.draftPaymentMethod == value;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => provider.setDraftPaymentMethod(value),
      selectedColor: primaryColor.withOpacity(0.2),
      checkmarkColor: primaryColor,
      backgroundColor: Colors.grey[100],
      labelStyle: TextStyle(
        color: isSelected ? primaryColor : Colors.grey[700],
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    );
  }

  String _getPaymentLabel(String method) {
    switch (method) {
      case 'bank_transfer':
        return 'Bank Account Details';
      case 'paypal':
        return 'PayPal Email';
      case 'stripe':
        return 'Stripe Account / Payment Link';
      case 'upi':
        return 'UPI ID';
      default:
        return 'Payment Details';
    }
  }

  String _getPaymentHint(String method) {
    switch (method) {
      case 'bank_transfer':
        return 'Account Name, Number, Bank, IFSC';
      case 'paypal':
        return 'yourname@paypal.com';
      case 'stripe':
        return 'https://buy.stripe.com/...';
      case 'upi':
        return 'yourname@upi';
      default:
        return '';
    }
  }
}
