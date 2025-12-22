import 'package:flutter/material.dart';
import 'package:invoice_pay/models/client_model.dart';
import 'package:invoice_pay/models/invoice_model.dart';
import 'package:invoice_pay/screens/invoice/create_invoice_screen.dart';
import 'package:invoice_pay/styles/colors.dart';
import 'package:invoice_pay/widgets/invoice_list_item.dart';
import 'package:url_launcher/url_launcher.dart';

class ClientDetailScreen extends StatelessWidget {
  final ClientModel client;
  final List<InvoiceModel> invoices;

  const ClientDetailScreen({
    super.key,
    required this.client,
    required this.invoices,
  });

  @override
  Widget build(BuildContext context) {
    final outstanding = invoices.fold(0.0, (sum, inv) => sum + inv.balanceDue);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Client Details'),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Edit', style: TextStyle(color: primaryColor)),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Avatar + Name
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: primaryColor.withOpacity(0.2),
                  child: Text(
                    client.companyName[0],
                    style: const TextStyle(fontSize: 40, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  client.companyName,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${client.contactName} • CEO',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    'Outstanding: \$${outstanding.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _actionButton(
                Icons.call,
                'Call',
                () => launchUrl(Uri(scheme: 'tel', path: client.phone)),
              ),
              _actionButton(
                Icons.email,
                'Email',
                () => launchUrl(Uri(scheme: 'mailto', path: client.email)),
              ),
              _actionButton(
                Icons.language,
                'Website',
                () => launchUrl(Uri.parse(client.website)),
              ),
              _actionButton(
                Icons.add_circle,
                'Create',
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => NewInvoiceScreen(client: client),
                  ),
                ),
                primaryColor,
              ),
            ],
          ),

          const SizedBox(height: 32),

          // Tabs
          TabBar(
            tabs: [
              Tab(text: 'Open'),
              Tab(text: 'Paid'),
              Tab(text: 'Projects'),
            ],
          ),

          const SizedBox(height: 16),

          // Invoice List
          ...invoices.map((inv) => InvoiceListItem(invoice: inv)),

          const SizedBox(height: 32),

          // Client Notes
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'CLIENT NOTES',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(client.notes.isEmpty ? 'No notes yet' : client.notes),
                Align(
                  alignment: Alignment.centerRight,
                  child: FloatingActionButton(
                    mini: true,
                    onPressed: () {},
                    child: const Icon(Icons.add),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButton(
    IconData icon,
    String label,
    VoidCallback onTap, [
    Color? color,
  ]) {
    return Column(
      children: [
        IconButton(
          onPressed: onTap,
          icon: Icon(icon, size: 32, color: color ?? Colors.grey[700]),
          padding: const EdgeInsets.all(16),
          constraints: const BoxConstraints(minWidth: 64, minHeight: 64),
          style: IconButton.styleFrom(
            backgroundColor: Colors.grey[100],
            shape: const CircleBorder(),
          ),
        ),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
