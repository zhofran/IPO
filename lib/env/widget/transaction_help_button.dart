import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:tandi_mobile/env/class/app_env.dart';
import 'package:tandi_mobile/env/class/app_shortcut.dart';
import 'package:tandi_mobile/env/extension/app_function.dart';
import 'package:tandi_mobile/env/extension/on_context.dart';
import 'package:tandi_mobile/env/widget/app_button_icon.dart';
import 'package:url_launcher/url_launcher.dart';

class TransactionHelpButton extends StatefulWidget {
  const TransactionHelpButton({
    super.key,
    required this.screenshotController,
  });

  final ScreenshotController screenshotController;

  @override
  State<TransactionHelpButton> createState() => _TransactionHelpButtonState();
}

class _TransactionHelpButtonState extends State<TransactionHelpButton> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    AppFunction.orientationChange(context);
  }

  @override
  Widget build(BuildContext context) {
    var my = AppShortcut.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (int i = 0; i < 2; i++)
            SizedBox(
              width: my.query.size.width / 2 - 24,
              child: AppButtonIcon(
                image: [AppAsset.iconWhatsapp, AppAsset.iconShare][i],
                title: ['Bantuan', 'Bagikan'][i],
                onTap: [
                  () async {
                    final Uri uri = Uri.parse(
                        "https://api.whatsapp.com/send/?phone=6283871315993&text=Halo Admin, saya butuh bantuan mengenai&type=phone_number");
                    if (!await launchUrl(uri)) {
                      // ignore: use_build_context_synchronously
                      context.alert(label: uri.toString());
                    }
                  },
                  () {
                    AppFunction.captureAndShare(
                        screenshotController: widget.screenshotController);
                  },
                ][i],
              ),
            ),
        ],
      ),
    );
  }
}
