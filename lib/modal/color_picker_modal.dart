import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_utilities/flutter_utilities.dart';
import 'package:invoice_pay/widgets/custom_button.dart';

Future<Color?> showColorPickerModal({
  required BuildContext context,
  required Color initialColor,
  String title = 'Pick a Color',
  bool enableAlpha = false,
}) async {
  Color pickerColor = initialColor;

  return showModalBottomSheet<Color>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
    ),
    backgroundColor: Colors.white,
    builder: (ctx) {
      return DraggableScrollableSheet(
        initialChildSize: 0.85,
        minChildSize: 0.6,
        maxChildSize: 0.95,
        expand: false,
        builder: (_, scrollController) {
          return StatefulBuilder(
            builder: (context, setState) {
              return Column(
                children: [
                  // Drag Handle
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    width: 50,
                    height: 6,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),

                  // Title Bar
                  Padding(
                    padding: const EdgeInsets.fromLTRB(32, 24, 32, 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(ctx),
                          child: Text(
                            'Cancel',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Divider(height: 1, thickness: 1),

                  // Color Picker
                  Expanded(
                    child: SingleChildScrollView(
                      controller: scrollController,
                      padding: const EdgeInsets.all(32),
                      child: ColorPicker(
                        pickerColor: pickerColor,
                        onColorChanged: (color) {
                          setState(() {
                            pickerColor = color;
                          });
                        },
                        enableAlpha: enableAlpha,
                        showLabel: true,
                        pickerAreaHeightPercent: 0.8,
                        paletteType: PaletteType.hsvWithHue,
                        labelTypes: const [
                          ColorLabelType.hsv,
                          ColorLabelType.rgb,
                          ColorLabelType.hex,
                        ],
                        displayThumbColor: true,
                        hexInputBar: true,
                      ),
                    ),
                  ),

                  // Current Color Preview + Save
                  Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(32),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 80,
                          decoration: BoxDecoration(
                            color: pickerColor,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: pickerColor.withOpacity(0.4),
                                blurRadius: 20,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              '#${pickerColor.value.toRadixString(16).substring(2).toUpperCase()}',
                              style: TextStyle(
                                color: useWhiteForeground(pickerColor)
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: CustomButton(
                            onPressed: () => Navigator.pop(ctx, pickerColor),
                            text: 'Select This Color'.capitalize(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
      );
    },
  );
}
