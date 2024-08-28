import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tandi_mobile/env/variable/app_constant.dart';

class TextfieldFloatingLabel extends StatelessWidget {
  const TextfieldFloatingLabel({
    super.key,
    required this.label,
    required this.controller,
    required this.validator,
    this.inputFormatters,
    this.keyboardType,
  });

  final String label;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: My.grey3,
        border: Border.all(color: My.grey6),
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
      child: TextFormField(
        controller: controller,
        validator: validator,
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.black,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          labelText: label,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelStyle: TextStyle(
            fontSize: 13,
            color: My.grey6,
            fontWeight: FontWeight.w400,
          ),
          isDense: true,
          contentPadding: const EdgeInsets.all(8),
          border: border(),
          enabledBorder: border(),
          focusedBorder: border(),
          errorBorder: border(),
          disabledBorder: border(),
          focusedErrorBorder: border(),
        ),
      ),
    );
  }

  OutlineInputBorder border() {
    return const OutlineInputBorder(
      borderSide: BorderSide.none,
    );
  }
}
