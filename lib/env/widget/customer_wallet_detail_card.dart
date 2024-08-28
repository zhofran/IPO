import 'package:flutter/material.dart';
import 'package:tandi_mobile/env/class/app_env.dart';
import 'package:tandi_mobile/env/variable/app_constant.dart';
import 'package:tandi_mobile/env/widget/app_text.dart';
import 'package:tandi_mobile/src/saldo_transfer/models/wallet_name_model.dart';

class CustomerWalletDetailCard extends StatelessWidget {
  const CustomerWalletDetailCard({
    super.key,
    required this.data,
  });

  final WalletNameModel data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            radius: 24,
            backgroundColor: My.grey4,
            child: const Icon(
              Icons.person,
              color: Colors.black,
              size: 36,
            ),
          ),
          title: AppText(text: data.name, weight: FontWeight.bold),
          subtitle: AppText(text: data.numberPhone.replaceRange(4, 8, "****")),
          trailing: Image.asset(AppAsset.appLogo),
        ),
      ],
    );
  }
}
