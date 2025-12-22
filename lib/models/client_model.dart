class ClientModel {
  String? id;
  final String companyName;
  final String contactName;
  final String email;
  final String phone;
  final String website;
  final String notes;
  final double outstandingBalance;

  ClientModel({
    this.id,
    required this.companyName,
    required this.contactName,
    required this.email,
    required this.phone,
    this.website = '',
    this.notes = '',
    this.outstandingBalance = 0.0,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) => ClientModel(
    id: json['id'],
    companyName: json['company_name'],
    contactName: json['contact_name'],
    email: json['email'],
    phone: json['phone'],
    website: json['website'] ?? '',
    notes: json['notes'] ?? '',
    outstandingBalance: (json['outstanding_balance'] ?? 0.0).toDouble(),
  );

  Map<String, dynamic> toJson() => {
    'company_name': companyName,
    'contact_name': contactName,
    'email': email,
    'phone': phone,
    'website': website,
    'notes': notes,
    'outstanding_balance': outstandingBalance,
  };
}
