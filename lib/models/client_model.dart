// models/client_model.dart
import 'package:flutter/material.dart';
import 'package:invoice_pay/styles/colors.dart';

class ClientModel {
  final String id;
  final String companyName;
  final String contactName; // e.g. "Jane Doe"
  final String email;
  final String phone;
  final String website;
  final String notes;
  final double outstandingBalance;
  final String statusTag; // e.g. "$1,200 Overdue" or "All caught up"
  final Color statusColor; // For tag background
  final IconData actionIcon; // Call or Email icon on the right

  ClientModel({
    required this.id,
    required this.companyName,
    required this.contactName,
    required this.email,
    required this.phone,
    this.website = '',
    this.notes = '',
    this.outstandingBalance = 0.0,
    required this.statusTag,
    required this.statusColor,
    required this.actionIcon,
  });

  factory ClientModel.fromMap(String id, Map<String, dynamic> map) {
    final outstanding = (map['outstanding_balance'] ?? 0.0).toDouble();
    String tag;
    Color color;

    if (outstanding > 0) {
      tag = '\$${outstanding.toStringAsFixed(0)} Outstanding';
      color = Colors.orange;
    } else if (outstanding < 0) {
      tag = 'Overpaid';
      color = Colors.purple;
    } else {
      tag = 'All caught up';
      color = primaryColor;
    }

    return ClientModel(
      id: id,
      companyName: map['company_name'] ?? '',
      contactName: map['contact_name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      website: map['website'] ?? '',
      notes: map['notes'] ?? '',
      outstandingBalance: outstanding,
      statusTag: tag,
      statusColor: color,
      actionIcon: map['phone']?.isNotEmpty == true ? Icons.call : Icons.email,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'company_name': companyName,
      'contact_name': contactName,
      'email': email,
      'phone': phone,
      'website': website,
      'notes': notes,
      'outstanding_balance': outstandingBalance,
    };
  }
}
