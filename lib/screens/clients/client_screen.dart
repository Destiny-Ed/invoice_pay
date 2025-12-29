import 'package:flutter/material.dart';
import 'package:invoice_pay/modal/single_select_modal.dart';
import 'package:invoice_pay/models/client_model.dart';
import 'package:invoice_pay/providers/auth_provider.dart';
import 'package:invoice_pay/providers/client_provider.dart';
import 'package:invoice_pay/styles/colors.dart';
import 'package:invoice_pay/utils/message.dart';
import 'package:invoice_pay/widgets/busy_overlay.dart';
import 'package:invoice_pay/widgets/custom_button.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../widgets/client_card.dart';

class ClientsScreen extends StatelessWidget {
  const ClientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Clients'), centerTitle: false),
      body: Consumer<ClientProvider>(
        builder: (context, provider, _) {
          if (provider.viewState == ViewState.Busy) {
            return BusyOverlay(
              show: true,
              child: SizedBox(height: MediaQuery.of(context).size.height),
            );
          }
          if (provider.clients.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.receipt_long_outlined,
                    size: 80,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'No clients found',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap + to add your first client',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            itemCount: provider.clients.length,
            itemBuilder: (context, i) =>
                ClientCard(client: provider.clients[i]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () => _showAddClient(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  // In your ClientsScreen or wherever you call _showAddClient
  void _showAddClient(BuildContext context) {
    final TextEditingController nameCtrl = TextEditingController();
    final TextEditingController companyCtrl = TextEditingController();
    final TextEditingController emailCtrl = TextEditingController();
    final TextEditingController phoneCtrl = TextEditingController();
    final TextEditingController websiteCtrl = TextEditingController();
    String selectedIndustry = 'Technology'; // Default

    final List<String> industries = [
      'Technology',
      'Healthcare',
      'Finance',
      'Education',
      'Retail',
      'Real Estate',
      'Marketing',
      'Design',
      'Consulting',
      'Manufacturing',
      'Hospitality',
      'Other',
    ];

    final provider = context.read<ClientProvider>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      backgroundColor: Colors.white,
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom,
          ),
          child: DraggableScrollableSheet(
            initialChildSize: 0.7,
            minChildSize: 0.7,
            expand: false,
            builder: (_, controller) {
              return StatefulBuilder(
                builder: (context, setState) {
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

                      Expanded(
                        child: ListView(
                          controller: controller,
                          padding: const EdgeInsets.all(14),
                          children: [
                            const Text(
                              'New Client',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Add client details to start invoicing',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),

                            const SizedBox(height: 22),

                            // Contact Name
                            TextField(
                              controller: nameCtrl,
                              decoration: InputDecoration(
                                labelText: 'Contact Name',
                                prefixIcon: const Icon(Icons.person_outline),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                filled: true,
                                fillColor: Colors.grey[50],
                              ),
                            ),

                            const SizedBox(height: 10),

                            // Company Name
                            TextField(
                              controller: companyCtrl,
                              decoration: InputDecoration(
                                labelText: 'Company Name',
                                prefixIcon: const Icon(Icons.business),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                filled: true,
                                fillColor: Colors.grey[50],
                              ),
                            ),

                            const SizedBox(height: 10),
                            TextField(
                              controller: websiteCtrl,
                              decoration: InputDecoration(
                                labelText: 'Company Website',
                                prefixIcon: const Icon(Icons.web),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                filled: true,
                                fillColor: Colors.grey[50],
                              ),
                            ),

                            const SizedBox(height: 10),

                            // Email
                            TextField(
                              controller: emailCtrl,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                prefixIcon: const Icon(Icons.email_outlined),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                filled: true,
                                fillColor: Colors.grey[50],
                              ),
                            ),

                            const SizedBox(height: 10),

                            // Phone
                            TextField(
                              controller: phoneCtrl,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                labelText: 'Phone Number',
                                prefixIcon: const Icon(Icons.phone_outlined),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                filled: true,
                                fillColor: Colors.grey[50],
                              ),
                            ),

                            const SizedBox(height: 10),

                            // Industry Dropdown
                            GestureDetector(
                              onTap: () async {
                                final selected = await showSingleSelectModal(
                                  context: context,
                                  title: 'Select Industry',
                                  items: industries,
                                  selectedItem: selectedIndustry,
                                );
                                if (selected != null) {
                                  setState(() => selectedIndustry = selected);
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 20,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[400]!),
                                  borderRadius: BorderRadius.circular(16),
                                  color: Colors.grey[50],
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.work_outline,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Text(
                                        selectedIndustry,
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    const Icon(Icons.arrow_drop_down),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(height: 30),

                            // Add Client Button
                            SizedBox(
                              width: double.infinity,
                              child: CustomButton(
                                onPressed: () async {
                                  // Save client logic here
                                  final client = ClientModel(
                                    id: Uuid().v4(),
                                    contactName: nameCtrl.text.trim(),
                                    companyName: companyCtrl.text.trim(),
                                    email: emailCtrl.text.trim(),
                                    phone: phoneCtrl.text.trim(),
                                    website: websiteCtrl.text.trim(),
                                    statusTag: '',
                                    statusColor: primaryColor,
                                    actionIcon: Icons.person,
                                    // Add industry field to model if needed
                                  );
                                  if (nameCtrl.text.isEmpty ||
                                      companyCtrl.text.isEmpty ||
                                      emailCtrl.text.isEmpty) {
                                    showMessage(
                                      context,
                                      "All fields are required",
                                    );
                                    return;
                                  }

                                  await provider.addClient(client);

                                  if (provider.viewState == ViewState.Error) {
                                    showMessage(context, provider.errorMessage);
                                    return;
                                  }
                                  Navigator.pop(context);
                                },

                                text: "Add Client",
                              ),
                            ),

                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
