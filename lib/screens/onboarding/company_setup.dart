import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:invoice_pay/providers/auth_provider.dart';
import 'package:invoice_pay/providers/company_provider.dart';
import 'package:invoice_pay/screens/onboarding/onboarding_progress.dart';
import 'package:invoice_pay/screens/onboarding/template_setup_screen.dart';
import 'package:invoice_pay/styles/colors.dart';
import 'package:invoice_pay/styles/theme.dart';
import 'package:invoice_pay/utils/message.dart';
import 'package:invoice_pay/widgets/busy_overlay.dart';
import 'package:invoice_pay/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class CompanySetupScreen extends StatefulWidget {
  const CompanySetupScreen({super.key});

  @override
  State<CompanySetupScreen> createState() => _CompanySetupScreenState();
}

class _CompanySetupScreenState extends State<CompanySetupScreen> {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _streetCtrl = TextEditingController();
  final _cityCtrl = TextEditingController();
  final _zipCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CompanyProvider>();

    return Scaffold(
      body: SafeArea(
        child: BusyOverlay(
          show: provider.viewState == ViewState.Busy,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const OnboardingProgress(currentStep: 0, totalSteps: 2),

                const SizedBox(height: 10),

                Text(
                  'Set up your profile',
                  style: AppTheme.headerStyle().copyWith(fontSize: 30),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Add your company details to look professional on your invoices.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),

                const SizedBox(height: 20),

                // Logo Upload
                Center(
                  child: GestureDetector(
                    onTap: () => provider.uploadLogo(),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.grey[200],
                      child: (provider.logoUrl ?? "").isEmpty
                          ? const Icon(
                              Icons.camera_alt,
                              size: 40,
                              color: Colors.grey,
                            )
                          : ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: provider.logoUrl!,
                                fit: BoxFit.cover,
                                width: 120,
                                height: 120,
                              ),
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: GestureDetector(
                    onTap: () => provider.uploadLogo(),
                    child: Text(
                      'Tap to upload logo',
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Company Name
                const Text(
                  'Company Name',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _nameCtrl,
                  decoration: InputDecoration(
                    hintText: 'e.g. Acme Studio',
                    prefixIcon: const Icon(Icons.business),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                ),

                const SizedBox(height: 10),

                // Business Email
                const Text(
                  'Business Email',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'name@company.com',
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                ),

                const SizedBox(height: 10),

                // Phone Number
                const Text(
                  'Phone Number',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _phoneCtrl,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: '+1 (555) 000-0000',
                    prefixIcon: const Icon(Icons.phone),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                ),

                const SizedBox(height: 10),

                // Business Address
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Business Address',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    // TextButton(
                    //   onPressed: () {},
                    //   child: Text(
                    //     'Use current location',
                    //     style: TextStyle(
                    //       color: primaryColor,
                    //       fontWeight: FontWeight.w600,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),

                const SizedBox(height: 8),
                TextFormField(
                  controller: _streetCtrl,
                  decoration: InputDecoration(
                    hintText: 'Address',
                    prefixIcon: const Icon(Icons.location_city),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                ),

                const SizedBox(height: 30),

                // Next Button
                CustomButton(
                  onPressed: () {
                    if (_nameCtrl.text.isEmpty ||
                        _emailCtrl.text.isEmpty ||
                        _phoneCtrl.text.isEmpty ||
                        _streetCtrl.text.isEmpty) {
                      showMessage(
                        context,
                        "All Fields are required",
                        isError: true,
                      );
                      return;
                    }

                    provider.companyName = _nameCtrl.text;
                    provider.email = _emailCtrl.text;
                    provider.phone = _phoneCtrl.text;
                    provider.street = _streetCtrl.text;
                    // provider.city = _cityCtrl.text;
                    // provider.zip = _zipCtrl.text;

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InvoiceTemplateSetupScreen(),
                      ),
                    );
                  },
                  text: "Next Step →",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
