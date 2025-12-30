import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_utilities/flutter_utilities.dart';
import 'package:invoice_pay/providers/auth_provider.dart';
import 'package:invoice_pay/styles/colors.dart';
import 'package:invoice_pay/styles/theme.dart';
import 'package:invoice_pay/utils/app_locales.dart';
import 'package:invoice_pay/utils/message.dart';
import 'package:invoice_pay/widgets/busy_overlay.dart';
import 'package:invoice_pay/widgets/custom_button.dart';
import 'package:invoice_pay/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationProviderImpl>(
      builder: (context, auth, _) {
        return BusyOverlay(
          show: auth.state == ViewState.Busy,
          title: auth.message,
          child: Scaffold(
            appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.lock_reset,
                      size: 60,
                      color: primaryColor,
                    ),
                  ),

                  const SizedBox(height: 40),

                  Text(
                   AppLocale.resetPassword.getString(context).capitalize(),
                    style: AppTheme.headerStyle().copyWith(fontSize: 32),
                  ),
                  const SizedBox(height: 16),
                  Text(
                   AppLocale.resetDesc.getString(context).capitalize(),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),

                  const SizedBox(height: 60),

                  CustomTextField(
                    auth.emailController,
                    hint:AppLocale.emailAddress.getString(context).capitalize(),
                    keyboardType: TextInputType.emailAddress,
                    // prefixIcon: const Icon(Icons.email_outlined),
                  ),

                  const SizedBox(height: 40),

                  CustomButton(
                    width: double.infinity,
                    onPressed: () async {
                      final email = auth.emailController.text.trim();

                      if (email.isEmpty) {
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
                         AppLocale.invalidEmail.getString(context).capitalize(),
                          isError: true,
                        );
                        return;
                      }

                      await auth.forgotPassword();

                      if (auth.state == ViewState.Success && context.mounted) {
                        showMessage(
                          context,
                          'Reset link sent! Check your email.',
                        );
                        Navigator.pop(context);
                      } else if (auth.state == ViewState.Error &&
                          context.mounted) {
                        showMessage(context, auth.message, isError: true);
                      }
                    },
                    text: AppLocale.sendResetLink.getString(context).capitalize(),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
