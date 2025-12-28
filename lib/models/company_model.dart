import 'package:flutter/material.dart';

class CompanyModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String street;
  final String city;
  final String zip;
  final String? logoUrl;
  final Color primaryColor;
  final String fontFamily;
  final double monthlyGoal;
  final String currencyCode; // e.g. 'USD', 'EUR', 'GBP'
  final String currencySymbol; // e.g. '$', '€', '£'

  CompanyModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.street,
    required this.city,
    required this.zip,
    this.logoUrl,
    required this.primaryColor,
    this.fontFamily = 'Manrope',
    this.monthlyGoal = 15000.0,
    this.currencyCode = 'USD',
    this.currencySymbol = '\$',
  });

  factory CompanyModel.fromMap(String id, Map<String, dynamic> map) {
    return CompanyModel(
      id: id,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      street: map['street'] ?? '',
      city: map['city'] ?? '',
      zip: map['zip'] ?? '',
      logoUrl: map['logo_url'],
      primaryColor: Color(map['primary_color'] ?? Colors.blue.value),
      fontFamily: map['font_family'] ?? 'Manrope',
      monthlyGoal: (map['monthly_goal'] ?? 15000.0).toDouble(),
      currencyCode: map['currency_code'] ?? 'USD',
      currencySymbol: map['currency_symbol'] ?? '\$',
    );
  }

  Map<String, dynamic> toMap() => {
    'name': name,
    'email': email,
    'phone': phone,
    'street': street,
    'city': city,
    'zip': zip,
    'logo_url': logoUrl,
    'primary_color': primaryColor.value,
    'font_family': fontFamily,
    'monthly_goal': monthlyGoal,
    'currency_code': currencyCode,
    'currency_symbol': currencySymbol,
  };

  CompanyModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? street,
    String? city,
    String? zip,
    String? logoUrl,
    Color? primaryColor,
    String? fontFamily,
    double? monthlyGoal,
    String? currencyCode,
    String? currencySymbol,
  }) {
    return CompanyModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      street: street ?? this.street,
      city: city ?? this.city,
      zip: zip ?? this.zip,
      logoUrl: logoUrl ?? this.logoUrl,
      primaryColor: primaryColor ?? this.primaryColor,
      fontFamily: fontFamily ?? this.fontFamily,
      monthlyGoal: monthlyGoal ?? this.monthlyGoal,
      currencyCode: currencyCode ?? this.currencyCode,
      currencySymbol: currencySymbol ?? this.currencySymbol,
    );
  }
}
