// screens/invoices/payment_reminders_screen.dart
import 'package:flutter/material.dart';
import 'package:invoice_pay/styles/colors.dart';

class PaymentRemindersScreen extends StatefulWidget {
  const PaymentRemindersScreen({super.key});

  @override
  State<PaymentRemindersScreen> createState() => _PaymentRemindersScreenState();
}

class _PaymentRemindersScreenState extends State<PaymentRemindersScreen> {
  bool _beforeDue = false;
  bool _onDue = false;
  bool _overdue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Reminders'),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Save', style: TextStyle(color: primaryColor)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'REMINDER CHANNEL',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _channelButton('Email', selected: true),
                _channelButton('WhatsApp'),
              ],
            ),

            const SizedBox(height: 32),

            const Text(
              'Schedule',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _scheduleRow(
              'Before Due Date',
              '3 days before at 9:00 AM',
              _beforeDue,
              (v) => setState(() => _beforeDue = v),
            ),
            _scheduleRow(
              'On Due Date',
              'At 10:00 AM',
              _onDue,
              (v) => setState(() => _onDue = v),
            ),
            _scheduleRow(
              'Overdue',
              '7 days after due date',
              _overdue,
              (v) => setState(() => _overdue = v),
            ),

            const SizedBox(height: 32),

            const Text(
              'Template',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _templateTag('+ Client Name'),
                _templateTag('+ Due Date'),
                _templateTag('+ Amount'),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'SUBJECT',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 4),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: 'Invoice #[InvoiceNumber] from [MyName]',
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'MESSAGE BODY',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 4),
            TextField(
              maxLines: 6,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText:
                    'Hi [ClientName],\n\nJust a friendly reminder that invoice #[InvoiceNumber] for [Amount] is due on [DueDate].\n\nLet me know if you have any questions!',
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
              child: const Text('Preview Reminder'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _channelButton(String label, {bool selected = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: selected ? primaryColor : Colors.grey[200],
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        label,
        style: TextStyle(color: selected ? Colors.white : Colors.grey[700]),
      ),
    );
  }

  Widget _scheduleRow(
    String title,
    String subtitle,
    bool value,
    Function(bool) onChanged,
  ) {
    return SwitchListTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle, style: TextStyle(color: Colors.grey[600])),
      value: value,
      onChanged: onChanged,
      activeColor: primaryColor,
    );
  }

  Widget _templateTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: primaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
