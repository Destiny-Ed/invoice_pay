import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_utilities/flutter_utilities.dart';
import 'package:invoice_pay/providers/auth_provider.dart';
import 'package:invoice_pay/screens/authentication/forgot_password.dart';
import 'package:invoice_pay/screens/authentication/register.dart';
import 'package:invoice_pay/screens/main_activity/main_activity.dart';
import 'package:invoice_pay/styles/colors.dart';
import 'package:invoice_pay/styles/theme.dart';
import 'package:invoice_pay/utils/app_locales.dart';
import 'package:invoice_pay/utils/message.dart';
import 'package:invoice_pay/widgets/busy_overlay.dart';
import 'package:invoice_pay/widgets/custom_button.dart';
import 'package:invoice_pay/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
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
                         AppLocale.welcomeBack.getString(context).capitalize(),
                          style: AppTheme.headerStyle().copyWith(fontSize: 32),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          AppLocale.logInToManage.getString(context).capitalize(),
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),

                        const SizedBox(height: 60),

                        // Email Field
                        CustomTextField(
                          auth.emailController,
                          password: false,
                          hint: AppLocale.emailAddress.getString(context).capitalize(),
                          keyboardType: TextInputType.emailAddress,
                          // prefixIcon: const Icon(Icons.email_outlined),
                          // border: OutlineInputBorder(
                          //   borderRadius: BorderRadius.circular(16),
                          //   borderSide: BorderSide(color: greyColor),
                          // ),
                        ),

                        const SizedBox(height: 10),

                        // Password Field
                        CustomTextField(
                          auth.passwordController,
                          hint:AppLocale.password.getString(context).capitalize(),
                          password: true,
                          // prefixIcon: const Icon(Icons.lock_outline),
                          // border: OutlineInputBorder(
                          //   borderRadius: BorderRadius.circular(16),
                          //   borderSide: BorderSide(color: greyColor),
                          // ),
                        ),

                        const SizedBox(height: 16),

                        // Forgot Password
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ForgotPasswordScreen(),
                                ),
                              );
                            },
                            child: Text(
                             AppLocale.forgotPassword.getString(context).capitalize(),
                              style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 40),

                        // Login Button
                        CustomButton(
                          width: double.infinity,
                          onPressed: () async {
                            final email = auth.emailController.text.trim();
                            final password = auth.passwordController.text
                                .trim();

                            if (email.isEmpty || password.isEmpty) {
                              showMessage(
                                context,
                                AppLocale.pleaseFillAllFields.getString(context).capitalize(),
                                isError: true,
                              );
                              return;
                            }

                            if (!FlutterUtilities().isEmailValid(email)) {
                              showMessage(
                                context,
                               AppLocale.pleaseEnterValidEmail.getString(context).capitalize(),
                                isError: true,
                              );
                              return;
                            }

                            await auth.loginUser();

                            if (auth.state == ViewState.Error &&
                                context.mounted) {
                              showMessage(context, auth.message, isError: true);
                              return;
                            }

                            if (auth.state == ViewState.Success &&
                                context.mounted) {
                              showMessage(
                                context,
                                AppLocale.welcomeBack.getString(context),
                              );
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MainActivity(),
                                ),
                                (_) => false,
                              );
                            }
                          },
                          text: AppLocale.logIn.getString(context),
                        ),

                        const SizedBox(height: 40),

                        // Sign Up Link
                        Text.rich(
                          TextSpan(
                            text: AppLocale.dontHaveAccount.getString(context),
                            style: const TextStyle(fontSize: 16),
                            children: [
                              TextSpan(
                                text: AppLocale.signUp
                                    .getString(context)
                                    .capitalize(),
                                style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => RegisterScreen(),
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
