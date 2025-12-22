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

  CompanyModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.street,
    required this.city,
    required this.zip,
    this.logoUrl,
    this.primaryColor = Colors.blue,
    this.fontFamily = 'Manrope',
  });

  factory CompanyModel.fromMap(String id, Map<String, dynamic> map) {
    return CompanyModel(
      id: id,
      name: map['company_name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      street: map['street'] ?? '',
      city: map['city'] ?? '',
      zip: map['zip'] ?? '',
      logoUrl: map['logo_url'],
      primaryColor: Color(map['primary_color'] ?? Colors.blue.value),
      fontFamily: map['font_family'] ?? 'Manrope',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'company_name': name,
      'email': email,
      'phone': phone,
      'street': street,
      'city': city,
      'zip': zip,
      'logo_url': logoUrl,
      'primary_color': primaryColor.value,
      'font_family': fontFamily,
    };
  }
}
