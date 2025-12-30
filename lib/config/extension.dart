import 'package:flutter/material.dart';
import 'package:invoice_pay/models/client_model.dart';
import 'package:invoice_pay/models/invoice_model.dart';
import 'package:invoice_pay/providers/client_provider.dart';
import 'package:invoice_pay/styles/colors.dart';
import 'package:provider/provider.dart';

extension IntSizedBoxExtension on int {
  SizedBox height() {
    return SizedBox(height: toDouble());
  }

  SizedBox width() {
    return SizedBox(width: toDouble());
  }
}

extension EllipsisExtension on String {
  String ellipsis() {
    if (length > 14) {
      final getFirst14String = substring(0, 14);
      return '$getFirst14String...';
    }
    return this;
  }
}

///Extension to easily get client details from [clientId]
extension InvoiceExtension on InvoiceModel {
  String getClientName(BuildContext context) {
    final clientProvider = context.read<ClientProvider>();
    final client = clientProvider.clients.firstWhere(
      (c) => c.id == clientId,
      orElse: () => ClientModel(
        id: clientId,
        companyName: 'Unknown Client',
        contactName: '',
        email: '',
        phone: '',
        statusTag: '',
        statusColor: primaryColor,
        actionIcon: Icons.drafts,
      ),
    );
    return client.contactName.isNotEmpty
        ? client.contactName
        : client.companyName;
  }

  ClientModel? getClient(BuildContext context, {String? id}) {
    final clientProvider = Provider.of<ClientProvider>(context, listen: false);
    try {
      return clientProvider.clients.firstWhere((c) => c.id == (id ?? clientId));
    } catch (e) {
      return null;
    }
  }
}
