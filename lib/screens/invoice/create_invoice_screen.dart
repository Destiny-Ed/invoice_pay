import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:invoice_pay/models/client_model.dart';
import 'package:invoice_pay/models/invoice_item_model.dart';
import 'package:invoice_pay/models/invoice_model.dart';
import 'package:invoice_pay/providers/client_provider.dart';
import 'package:invoice_pay/providers/invoice_provider.dart';
import 'package:invoice_pay/providers/company_provider.dart';
import 'package:invoice_pay/styles/colors.dart';

class NewInvoiceScreen extends StatefulWidget {
  final ClientModel? client;
  const NewInvoiceScreen({super.key, this.client});

  @override
  State<NewInvoiceScreen> createState() => _NewInvoiceScreenState();
}

class _NewInvoiceScreenState extends State<NewInvoiceScreen> {
  final TextEditingController _numberCtrl = TextEditingController(
    text: '#1024',
  );
  DateTime _issuedDate = DateTime.now();
  DateTime _dueDate = DateTime.now().add(const Duration(days: 30));
  ClientModel? _selectedClient;
  final List<InvoiceItemModel> _items = [
    InvoiceItemModel(),
  ]; // Start with one empty item
  double _taxPercent = 0.0;
  double _discountPercent = 0.0;

  @override
  void initState() {
    super.initState();
    _selectedClient = widget.client;
  }

  @override
  void dispose() {
    _numberCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final clientProvider = context.watch<ClientProvider>();
    final companyProvider = context.watch<CompanyProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Invoice'),
        actions: [
          TextButton(
            onPressed: () {
              // Preview PDF (future feature)
            },
            child: const Text('Preview', style: TextStyle(color: primaryColor)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Invoice Number
            TextField(
              controller: _numberCtrl,
              decoration: InputDecoration(
                labelText: 'INVOICE #',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Template Choice (Visual Only)
            const Text(
              'Choose Template',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _templateOption('Minimal', selected: true),
                _templateOption('Bold'),
                _templateOption('Classic'),
              ],
            ),

            const SizedBox(height: 32),

            // Client Selection
            const Text(
              'Client Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _selectedClient?.id,
              hint: const Text('Select Client'),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                prefixIcon: const Icon(Icons.person_outline),
              ),
              items: clientProvider.clients.map((client) {
                return DropdownMenuItem(
                  value: client.id,
                  child: Text(
                    client.contactName.isEmpty
                        ? client.companyName
                        : client.contactName,
                  ),
                );
              }).toList(),
              onChanged: (id) {
                setState(() {
                  _selectedClient = clientProvider.clients.firstWhere(
                    (c) => c.id == id,
                  );
                });
              },
            ),

            const SizedBox(height: 32),

            // Dates
            Row(
              children: [
                Expanded(
                  child: _dateField(
                    'Issued',
                    _issuedDate,
                    (date) => _issuedDate = date,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _dateField('Due', _dueDate, (date) => _dueDate = date),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Items Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Items',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton.icon(
                  icon: const Icon(Icons.add, color: primaryColor),
                  label: const Text(
                    'Add Item',
                    style: TextStyle(color: primaryColor),
                  ),
                  onPressed: () =>
                      setState(() => _items.add(InvoiceItemModel())),
                ),
              ],
            ),
            const SizedBox(height: 12),

            ..._items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              return _itemRow(item, index);
            }).toList(),

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
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onChanged: (v) =>
                        setState(() => _taxPercent = double.tryParse(v) ?? 0.0),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Discount %',
                      suffixText: '%',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onChanged: (v) => setState(
                      () => _discountPercent = double.tryParse(v) ?? 0.0,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Summary
            const Text(
              'Summary',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _summaryRow('Subtotal', _subtotal),
            _summaryRow('Tax ($_taxPercent%)', _taxAmount),
            _summaryRow('Discount ($_discountPercent%)', -_discountAmount),
            const Divider(height: 32),
            _summaryRow('Total Due', _total, isBold: true, isLarge: true),

            const SizedBox(height: 60),

            // Generate & Send Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _selectedClient == null
                    ? null
                    : () async {
                        final invoice = InvoiceModel(
                          id: '',
                          number: _numberCtrl.text,
                          clientId: _selectedClient!.id,
                          issued: _issuedDate,
                          due: _dueDate,
                          items: _items
                              .where((i) => i.description.isNotEmpty)
                              .toList(),
                          taxPercent: _taxPercent,
                          discountPercent: _discountPercent,
                        );

                        await context.read<InvoiceProvider>().addInvoice(
                          invoice,
                        );
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Invoice created successfully!'),
                            ),
                          );
                          Navigator.pop(context);
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Generate & Send',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _templateOption(String name, {bool selected = false}) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 140,
          decoration: BoxDecoration(
            border: Border.all(
              color: selected ? primaryColor : Colors.grey.shade300,
              width: selected ? 3 : 1,
            ),
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey[50],
          ),
          child: Center(
            child: Text(
              name,
              style: TextStyle(color: selected ? primaryColor : Colors.grey),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: TextStyle(
            color: selected ? primaryColor : Colors.grey,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _dateField(
    String label,
    DateTime date,
    Function(DateTime) onDatePicked,
  ) {
    return GestureDetector(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: date,
          firstDate: DateTime(2020),
          lastDate: DateTime(2030),
          builder: (context, child) => Theme(
            data: Theme.of(context).copyWith(
              colorScheme: Theme.of(
                context,
              ).colorScheme.copyWith(primary: primaryColor),
            ),
            child: child!,
          ),
        );
        if (picked != null) onDatePicked(picked);
      },
      child: AbsorbPointer(
        child: TextField(
          decoration: InputDecoration(
            labelText: label,
            suffixIcon: const Icon(Icons.calendar_today),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
          ),
          controller: TextEditingController(
            text: DateFormat('MMM dd, yyyy').format(date),
          ),
        ),
      ),
    );
  }

  Widget _itemRow(InvoiceItemModel item, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (v) => setState(() => item.description = v),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'QTY',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onChanged: (v) {
                      item.qty = double.tryParse(v) ?? 1.0;
                      setState(() => item.amount = item.qty * item.rate);
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 3,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'RATE',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onChanged: (v) {
                      item.rate = double.tryParse(v) ?? 0.0;
                      setState(() => item.amount = item.qty * item.rate);
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 3,
                  child: TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'AMOUNT',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    controller: TextEditingController(
                      text: '\$${item.amount.toStringAsFixed(2)}',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => setState(() => _items.removeAt(index)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryRow(
    String label,
    double value, {
    bool isPercent = false,
    bool isNegative = false,
    bool isBold = false,
    bool isLarge = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isLarge ? 20 : 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
            ),
          ),
          Text(
            '${isNegative ? '-' : ''}\$${NumberFormat('#,##0.00').format(value.abs())}',
            style: TextStyle(
              fontSize: isLarge ? 24 : 18,
              fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
              color: isLarge ? primaryColor : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  double get _subtotal => _items.fold(0.0, (sum, item) => sum + item.amount);
  double get _taxAmount => _subtotal * (_taxPercent / 100);
  double get _discountAmount => _subtotal * (_discountPercent / 100);
  double get _total => _subtotal + _taxAmount - _discountAmount;
}
