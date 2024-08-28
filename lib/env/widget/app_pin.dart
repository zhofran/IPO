import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import 'package:tandi_mobile/env/variable/app_constant.dart';
import 'package:tandi_mobile/env/widget/app_text.dart';

class AppPin extends StatelessWidget {
  const AppPin({
    super.key,
    this.label = 'Masukkan kode PIN',
    required this.pinController,
    required this.onCompleted,
  });

  final TextEditingController pinController;
  final Function(String p1)? onCompleted;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppText(
          text: label,
          size: 16,
          weight: FontWeight.w600,
        ),
        const SizedBox(height: 16),
        Pinput(
          defaultPinTheme: PinTheme(
            width: 56,
            height: 56,
            textStyle: const TextStyle(
              fontSize: 22,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: My.grey4,
            ),
          ),
          autofocus: true,
          obscureText: true,
          obscuringCharacter: '●',
          length: 6,
          controller: pinController,
          onCompleted: onCompleted,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}
