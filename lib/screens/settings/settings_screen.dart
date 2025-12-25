import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:invoice_pay/modal/auth_modal.dart';
import 'package:invoice_pay/utils/message.dart';
import 'package:invoice_pay/widgets/custom_button.dart';
import 'package:provider/provider.dart';
import 'package:invoice_pay/providers/company_provider.dart';
import 'package:invoice_pay/providers/settings_provider.dart';
import 'package:invoice_pay/styles/colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void _showGoalModal(BuildContext context) {
    final companyProvider = context.read<CompanyProvider>();
    final currentGoal = companyProvider.company?.monthlyGoal ?? 5000.0;
    final controller = TextEditingController(
      text: currentGoal.toStringAsFixed(0),
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 32,
          left: 32,
          right: 32,
          top: 32,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Set Monthly Revenue Goal',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Track your progress on the dashboard',
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: controller,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                prefixText: '  \$ ',
                hintText: '5000',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                filled: true,
                fillColor: Colors.grey[50],
                contentPadding: const EdgeInsets.symmetric(vertical: 24),
              ),
            ),
            const SizedBox(height: 20),
            CustomButton(
              onPressed: () {
                final newGoal =
                    double.tryParse(
                      controller.text.replaceAll(RegExp(r'[^0-9]'), ''),
                    ) ??
                    currentGoal;
                companyProvider.updateMonthlyGoal(newGoal);
                Navigator.pop(context);
                showMessage(
                  context,
                  'Goal updated to \$${NumberFormat('#,##0').format(newGoal)}',
                );
              },

              text: 'Save Goal',
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();
    final company = context.watch<CompanyProvider>().company;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Profile Card
          Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: primaryColor,
                    child: const Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.white,
                    ),
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
                  // ProBadge() // Uncomment when ready
                ],
              ),
            ),
          ),

          const SizedBox(height: 40),

          // Preferences
          const _SectionTitle('Preferences'),
          _SettingsTile(
            icon: Icons.track_changes,
            title: 'Monthly Revenue Goal',
            subtitle:
                'Current: \$${NumberFormat('#,##0').format(company?.monthlyGoal ?? 15000)}',
            onTap: () => _showGoalModal(context),
          ),
          _SwitchTile(
            icon: Icons.notifications_outlined,
            title: 'Push Notifications',
            value: settings.notificationsEnabled,
            onChanged: settings.toggleNotifications,
          ),
          _SwitchTile(
            icon: Icons.dark_mode_outlined,
            title: 'Dark Mode',
            value: settings.darkMode,
            onChanged: settings.toggleDarkMode,
          ),
          _SwitchTile(
            icon: Icons.alarm,
            title: 'Auto Payment Reminders',
            value: settings.autoReminders,
            onChanged: settings.toggleAutoReminders,
          ),

          const SizedBox(height: 40),

          // Account
          const _SectionTitle('Account'),
          _SettingsTile(
            icon: Icons.account_balance_wallet,
            title: 'Upgrade to Pro',
            subtitle: 'Unlimited invoices, custom branding, no ads',
            onTap: () {
              // Navigate to pro screen
            },
          ),
          _SettingsTile(
            icon: Icons.security,
            title: 'Privacy & Security',
            onTap: () {
              settings.openUrl('https://invoicepay.app/privacy');
            },
          ),
          _SettingsTile(
            icon: Icons.help_outline,
            title: 'Help & Support',
            onTap: () => settings.openUrl('https://invoicepay.app/support'),
          ),
          _SettingsTile(
            icon: Icons.update,
            title: 'Check for Updates',
            onTap: settings.checkForUpdate,
          ),

          const SizedBox(height: 40),

          // Danger Zone
          const _SectionTitle('Danger Zone', color: Colors.red),
          _SettingsTile(
            icon: Icons.logout,
            title: 'Log Out',
            color: Colors.orange,
            onTap: () => showLogoutDialog(context),
          ),
          _SettingsTile(
            icon: Icons.delete_forever,
            title: 'Delete Account',
            color: Colors.red,
            onTap: () => showDeleteAccountDialog(context),
          ),

          const SizedBox(height: 60),

          // App Version
          Center(
            child: Text(
              'InvoicePay v1.0.0',
              style: TextStyle(color: Colors.grey[500], fontSize: 14),
            ),
          ),
        ],
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
      padding: const EdgeInsets.only(left: 8, bottom: 12),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
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
      elevation: 4,
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
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        value: value,
        onChanged: onChanged,
        activeColor: primaryColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
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
      elevation: 4,
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
            fontSize: 16,
            color: color,
          ),
        ),
        subtitle: subtitle != null
            ? Text(subtitle!, style: TextStyle(color: Colors.grey[600]))
            : null,
        trailing: trailing ?? const Icon(Icons.chevron_right),
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
      ),
    );
  }
}
