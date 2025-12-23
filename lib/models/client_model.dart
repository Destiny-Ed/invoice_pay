// models/client_model.dart
import 'package:flutter/material.dart';
import 'package:invoice_pay/styles/colors.dart';

class ClientModel {
  final String id;
  final String companyName;
  final String contactName;
  final String email;
  final String phone;
  final String website;
  final String notes;
  final double outstandingBalance;

  // Computed fields (not stored in Firestore)
  final String statusTag;
  final Color statusColor;
  final IconData actionIcon;

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

  // Factory from Firestore
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

    final phone = map['phone']?.toString() ?? '';
    final hasPhone = phone.isNotEmpty && phone != 'null';

    return ClientModel(
      id: id,
      companyName: map['company_name'] ?? '',
      contactName: map['contact_name'] ?? '',
      email: map['email'] ?? '',
      phone: phone,
      website: map['website'] ?? '',
      notes: map['notes'] ?? '',
      outstandingBalance: outstanding,
      statusTag: tag,
      statusColor: color,
      actionIcon: hasPhone ? Icons.call : Icons.email,
    );
  }

  // To Firestore (only persistent fields)
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

  // IMMUTABLE COPYWITH — THE KEY ADDITION
  ClientModel copyWith({
    String? id,
    String? companyName,
    String? contactName,
    String? email,
    String? phone,
    String? website,
    String? notes,
    double? outstandingBalance,
    String? statusTag,
    Color? statusColor,
    IconData? actionIcon,
  }) {
    // Recompute status if balance changes
    final newOutstanding = outstandingBalance ?? this.outstandingBalance;
    String newTag;
    Color newColor;

    if (newOutstanding > 0) {
      newTag = '\$${newOutstanding.toStringAsFixed(0)} Outstanding';
      newColor = Colors.orange;
    } else if (newOutstanding < 0) {
      newTag = 'Overpaid';
      newColor = Colors.purple;
    } else {
      newTag = 'All caught up';
      newColor = primaryColor;
    }

    final newPhone = phone ?? this.phone;
    final newActionIcon = (newPhone.isNotEmpty && newPhone != 'null') ? Icons.call : Icons.email;

    return ClientModel(
      id: id ?? this.id,
      companyName: companyName ?? this.companyName,
      contactName: contactName ?? this.contactName,
      email: email ?? this.email,
      phone: newPhone,
      website: website ?? this.website,
      notes: notes ?? this.notes,
      outstandingBalance: newOutstanding,
      statusTag: statusTag ?? newTag,
      statusColor: statusColor ?? newColor,
      actionIcon: actionIcon ?? newActionIcon,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClientModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          companyName == other.companyName &&
          contactName == other.contactName &&
          email == other.email &&
          phone == other.phone &&
          website == other.website &&
          notes == other.notes &&
          outstandingBalance == other.outstandingBalance;

  @override
  int get hashCode => Object.hash(
        id,
        companyName,
        contactName,
        email,
        phone,
        website,
        notes,
        outstandingBalance,
      );
}