import 'package:flutter/material.dart';
import 'package:flutter_tawkto/flutter_tawk.dart';
import 'package:invoice_pay/providers/company_provider.dart';
import 'package:invoice_pay/styles/colors.dart';
import 'package:invoice_pay/utils/contants.dart';
import 'package:provider/provider.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({super.key});

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CompanyProvider>(
      builder: (_, companyVm, child) {
        final company = companyVm.company;
        return Scaffold(
          appBar: AppBar(title: Text("live chat")),
          body: Tawk(
            directChatLink: tawkDirectChatLink,
            visitor: TawkVisitor(
              name: (company?.name ?? ''),
              email: (company?.name ?? ''),
            ),

            placeholder: const Center(
              child: SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(
                  color: greyColor,
                  backgroundColor: primaryColor,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
