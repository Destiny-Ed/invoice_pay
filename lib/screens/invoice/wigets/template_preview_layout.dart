// // widgets/invoice_template_preview.dart
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:invoice_pay/models/invoice_model.dart';
// import 'package:invoice_pay/models/company_model.dart';
// import 'package:invoice_pay/models/client_model.dart';
// import 'package:invoice_pay/styles/colors.dart';
// import 'package:cached_network_image/cached_network_image.dart';

// class InvoiceTemplatePreview extends StatelessWidget {
//   final TemplateType templateType;
//   final InvoiceModel invoice;
//   final CompanyModel company;
//   final ClientModel client;

//   const InvoiceTemplatePreview({
//     super.key,
//     required this.templateType,
//     required this.invoice,
//     required this.company,
//     required this.client,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(24),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 20,
//             offset: const Offset(0, 8),
//           ),
//         ],
//       ),
//       child: _buildTemplate(),
//     );
//   }

//   Widget _buildTemplate() {
//     switch (templateType) {
//       case TemplateType.minimal:
//         return _minimal();
//       case TemplateType.bold:
//         return _bold();
//       case TemplateType.classic:
//         return _classic();
//       case TemplateType.modern:
//         return _modern();
//       case TemplateType.creative:
//         return _creative();
//     }
//   }

//   Widget _minimal() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _header(),
//         const SizedBox(height: 32),
//         _billTo(),
//         const SizedBox(height: 32),
//         _items(),
//         const Spacer(),
//         _total(),
//       ],
//     );
//   }

//   Widget _bold() {
//     return Container(
//       padding: const EdgeInsets.all(24),
//       decoration: BoxDecoration(
//         border: Border.all(width: 6, color: primaryColor),
//         borderRadius: BorderRadius.circular(24),
//       ),
//       child: _minimal(),
//     );
//   }

//   Widget _classic() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(company.name.toUpperCase(), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//         const Divider(thickness: 3),
//         const SizedBox(height: 20),
//         _minimal(),
//       ],
//     );
//   }

//   Widget _modern() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(company.name, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//               decoration: BoxDecoration(color: primaryColor, borderRadius: BorderRadius.circular(30)),
//               child: const Text('INVOICE', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
//             ),
//           ],
//         ),
//         const SizedBox(height: 32),
//         _minimal(),
//       ],
//     );
//   }

//   Widget _creative() {
//     return Stack(
//       children: [
//         Positioned(
//           top: 0,
//           left: 0,
//           right: 0,
//           child: Container(
//             height: 120,
//             decoration: BoxDecoration(
//               color: primaryColor,
//               borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(24),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(company.name, style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
//               const SizedBox(height: 80),
//               Text('INVOICE #${invoice.number}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//               const SizedBox(height: 32),
//               _minimal(),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _header() {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         if (company.logoUrl != null && company.logoUrl!.isNotEmpty)
//           ClipRRect(
//             borderRadius: BorderRadius.circular(12),
//             child: CachedNetworkImage(
//               imageUrl: company.logoUrl!,
//               width: 60,
//               height: 60,
//               fit: BoxFit.cover,
//               placeholder: (context, url) => Container(color: Colors.grey[300]),
//             ),
//           ),
//         const SizedBox(width: 16),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(company.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//               Text(company.email, style: const TextStyle(fontSize: 10, color: Colors.grey)),
//               Text(company.phone, style: const TextStyle(fontSize: 10, color: Colors.grey)),
//             ],
//           ),
//         ),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             const Text('INVOICE', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//             Text('#${invoice.number}', style: const TextStyle(fontSize: 14)),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _billTo() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text('Bill To', style: TextStyle(fontWeight: FontWeight.bold)),
//         const SizedBox(height: 8),
//         Text(client.companyName, style: const TextStyle(fontWeight: FontWeight.bold)),
//         Text(client.contactName),
//         Text(client.email),
//       ],
//     );
//   }

//   Widget _items() {
//     return Column(
//       children: invoice.items.take(3).map((item) => Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Text(
//                     item.description,
//                     overflow: TextOverflow.ellipsis,
//                     style: const TextStyle(fontSize: 12),
//                   ),
//                 ),
//                 Text('\$${item.amount.toStringAsFixed(2)}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
//               ],
//             ),
//           )).toList(),
//     );
//   }

//   Widget _total() {
//     return Align(
//       alignment: Alignment.centerRight,
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: primaryColor.withOpacity(0.1),
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Text(
//           'Total: \$${invoice.total.toStringAsFixed(2)}',
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: primaryColor),
//         ),
//       ),
//     );
//   }
// }