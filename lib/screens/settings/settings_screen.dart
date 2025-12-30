import 'package:cached_network_image/cached_network_image.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:intl/intl.dart';
import 'package:invoice_pay/modal/auth_modal.dart';
import 'package:invoice_pay/screens/onboarding/company_setup.dart';
import 'package:invoice_pay/screens/settings/support_screen.dart';
import 'package:invoice_pay/screens/settings/widgets/custom_widgets.dart';
import 'package:invoice_pay/utils/app_locales.dart';
import 'package:invoice_pay/utils/app_version.dart';
import 'package:invoice_pay/utils/contants.dart';
import 'package:provider/provider.dart';
import 'package:invoice_pay/providers/company_provider.dart';
import 'package:invoice_pay/providers/settings_provider.dart';
import 'package:invoice_pay/styles/colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Consumer2<SettingsProvider, CompanyProvider>(
        builder: (context, settings, companyVm, _) {
          final company = companyVm.company;
          return ListView(
            padding: const EdgeInsets.all(10),
            children: [
              // Profile Card
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: primaryColor,
                        backgroundImage: company?.logoUrl == null
                            ? null
                            : CachedNetworkImageProvider(
                                company?.logoUrl ?? "",
                              ),
                        child: company?.logoUrl == null
                            ? const Icon(
                                Icons.person,
                                size: 30,
                                color: Colors.white,
                              )
                            : SizedBox(),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              company?.name ?? 'Your Business',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              company?.email ?? 'your@email.com',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CompanySetupScreen(),
                            ),
                          );
                        },
                        child: const Icon(Icons.edit, size: 30),
                      ),
                      // ProBadge() // Uncomment when ready
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Preferences
              const _SectionTitle('Preferences'),
              _SettingsTile(
                icon: Icons.track_changes,
                title: AppLocale.monthlyRevenueGoal.getString(context),
                subtitle:
                    'Current: ${company?.currencySymbol ?? '\$'}${NumberFormat('#,##0').format(company?.monthlyGoal ?? 15000)}',
                onTap: () => showGoalModal(context),
              ),

              _SettingsTile(
                icon: Icons.currency_exchange,
                title: AppLocale.defaultCurrency.getString(context),
                subtitle:
                    '${company?.currencySymbol ?? '\$'} ${company?.currencyCode ?? 'USD'}',
                onTap: () {
                  showCurrencyPicker(
                    context: context,
                    onSelect: (c) {
                      companyVm.updateCurrency(c.code, c.symbol);
                    },
                  );
                },
              ),

              // _SwitchTile(
              //   icon: Icons.notifications_outlined,
              //   title: 'Push Notifications',
              //   value: settings.notificationsEnabled,
              //   onChanged: settings.toggleNotifications,
              // ),
              // _SwitchTile(
              //   icon: Icons.dark_mode_outlined,
              //   title: 'Dark Mode',
              //   value: settings.darkMode,
              //   onChanged: settings.toggleDarkMode,
              // ),
              // _SwitchTile(
              //   icon: Icons.alarm,
              //   title: 'Auto Payment Reminders',
              //   value: settings.autoReminders,
              //   onChanged: settings.toggleAutoReminders,
              // ),
              const SizedBox(height: 10),

              // Account
              const _SectionTitle('Account'),
              // _SettingsTile(
              //   icon: Icons.account_balance_wallet,
              //   title: AppLocale.upgradeToPro.getString(context),
              //   subtitle: 'Unlimited invoices, custom branding, no ads',
              //   onTap: () {
              //     // Navigate to pro screen
              //   },
              // ),
              _SettingsTile(
                icon: Icons.security,
                title: AppLocale.privacyAndSecurity.getString(context),
                onTap: () {
                  settings.openUrl(privacyPolicy);
                },
              ),
              _SettingsTile(
                icon: Icons.help_outline,
                title: AppLocale.helpAndSupport.getString(context),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SupportPage()),
                  );
                },
              ),
              _SettingsTile(
                icon: Icons.update,
                title: AppLocale.checkForUpdates.getString(context),
                onTap: settings.checkForUpdate,
              ),

              const SizedBox(height: 10),

              // Danger Zone
              const _SectionTitle('Danger Zone', color: Colors.red),
              _SettingsTile(
                icon: Icons.logout,
                title: AppLocale.logOut.getString(context),
                color: Colors.orange,
                onTap: () => showLogoutDialog(context),
              ),
              _SettingsTile(
                icon: Icons.delete_forever,
                title: AppLocale.deleteAccount.getString(context),
                color: Colors.red,
                onTap: () => showDeleteAccountDialog(context),
              ),

              const SizedBox(height: 20),

              // App Version
              Center(
                child: Text(
                  AppVersion.fullVersion,
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
              ),

              const SizedBox(height: 30),
            ],
          );
        },
      ),
    );
  }
}

// Reusable widgets (same as before, just slightly polished)
class _SectionTitle extends StatelessWidget {
  final String title;
  final Color? color;

  const _SectionTitle(this.title, {this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: color ?? Colors.black87,
        ),
      ),
    );
  }
}

class _SwitchTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool value;
  final Function(bool) onChanged;

  const _SwitchTile({
    required this.icon,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SwitchListTile(
        secondary: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: primaryColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: primaryColor),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        value: value,
        onChanged: onChanged,
        activeColor: primaryColor,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final Color? color;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: (color ?? primaryColor).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color ?? primaryColor),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: color,
          ),
        ),
        subtitle: subtitle != null
            ? Text(subtitle!, style: TextStyle(color: Colors.grey[600]))
            : null,
        trailing: trailing ?? const Icon(Icons.chevron_right),
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
      ),
    );
  }
}
