import 'package:flutter/material.dart';
import 'package:invoice_pay/screens/clients/client_screen.dart';
import 'package:invoice_pay/screens/invoice/wigets/custom_widgets.dart';
import 'package:invoice_pay/styles/colors.dart';
import 'package:invoice_pay/widgets/custom_button.dart';

Future<String?> showSingleSelectModal({
  required BuildContext context,
  required String title,
  required List<String> items,
  String? selectedItem,
}) async {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
    ),
    backgroundColor: Colors.white,
    builder: (ctx) {
      return DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        expand: false,
        builder: (_, controller) {
          return Column(
            children: [
              // Handle + Title
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(ctx),
                    ),
                  ],
                ),
              ),

              const Divider(height: 1),

              // List
              Expanded(
                child: ListView.builder(
                  controller: controller,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    final isSelected = item == selectedItem;

                    return ListTile(
                      leading: isSelected
                          ? Icon(Icons.check_circle, color: primaryColor)
                          : const Icon(
                              Icons.circle_outlined,
                              color: Colors.grey,
                            ),
                      title: Text(
                        item,
                        style: TextStyle(
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: isSelected ? primaryColor : Colors.black87,
                        ),
                      ),
                      onTap: () => Navigator.pop(ctx, item),
                    );
                  },
                ),
              ),
            ],
          );
        },
      );
    },
  );
}

Future<String?> showSingleClientSelectModal({
  required BuildContext context,
  required String title,
  required List<String> items,
  String? selectedItem,
}) async {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
    ),
    backgroundColor: Colors.white,
    builder: (ctx) {
      return DraggableScrollableSheet(
        initialChildSize: 0.4,
        minChildSize: 0.4,
        maxChildSize: 0.6,
        expand: false,
        builder: (_, controller) {
          return Column(
            children: [
              // Handle + Title
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(ctx),
                    ),
                  ],
                ),
              ),

              const Divider(height: 1),

              // List
              items.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        spacing: 10,
                        children: [
                          emptyState(
                            "No Client Available",
                            'Create your first client to get started',
                          ),
                          CustomButton(
                            width: double.infinity,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ClientsScreen(),
                                ),
                              );
                            },
                            text: "Add Client",
                          ),
                        ],
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        controller: controller,
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          final isSelected = item == selectedItem;

                          return ListTile(
                            leading: isSelected
                                ? Icon(Icons.check_circle, color: primaryColor)
                                : const Icon(
                                    Icons.circle_outlined,
                                    color: Colors.grey,
                                  ),
                            title: Text(
                              item,
                              style: TextStyle(
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: isSelected
                                    ? primaryColor
                                    : Colors.black87,
                              ),
                            ),
                            onTap: () => Navigator.pop(ctx, item),
                          );
                        },
                      ),
                    ),
            ],
          );
        },
      );
    },
  );
}
