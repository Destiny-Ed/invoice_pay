import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:invoice_pay/modal/color_picker_modal.dart';
import 'package:invoice_pay/providers/auth_provider.dart';
import 'package:invoice_pay/providers/company_provider.dart';
import 'package:invoice_pay/screens/dashboard/dashboard.dart';
import 'package:invoice_pay/screens/main_activity/main_activity.dart';
import 'package:invoice_pay/screens/onboarding/onboarding_progress.dart';
import 'package:invoice_pay/styles/colors.dart';
import 'package:invoice_pay/styles/theme.dart';
import 'package:invoice_pay/utils/app_locales.dart';
import 'package:invoice_pay/utils/message.dart';
import 'package:invoice_pay/widgets/busy_overlay.dart';
import 'package:invoice_pay/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class InvoiceTemplateSetupScreen extends StatefulWidget {
  const InvoiceTemplateSetupScreen({super.key});

  @override
  State<InvoiceTemplateSetupScreen> createState() =>
      _InvoiceTemplateSetupScreenState();
}

class _InvoiceTemplateSetupScreenState extends State<InvoiceTemplateSetupScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;

  final List<Color> colors = [
    primaryColor,
    Colors.green, // Blue
    const Color(0xFF8B5CF6), // Purple
    const Color(0xFFEF4444), // Red
    const Color(0xFFF97316), // Orange
  ];

  final List<Map<String, String>> fonts = [
    {
      'family': GoogleFonts.aBeeZee().fontFamily ?? "",
      'display': GoogleFonts.aBeeZee().fontFamily ?? "",
      'subtitle': 'AbeeZee',
    },
    {
      'family': GoogleFonts.notable().fontFamily ?? "",
      'display': GoogleFonts.notable().fontFamily ?? "",
      'subtitle': 'Notable (Default)',
    },
    {
      'family': GoogleFonts.dmSans().fontFamily ?? "",
      'display': GoogleFonts.dmSans().fontFamily ?? "",
      'subtitle': 'DmSans (Default)',
    },
    {
      'family': GoogleFonts.dmSerifDisplay().fontFamily ?? "",
      'display': GoogleFonts.dmSerifDisplay().fontFamily ?? "",
      'subtitle': 'Serif',
    },
    {
      'family': GoogleFonts.robotoMono().fontFamily ?? "",
      'display': GoogleFonts.robotoMono().fontFamily ?? "",
      'subtitle': 'Roboto Mono',
    },
  ];

  Color selectedColor = primaryColor;
  String selectedFont = GoogleFonts.aBeeZee().fontFamily ?? "";

  void _pickPrimaryColor(BuildContext context) async {
    final color = await showColorPickerModal(
      context: context,
      initialColor: selectedColor,
      title:  AppLocale.primaryColor.getString(context),
    );

    if (color != null) {
      setState(() {
        selectedColor = color;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fade = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadSavedDetails();
    });
  }

  void _loadSavedDetails() {
    final provider = context.read<CompanyProvider>();
    final company = provider.company;

    if (company != null) {
      selectedColor = company.primaryColor;
      selectedFont = company.fontFamily;

      setState(() {});
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CompanyProvider>();

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: FadeTransition(
        opacity: _fade,
        child: BusyOverlay(
          show: provider.viewState == ViewState.Busy,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const OnboardingProgress(currentStep: 1, totalSteps: 2),
                const SizedBox(height: 10),

                Text(
                  AppLocale.customizeYourLook.getString(context),
                  style: AppTheme.headerStyle().copyWith(fontSize: 30),
                ),
                const SizedBox(height: 10),

                Text(
                  AppLocale.chooseColorAndFont.getString(context),
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),

                const SizedBox(height: 20),

                // Live Preview Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: selectedColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: selectedColor.withOpacity(0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: Colors.grey[300],
                            backgroundImage: provider.logoUrl == null
                                ? null
                                : CachedNetworkImageProvider(
                                    provider.logoUrl ?? "",
                                  ),
                            child: provider.logoUrl == null
                                ? const Text(
                                    'LOGO',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : SizedBox(),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Invoice #1023',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: selectedColor,
                                  ),
                                ),
                                Text(
                                  'Due in 14 days',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '${provider.selectedCurrencySymbol}4,250.00',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: selectedColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Billed to',
                        style: TextStyle(color: Colors.grey),
                      ),
                      const Text(
                        'Acme Corp.',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 10),

                      const Text('Date', style: TextStyle(color: Colors.grey)),
                      const Text('Oct 24, 2023'),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: selectedColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            'PENDING',
                            style: TextStyle(
                              color: selectedColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Center(
                        child: Text(
                          'LIVE PREVIEW',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Primary Color Section
                  Text(
                   AppLocale.primaryColor.getString(context).toUpperCase(),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: colors.map((color) {
                    final bool isSelected = color == selectedColor;
                    return GestureDetector(
                      onTap: () => setState(() => selectedColor = color),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isSelected
                                    ? Colors.black
                                    : Colors.transparent,
                                width: 4,
                              ),
                              boxShadow: isSelected
                                  ? [
                                      BoxShadow(
                                        color: color.withOpacity(0.4),
                                        blurRadius: 16,
                                        spreadRadius: 4,
                                      ),
                                    ]
                                  : null,
                            ),
                          ),
                          if (isSelected)
                            const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 20,
                            ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 10),

                Center(
                  child: GestureDetector(
                    onTap: () {
                      _pickPrimaryColor(context);
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey[400]!, width: 2),
                      ),
                      child: const Icon(Icons.add, color: Colors.grey),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Typography Section
                  Text(
                   AppLocale.typography.getString(context).toUpperCase(),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                ...fonts.map((fontData) {
                  final String family = fontData['family']!;
                  final String display = fontData['display']!;
                  final String subtitle = fontData['subtitle']!;
                  final bool isSelected = selectedFont == family;

                  return GestureDetector(
                    onTap: () => setState(() => selectedFont = family),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? selectedColor.withOpacity(0.1)
                            : Colors.grey[100],
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected
                              ? selectedColor
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Aa',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: family,
                              color: isSelected
                                  ? selectedColor
                                  : Colors.black87,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  display.replaceAll("_", " "),
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: family,
                                  ),
                                ),
                                Text(
                                  subtitle,
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontFamily: family,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (isSelected)
                            Icon(
                              Icons.check_circle,
                              color: selectedColor,
                              size: 22,
                            ),
                        ],
                      ),
                    ),
                  );
                }),

                const SizedBox(height: 10),

                // Bottom Buttons
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MainActivity(),
                            ),
                            (_) => false,
                          );
                        },
                        text:  AppLocale.skip.getString(context),
                        bgColor: Colors.grey[400]!,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: CustomButton(
                        onPressed: () async {
                          provider.primaryColor = selectedColor;
                          provider.fontFamily = selectedFont;
                          await provider.saveCompanyDetails();

                          if (provider.viewState == ViewState.Error) {
                            showMessage(context, provider.message);
                            return;
                          }
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MainActivity(),
                            ),
                            (_) => false,
                          );
                        },
                        text:  AppLocale.finishSetup.getString(context),
                        bgColor: selectedColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
