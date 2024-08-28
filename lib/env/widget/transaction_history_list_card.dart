import 'package:flutter/material.dart';
import 'package:tandi_mobile/env/class/app_shortcut.dart';
import 'package:tandi_mobile/env/extension/app_function.dart';
import 'package:tandi_mobile/env/variable/app_constant.dart';
import 'package:tandi_mobile/env/widget/app_text.dart';

class TransactionHistoryListCard extends StatelessWidget {
  const TransactionHistoryListCard({
    super.key,
    required this.title,
    required this.amount,
    required this.date,
    required this.status,
    required this.onTap,
  });

  final String title, status, amount;
  final DateTime date;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    var my = AppShortcut.of(context);

    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: my.query.size.width * 0.5,
                child: AppText(
                  text: title,
                  weight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: AppText(
                  text: amount,
                  weight: FontWeight.w600,
                  textAlign: TextAlign.end,
                  textColor: amount.contains('+')
                      ? My.green2
                      : amount.contains('-')
                          ? My.softRed
                          : Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              AppText(
                text: AppFunction.formatDateTime(date),
                size: 12,
              ),
              const Spacer(),
              AppText(
                text: status,
                weight: FontWeight.w600,
                size: 12,
                textColor: status.toLowerCase() == 'success'
                    ? my.color.primary
                    : status.toLowerCase() == 'pending'
                        ? my.color.secondary
                        : my.color.error,
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Divider(),
        ],
      ),
    );
  }
}
