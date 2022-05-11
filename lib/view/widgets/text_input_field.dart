import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class TextInputField extends StatelessWidget {
  const TextInputField({
    Key? key,
    required this.controller,
    required this.label,
    required this.enabled,
    required this.type,
  }) : super(key: key);

  final TextEditingController controller;
  final String label;
  final bool enabled;
  final TextInputType type;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 1.h),
      padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 3.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: TextFormField(
        controller: controller,
        enabled: enabled,
        keyboardType: type,
        textInputAction: TextInputAction.done,
        style: GoogleFonts.roboto(textStyle: const TextStyle(fontSize: 14)),
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(5.0),
            ),
            label: Text(label),
            labelStyle:
            GoogleFonts.roboto(textStyle: const TextStyle(fontSize: 12)),
            filled: true,
            contentPadding:
            const EdgeInsets.only(left: 0.0, bottom: 0.0, top: 0.0),
            fillColor: Colors.white),
      ),
    );
  }
}