// ignore_for_file: use_build_context_synchronously, unnecessary_string_interpolations

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tandi_mobile/env/class/app_env.dart';
import 'package:tandi_mobile/env/class/app_shortcut.dart';
import 'package:tandi_mobile/env/extension/app_function.dart';
import 'package:tandi_mobile/env/extension/on_context.dart';
import 'package:tandi_mobile/env/variable/app_constant.dart';
import 'package:tandi_mobile/env/widget/app_button.dart';
import 'package:tandi_mobile/env/widget/app_pin.dart';
import 'package:tandi_mobile/env/widget/app_text.dart';
import 'package:tandi_mobile/env/widget/customer_wallet_detail_card.dart';
import 'package:tandi_mobile/src/login/models/user_model.dart';
import 'package:tandi_mobile/src/saldo_transfer/models/wallet_name_model.dart';
import 'package:tandi_mobile/src/transfer/models/transfer_inquiry_model.dart';
import 'package:tandi_mobile/src/transfer/models/transfer_list_model.dart';

// ignore: must_be_immutable
class SendModalBottomSheet extends StatelessWidget {
  SendModalBottomSheet({
    super.key,
    required this.isSend,
    required this.pinController,
    required this.nominalController,
    required this.data,
    required this.onCompleted,
    this.transferData,
    this.transferInquiryData,
    this.isWallet,
    this.isBack,
  });

  bool isSend;
  bool hasPin = false;
  final bool? isBack, isWallet;
  final TextEditingController pinController, nominalController;
  final WalletNameModel? data;
  final TransferListModel? transferData;
  final TransferInquiryModel? transferInquiryData;
  final Function(String)? onCompleted;

  @override
  Widget build(BuildContext context) {
    var my = AppShortcut.of(context);

    return Builder(
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15),
              topLeft: Radius.circular(15),
            ),
          ),
          padding: EdgeInsets.fromLTRB(
              16, 0, 16, MediaQuery.of(context).viewInsets.bottom),
          width: AppShortcut.of(context).query.size.width,
          child: StatefulBuilder(
            builder: (_, setState2) {
              return isSend
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: My.grey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 5,
                          width: 60,
                          margin: const EdgeInsets.all(16),
                        ),
                        AppPin(
                          pinController: pinController,
                          onCompleted: onCompleted,
                        ),
                      ],
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: My.grey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 5,
                          width: 60,
                          margin: const EdgeInsets.all(16),
                        ),
                        data != null
                            ? CustomerWalletDetailCard(data: data!)
                            : const SizedBox(),
                        transferData != null && transferInquiryData != null
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: AppText(
                                      text: 'Tujuan',
                                      size: 15,
                                      weight: FontWeight.w600,
                                    ),
                                  ),
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
                                    title: AppText(
                                        text:
                                            '${transferInquiryData!.accountName} - ${transferData!.name}',
                                        weight: FontWeight.bold),
                                    subtitle: AppText(
                                      text: isWallet == true
                                          ? AppFunction.formatRupiah(
                                              currency: 2500)
                                          : '${transferData!.supportBiFast == 1 ? 'BiFast' : 'RTOL'}',
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox(),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const AppText(
                                text: 'Rincian',
                                size: 15,
                                weight: FontWeight.w600,
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const AppText(
                                    text: 'Biaya Admin',
                                    weight: FontWeight.w500,
                                  ),
                                  const Spacer(),
                                  AppText(
                                    text: transferData != null &&
                                            transferInquiryData != null
                                        ? AppFunction.formatRupiah(
                                            currency: (isWallet == true
                                                ? 2500
                                                : (transferData!.supportBiFast ==
                                                            1 ||
                                                        transferData!
                                                                .category ==
                                                            'EWALLET'
                                                    ? 2500
                                                    : 5000)),
                                          )
                                        : 'Gratis',
                                    weight: FontWeight.w600,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const AppText(
                                    text: 'Biaya Layanan',
                                    weight: FontWeight.w500,
                                  ),
                                  const Spacer(),
                                  AppText(
                                    text: AppFunction.formatRupiah(
                                        currency: My.serviceFee),
                                    weight: FontWeight.w600,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const AppText(
                                    text: 'Kirim',
                                    weight: FontWeight.w500,
                                  ),
                                  const Spacer(),
                                  AppText(
                                    text: transferData != null &&
                                            transferInquiryData != null
                                        ? AppFunction.formatRupiah(
                                            currency: AppFunction.reverseRupiah(
                                                nominalController.text),
                                          )
                                        : nominalController.text,
                                    weight: FontWeight.w600,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const AppText(
                                    text: 'Total Kirim',
                                    weight: FontWeight.w500,
                                  ),
                                  const Spacer(),
                                  AppText(
                                    text: transferData != null &&
                                            transferInquiryData != null
                                        ? AppFunction.formatRupiah(
                                            currency: AppFunction.reverseRupiah(
                                                    nominalController.text) +
                                                (isWallet == true
                                                    ? 2500
                                                    : (transferData!.supportBiFast ==
                                                                1 ||
                                                            transferData!
                                                                    .category ==
                                                                'EWALLET'
                                                        ? 2500
                                                        : 5000)),
                                          )
                                        : AppFunction.formatRupiah(
                                            currency:
                                                (AppFunction.reverseRupiah(
                                                        nominalController
                                                            .text) +
                                                    My.serviceFee)),
                                    weight: FontWeight.w600,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              FutureBuilder(
                                future: AppApi.getCurrentUser(),
                                builder: (_, snapshot) {
                                  UserModel? user = snapshot.data;

                                  user?.pin == '' || user?.pin == null
                                      ? hasPin = false
                                      : hasPin = true;

                                  log('hasPin : $hasPin');

                                  if (user == null) {
                                    log('user == $user');
                                    return AppButton.inActive(
                                        label:
                                            'Kirim ${transferData != null && transferInquiryData != null ? AppFunction.formatRupiah(
                                                currency: (AppFunction
                                                        .reverseRupiah(
                                                            nominalController
                                                                .text) +
                                                    (isWallet == true
                                                        ? 2500
                                                        : (transferData!.supportBiFast ==
                                                                    1 ||
                                                                transferData!
                                                                        .category ==
                                                                    'EWALLET'
                                                            ? 2500
                                                            : 5000))),
                                              ) : nominalController.text}');
                                  } else {
                                    log('user == $user');
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const AppText(
                                              text: 'Saldo Tandi',
                                              weight: FontWeight.w500,
                                            ),
                                            const Spacer(),
                                            AppText(
                                              text: AppFunction.formatRupiah(
                                                  currency:
                                                      user.wallet!.balance),
                                              weight: FontWeight.w600,
                                              textColor: my.color.primary,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 16),
                                        user.wallet!.balance <
                                                AppFunction.reverseRupiah(
                                                    nominalController.text)
                                            ? Column(
                                                children: [
                                                  const SizedBox(height: 16),
                                                  // check me later
                                                  AppButton.secondary(
                                                    label:
                                                        'Saldo Tidak Mencukupi (Isi Saldo)',
                                                    onTap: () async {
                                                      var result =
                                                          await context.toNamed(
                                                        route: AppRoute
                                                            .saldoTopupPage
                                                            .path,
                                                        arguments: {
                                                          'isBack': isBack,
                                                        },
                                                      );

                                                      if (result == true) {
                                                        context.close(true);
                                                        log('sendModal bottom sheet close');
                                                      }
                                                    },
                                                  ),
                                                ],
                                              )
                                            : AppButton(
                                                label: 'Kirim ${transferData != null && transferInquiryData != null ? AppFunction.formatRupiah(
                                                    currency: (AppFunction
                                                            .reverseRupiah(
                                                                nominalController
                                                                    .text) +
                                                        (isWallet == true
                                                            ? 2500
                                                            : (transferData!.supportBiFast ==
                                                                        1 ||
                                                                    transferData!
                                                                            .category ==
                                                                        'EWALLET'
                                                                ? 2500
                                                                : 5000))),
                                                  ) : AppFunction.formatRupiah(currency: int.parse(AppFunction.reverseRupiah(nominalController.text).toInt().toString()) + My.serviceFee)}',
                                                onTap: () async {
                                                  if (!hasPin) {
                                                    context.alert(
                                                      label:
                                                          'Buat PIN terlebih dahulu',
                                                      color: my.color.secondary,
                                                    );
                                                    var result = await context
                                                        .toNamed(
                                                            route: AppRoute
                                                                .pinPage.path,
                                                            arguments: {
                                                          'sendBack': true,
                                                        });

                                                    if (result == true) {
                                                      user = await AppApi
                                                          .getCurrentUser();
                                                      setState2(() {
                                                        hasPin = true;
                                                        isSend = true;
                                                      });
                                                    }
                                                  } else {
                                                    setState2(() {
                                                      isSend = true;
                                                    });
                                                  }
                                                },
                                              ),
                                      ],
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
            },
          ),
        );
      },
    );
  }
}
