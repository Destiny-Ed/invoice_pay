import 'package:flutter/material.dart';
import 'package:invoice_pay/styles/colors.dart';
import 'package:provider/provider.dart';
import '../../providers/settings_provider.dart';
import '../../providers/auth_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settings, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Settings'),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Profile Section
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListTile(
                  leading: const CircleAvatar(
                    radius: 30,
                    backgroundColor: primaryColor,
                    child: Icon(Icons.person, color: Colors.white, size: 32),
                  ),
                  title: const Text(
                    'Alex Freeman',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  subtitle: const Text('alex@freelance.com'),
                  // trailing: const ProBadge(),
                ),
              ),

              const SizedBox(height: 32),

              // Preferences
              const _SectionTitle('Preferences'),
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

              const SizedBox(height: 32),

              // Account
              const _SectionTitle('Account'),
              _SettingsTile(
                icon: Icons.account_balance_wallet,
                title: 'Upgrade to Pro',
                subtitle: 'Unlimited invoices, custom branding, no ads',
                // trailing: const ProBadge(),
                onTap: () {
                  // context.push('/pro');
                },
              ),
              _SettingsTile(
                icon: Icons.security,
                title: 'Privacy & Security',
                onTap: () {
                  // context.push('/privacy');
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

              const SizedBox(height: 32),

              // Danger Zone
              const _SectionTitle('Danger Zone', color: Colors.red),
              _SettingsTile(
                icon: Icons.logout,
                title: 'Log Out',
                color: Colors.orange,
                onTap: () async {
                  await context.read<AuthenticationProviderImpl>().logoutUser();
                  // context.go('/login');
                },
              ),
              _SettingsTile(
                icon: Icons.delete_forever,
                title: 'Delete Account',
                color: Colors.red,
                onTap: () {
                  // Show confirmation + password re-entry
                },
              ),

              const SizedBox(height: 40),

              // App Version
              const Center(
                child: Text(
                  'InvoicePay v1.0.0',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

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
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: color ?? Colors.grey[800],
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SwitchListTile(
        secondary: Icon(icon, color: primaryColor),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        value: value,
        onChanged: onChanged,
        activeColor: primaryColor,
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: Icon(icon, color: color ?? primaryColor),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w600, color: color),
        ),
        subtitle: subtitle != null ? Text(subtitle!) : null,
        trailing: trailing ?? const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
