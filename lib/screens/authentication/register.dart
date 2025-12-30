import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_utilities/flutter_utilities.dart';
import 'package:invoice_pay/providers/auth_provider.dart';
import 'package:invoice_pay/screens/authentication/login.dart';
import 'package:invoice_pay/screens/onboarding/company_setup.dart';
import 'package:invoice_pay/styles/colors.dart';
import 'package:invoice_pay/styles/theme.dart';
import 'package:invoice_pay/utils/app_locales.dart';
import 'package:invoice_pay/utils/contants.dart';
import 'package:invoice_pay/utils/message.dart';
import 'package:invoice_pay/widgets/busy_overlay.dart';
import 'package:invoice_pay/widgets/custom_button.dart';
import 'package:invoice_pay/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationProviderImpl>(
      builder: (context, auth, _) {
        return BusyOverlay(
          show: auth.state == ViewState.Busy,
          title: auth.message,
          child: Scaffold(
            body: FadeTransition(
              opacity: _fadeAnimation,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Logo
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: primaryColor.withOpacity(0.3),
                                blurRadius: 30,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.receipt_long,
                            size: 60,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(height: 40),

                        Text(
                          AppLocale.createAccount.getString(context),
                          style: AppTheme.headerStyle().copyWith(fontSize: 32),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          AppLocale.startSendingInvoices.getString(context),
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),

                        const SizedBox(height: 60),

                        // Name
                        CustomTextField(
                          auth.userNameController,
                          hint: AppLocale.fullName.getString(context),
                          password: false,
                          // prefixIcon: const Icon(Icons.person_outline),
                          // border: OutlineInputBorder(
                          //   borderRadius: BorderRadius.circular(16),
                          // ),
                        ),

                        const SizedBox(height: 10),

                        // Email
                        CustomTextField(
                          auth.emailController,
                          hint: AppLocale.emailAddress.getString(context),
                          password: false,
                          keyboardType: TextInputType.emailAddress,
                          // prefixIcon: const Icon(Icons.email_outlined),
                          // border: OutlineInputBorder(
                          //   borderRadius: BorderRadius.circular(16),
                          // ),
                        ),

                        const SizedBox(height: 10),

                        // Password
                        CustomTextField(
                          auth.passwordController,
                          hint: AppLocale.password.getString(context),
                          password: true,
                          // prefixIcon: const Icon(Icons.lock_outline),
                          // border: OutlineInputBorder(
                          //   borderRadius: BorderRadius.circular(16),
                          // ),
                        ),

                        const SizedBox(height: 24),

                        // Terms Checkbox
                        Row(
                          children: [
                            Checkbox(
                              value: auth.isTermsAccepted,
                              onChanged: (v) =>
                                  auth.isTermsAccepted = v ?? false,
                              activeColor: primaryColor,
                              shape: StadiumBorder(),
                            ),
                            Expanded(
                              child: Text.rich(
                                TextSpan(
                                  text: AppLocale.iAgreeTo.getString(context),
                                  children: [
                                    TextSpan(
                                      text: AppLocale.termsOfService.getString(
                                        context,
                                      ),
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () => launchUrl(
                                          Uri.parse(termsOfService),
                                        ),
                                    ),
                                    TextSpan(
                                      text: AppLocale.and.getString(context),
                                    ),
                                    TextSpan(
                                      text: AppLocale.privacyPolicy.getString(
                                        context,
                                      ),
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () =>
                                            launchUrl(Uri.parse(privacyPolicy)),
                                    ),
                                  ],
                                ),
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 40),

                        // Register Button
                        CustomButton(
                          width: double.infinity,
                          onPressed: () async {
                            final name = auth.userNameController.text.trim();
                            final email = auth.emailController.text.trim();
                            final password = auth.passwordController.text
                                .trim();

                            if (name.isEmpty ||
                                email.isEmpty ||
                                password.isEmpty) {
                              showMessage(
                                context,
                                AppLocale.allFieldsRequired.getString(context),
                                isError: true,
                              );
                              return;
                            }

                            if (!FlutterUtilities().isEmailValid(email)) {
                              showMessage(
                                context,
                                AppLocale.invalidEmail.getString(context),
                                isError: true,
                              );
                              return;
                            }

                            if (password.length < 6) {
                              showMessage(
                                context,
                                AppLocale.passwordTooShort.getString(context),
                                isError: true,
                              );
                              return;
                            }

                            if (!auth.isTermsAccepted) {
                              showMessage(
                                context,
                                AppLocale.acceptTerms.getString(context),
                                isError: true,
                              );
                              return;
                            }

                            await auth.registerUser();

                            if (auth.state == ViewState.Error &&
                                context.mounted) {
                              showMessage(context, auth.message, isError: true);
                              return;
                            }

                            if (auth.state == ViewState.Success &&
                                context.mounted) {
                              showMessage(
                                context,
                                AppLocale.accountCreatedSuccess.getString(
                                  context,
                                ),
                              );

                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CompanySetupScreen(),
                                ),
                                (_) => false,
                              );
                            }
                          },
                          text: AppLocale.createAccount.getString(context),
                        ),

                        const SizedBox(height: 20),

                        // Login Link
                        Text.rich(
                          TextSpan(
                            text: AppLocale.alreadyHaveAccount.getString(
                              context,
                            ),
                            style: const TextStyle(fontSize: 16),
                            children: [
                              TextSpan(
                                text: AppLocale.logIn.getString(context),
                                style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginScreen(),
                                      ),
                                    );
                                  },
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
