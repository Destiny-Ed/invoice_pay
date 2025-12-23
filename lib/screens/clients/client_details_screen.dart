import 'package:flutter/material.dart';
import 'package:invoice_pay/config/extension.dart';
import 'package:invoice_pay/models/client_model.dart';
import 'package:invoice_pay/models/invoice_model.dart';
import 'package:invoice_pay/providers/client_provider.dart';
import 'package:invoice_pay/screens/invoice/create_invoice_screen.dart';
import 'package:invoice_pay/widgets/custom_button.dart';
import 'package:invoice_pay/widgets/invoice_list_item.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:invoice_pay/styles/colors.dart';

class ClientDetailScreen extends StatefulWidget {
  final ClientModel client;
  final List<InvoiceModel> invoices;

  const ClientDetailScreen({
    super.key,
    required this.client,
    required this.invoices,
  });

  @override
  State<ClientDetailScreen> createState() => _ClientDetailScreenState();
}

class _ClientDetailScreenState extends State<ClientDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Filter invoices by tab
  List<InvoiceModel> _getInvoicesForTab(int index) {
    switch (index) {
      case 0: // Open
        return widget.invoices
            .where((inv) => inv.status != InvoiceStatus.paid)
            .toList();
      case 1: // Paid
        return widget.invoices
            .where((inv) => inv.status == InvoiceStatus.paid)
            .toList();
      case 2: // Projects (future use — show all for now)
        return widget.invoices;
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final outstanding = widget.invoices.fold(
      0.0,
      (sum, inv) => sum + inv.balanceDue,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Client Details'),
        // actions: [
        //   TextButton(
        //     onPressed: () {
        //       // Edit client
        //     },
        //     child: const Text('Edit', style: TextStyle(color: primaryColor)),
        //   ),
        // ],
      ),
      body: Column(
        children: [
          // Header Section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Avatar + Name
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: primaryColor.withOpacity(0.2),
                        child: Text(
                          widget.client.companyName.isNotEmpty
                              ? widget.client.companyName[0].toUpperCase()
                              : '?',
                          style: TextStyle(
                            fontSize: 20,
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.client.companyName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.client.contactName,
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: outstanding > 0
                              ? Colors.red.shade100
                              : Colors.green.shade100,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          outstanding > 0
                              ? 'Outstanding: \$${outstanding.toStringAsFixed(2)}'
                              : 'All caught up',
                          style: TextStyle(
                            color: outstanding > 0 ? Colors.red : Colors.green,
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
                    if (widget.client.phone.isNotEmpty)
                      _actionButton(
                        Icons.call,
                        'Call',
                        () => launchUrl(
                          Uri(scheme: 'tel', path: widget.client.phone),
                        ),
                      ),
                    _actionButton(
                      Icons.email,
                      'Email',
                      () => launchUrl(
                        Uri(scheme: 'mailto', path: widget.client.email),
                      ),
                    ),
                    if (widget.client.website.isNotEmpty)
                      _actionButton(
                        Icons.language,
                        'Website',
                        () => launchUrl(
                          Uri.parse(
                            widget.client.website.isEmpty
                                ? 'https://invoicepay.netlify.app'
                                : widget.client.website,
                          ),
                        ),
                      ),
                    _actionButton(
                      Icons.add_circle,
                      'Create',
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              NewInvoiceScreen(client: widget.client),
                        ),
                      ),
                      primaryColor,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Tabs
          Container(
            color: Colors.grey[100],
            child: TabBar(
              controller: _tabController,
              labelColor: primaryColor,
              unselectedLabelColor: Colors.grey[600],
              indicatorColor: primaryColor,
              tabs: const [
                Tab(text: 'Open'),
                Tab(text: 'Paid'),
                Tab(text: 'Projects'),
              ],
            ),
          ),

          // Tab Views
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Open Tab
                _buildInvoiceList(_getInvoicesForTab(0)),

                // Paid Tab
                _buildInvoiceList(_getInvoicesForTab(1)),

                // Projects Tab (Placeholder or future use)
                _buildProjectsTab(),
              ],
            ),
          ),

          Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  spacing: 10,
                  children: [
                    const Icon(Icons.note, color: primaryColor),
                    const Text(
                      'CLIENT NOTES',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  widget.client.notes.isEmpty
                      ? 'No notes yet. Tap right icon to add.'
                      : widget.client.notes,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[800],
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),

          80.height(),
        ],
      ),

      // Floating Notes Button
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          showNotesModal(context: context, client: widget.client);
        },
        child: const Icon(Icons.note_add),
      ),
    );
  }

  Widget _buildInvoiceList(List<InvoiceModel> invoices) {
    if (invoices.isEmpty) {
      return const Center(
        child: Text('No invoices', style: TextStyle(color: Colors.grey)),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: invoices.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: InvoiceListItem(invoice: invoices[index]),
        );
      },
    );
  }

  Widget _buildProjectsTab() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.folder_open, size: 80, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'No projects yet',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          Text('Projects coming soon', style: TextStyle(color: Colors.grey)),
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

  Future<void> showNotesModal({
    required BuildContext context,
    required ClientModel client,
  }) async {
    final TextEditingController notesCtrl = TextEditingController(
      text: client.notes,
    );
    bool isSaving = false;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      backgroundColor: Colors.white,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setStateModal) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: DraggableScrollableSheet(
                initialChildSize: 0.5,
                minChildSize: 0.5,
                expand: false,
                builder: (_, controller) {
                  return Column(
                    children: [
                      // Handle
                      Container(
                        margin: const EdgeInsets.only(top: 12),
                        width: 40,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                        child: Row(
                          children: [
                            const Text(
                              'Client Notes',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text(
                                'Cancel',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Divider(height: 1),

                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: TextField(
                            controller: notesCtrl,
                            maxLines: null,
                            decoration: InputDecoration(
                              hintText:
                                  'Add notes about this client...\ne.g. Payment terms, preferences, contact person, etc.',
                              hintStyle: TextStyle(
                                color: Colors.grey[500],
                                fontStyle: FontStyle.italic,
                              ),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                            style: const TextStyle(fontSize: 16, height: 1.6),
                          ),
                        ),
                      ),

                      // Save Button
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: SizedBox(
                          width: double.infinity,
                          child: CustomButton(
                            onPressed: () async {
                              if (isSaving) return;
                              setStateModal(() => isSaving = true);
                              await context
                                  .read<ClientProvider>()
                                  .updateClientNotes(client.id, notesCtrl.text);
                              if (context.mounted) Navigator.pop(context);
                            },

                            text: isSaving ? "Please wait..." : "Save Notes",
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
