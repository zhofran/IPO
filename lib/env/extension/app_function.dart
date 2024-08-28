import 'dart:math' as math;
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:simple_barcode_scanner/enum.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:tandi_mobile/env/class/app_env.dart';
import 'package:tandi_mobile/env/class/app_shortcut.dart';
import 'package:tandi_mobile/env/extension/on_context.dart';
import 'package:tandi_mobile/env/variable/app_constant.dart';
import 'package:tandi_mobile/env/widget/app_confirmation_dialog.dart';
import 'package:tandi_mobile/env/widget/app_text.dart';
import 'package:tandi_mobile/env/widget/bug_catcher.dart';
import 'package:tandi_mobile/env/widget/gallery_viewer.dart';
import 'package:tandi_mobile/src/transaction/models/transaction_history_model.dart';
import 'package:tandi_mobile/src/transaction/pages/transaction_detail_page.dart';
import 'package:tandi_mobile/src/worship/states/image_cubit.dart';

class AppFunction {
  static void openGalleryViewer({
    required BuildContext context,
    required int index,
    required List<String> images,
    bool isNetwork = true,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GalleryPhotoViewWrapper(
          images: images,
          backgroundDecoration: const BoxDecoration(
            color: Colors.black,
          ),
          initialIndex: index,
          scrollDirection: Axis.horizontal,
          isNetwork: isNetwork,
        ),
      ),
    );
  }

  static String formatRupiah({required double currency, String symbol = 'Rp'}) {
    var rupiahFormat = NumberFormat.currency(
        locale: 'id_ID', symbol: symbol, decimalDigits: 0);
    String formattedRupiah = rupiahFormat.format(currency);
    return formattedRupiah;
  }

  static String formatRupiahDecimal(
      {required double currency, String symbol = 'Rp'}) {
    var rupiahFormat = NumberFormat.currency(
        locale: 'id_ID', symbol: symbol, decimalDigits: 2);
    String formattedRupiah = rupiahFormat.format(currency);
    return formattedRupiah;
  }

  static double reverseRupiah(String formattedString) {
    final numericString = formattedString.replaceAll(RegExp(r'[^\d]'), '');
    return double.tryParse(numericString) ?? 0.0;
  }

  static getFileSize(String filepath, int decimals) async {
    var file = File(filepath);
    int bytes = await file.length();
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (math.log(bytes) / math.log(1024)).floor();
    return '${(bytes / math.pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
  }

  static String parsePhoneNumber(String phoneString) {
    // Remove non-digit characters from the phone string
    String digitsOnly = phoneString.replaceAll(RegExp(r'\D'), '');

    // Replace '62' with '0'
    String modifiedNumber = digitsOnly.replaceFirst(RegExp(r'^62'), '0');

    return modifiedNumber;
  }

  static String getScoreReview({required double score}) {
    switch (score) {
      case >= 4:
        return 'Sangat Bagus';
      case >= 3:
        return 'Bagus';
      case >= 2:
        return 'Lumayan';
      case >= 1:
        return 'Kurang';
      case > 0:
        return 'Buruk';
      default:
    }
    return 'Belum ada ulasan';
  }

  static Future<DateTime?> selectDate(BuildContext context,
      {DateTime? initialDate, DateTime? firstDate, DateTime? lastDate}) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: initialDate ?? DateTime.now(),
        initialDatePickerMode: DatePickerMode.day,
        firstDate: firstDate ?? DateTime(1900),
        lastDate: lastDate ?? DateTime.now());
    if (picked != null) {
      return picked;
    }
    return null;
  }

  static void captureAndShare(
      {required ScreenshotController screenshotController, String? name}) {
    screenshotController.capture().then((image) {
      Share.shareXFiles([
        XFile.fromData(image!, name: name ?? 'transaksi.png', mimeType: 'png')
      ]);
    }).catchError((onError) {
      log(onError);
    });
  }

  static String formatDateTime(DateTime dateTime) {
    return DateFormat('dd MMM yyyy, HH:mm').format(dateTime);
  }

  static String formatDate(DateTime dateTime) {
    return DateFormat('dd MMM yyyy').format(dateTime);
  }

  static String formatDateMonth(DateTime dateTime) {
    return DateFormat('dd MMM ').format(dateTime);
  }

  static String formatDateyyyyMMdd(String dateString) {
    DateTime dateTime = DateFormat('dd MMM yyyy').parse(dateString);
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  static String formatDateDay(DateTime dateTime) {
    return DateFormat("EEEE, d MMMM yyyy", "id_ID").format(dateTime);
  }

  static String formatDateBodyApi(DateTime dateTime) {
    return DateFormat("yyyy-MM-dd").format(dateTime);
  }

  static String formatPhoneNumber(String phoneNumber) {
    if (phoneNumber.startsWith('0')) {
      // Replace '0' with '+62'
      return phoneNumber.replaceFirst('0', '+62');
    } else if (phoneNumber.startsWith('62')) {
      // Add '+' in front of '62'
      return '+$phoneNumber';
    } else if (!phoneNumber.startsWith('+62')) {
      // If the number doesn't start with '+62', make sure to add it
      return '+62$phoneNumber';
    } else {
      // If the number already starts with '+62', return as is
      return phoneNumber;
    }
  }

  static void transactionNavigator({
    required TransactionHistoryModel data,
    required BuildContext context,
  }) {
    if (data.status.toUpperCase() == 'PENDING') {
      context.toNamed(
        route: AppRoute.ppobPaymentDetailPage.path,
        arguments: {
          'history': data,
          'paymentImage': data.transactionable?.paymentImage,
        },
      );
    } else {
      context.to(child: TransactionDetailPage(data: data));
    }
  }

  static String? extractClientId(String text) {
    RegExp regExp = RegExp(r'REFF#\d+');
    Match? match = regExp.firstMatch(text);

    if (match != null) {
      return match.group(0);
    } else {
      return null;
    }
  }

  static String formatProductConfirmation({required dynamic product}) {
    String result = '-';
    String dataType = product.runtimeType.toString();

    switch (dataType) {
      case 'SubscriptionModel':
        result = product.name;
        break;
      case 'DatasModel':
        result = product.name;
        break;
      case 'PulsesModel':
        result =
            'Pulsa ${AppFunction.formatRupiah(currency: product.nominal)} (${product.code})';
        break;
      case 'ProductEWalletModel':
        result =
            'EWallet ${AppFunction.formatRupiah(currency: product.nominal)} (${product.code})';
        break;
      case 'ProductElectricityTokenModel':
        result =
            'Token Listrik ${AppFunction.formatRupiah(currency: product.nominal)} (${product.code})';
        break;
      case 'EMoneyProductModel':
        result =
            'E-Money ${AppFunction.formatRupiah(currency: product.nominal)} (${product.code})';
        break;
      case 'TopUpModel':
        result = '${product.name} Tandi';
        break;
      case 'VoucherPaymentModel':
        result = 'Pembelian ${product.namaprofile} Voucher Elinet';
        break;
      case 'VeeaPaymentModel':
        result = 'Pembelian ${product.namaVoucher} Voucher Veea';
        break;
      case 'AdsConfirmModel':
        result = 'Pembelian ${product.detail}';
        break;
      case 'TourTravelProductModel':
        result = 'Pembelian ${product.name}';
        break;
      default:
    }

    return result;
  }

  static String getProviderNumber({required String phoneNumber}) {
    String value = phoneNumber.substring(0, 4);

    if (value.contains('0811') ||
        value.contains('0812') ||
        value.contains('0813') ||
        value.contains('0821') ||
        value.contains('0822') ||
        value.contains('0823') ||
        value.contains('0852') ||
        value.contains('0853') ||
        value.contains('0851')) {
      return AppAsset.logoTelkomsel;
    }

    if (value.contains('0814') ||
        value.contains('0815') ||
        value.contains('0816') ||
        value.contains('0855') ||
        value.contains('0856') ||
        value.contains('0857') ||
        value.contains('0858')) {
      return AppAsset.logoIndosat;
    }

    if (value.contains('0817') ||
        value.contains('0818') ||
        value.contains('0819') ||
        value.contains('0859') ||
        value.contains('0877') ||
        value.contains('0878')) {
      return AppAsset.logoXl;
    }

    if (value.contains('0831') ||
        value.contains('0832') ||
        value.contains('0833')) {
      return AppAsset.logoAxis;
    }

    if (value.contains('0895') ||
        value.contains('0896') ||
        value.contains('0897') ||
        value.contains('0898') ||
        value.contains('0899')) {
      return AppAsset.logoThree;
    }

    if (value.contains('0881') ||
        value.contains('0882') ||
        value.contains('0883') ||
        value.contains('0884') ||
        value.contains('0885') ||
        value.contains('0886') ||
        value.contains('0887') ||
        value.contains('0888') ||
        value.contains('0889')) {
      return AppAsset.logoSmartfren;
    }

    return '';
  }

  static double extractNumberFromString(String input) {
    String? numberString =
        input.replaceAll('.', '').replaceAll('RP', '').replaceAll(' ', '');
    return double.parse(numberString);
  }

  static String extractNumberFromStringForVoucher(String input) {
    String? numberString = input.replaceAll('.0', '');
    return numberString;
  }

  static String extractNumberFromStringForBalance(String input) {
    String? numberString = input.replaceAll('.', '').replaceAll(',', '');
    return numberString;
  }

  static List<T> cutList<T>(List<T> list) {
    return list.sublist(0, list.length > 5 ? 5 : list.length);
  }

  static Future<String> pickContactNumber() async {
    final FlutterContactPicker contactPicker = FlutterContactPicker();
    Contact? contact = await contactPicker.selectContact();

    return AppFunction.parsePhoneNumber(contact?.phoneNumbers?.first ?? '');
  }

  static Future<String?> scanQRFrom<T extends Object?>(
      BuildContext context) async {
    try {
      var result = await context.to(
        child: const SimpleBarcodeScannerPage(
          isShowFlashIcon: true,
          scanType: ScanType.qr,
        ),
      );
      if (result == null || result == -1 || result == "-1") {
        return null;
      } else {
        return result.toString().trim();
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      throw BugSheet(
              title: "Gagal Memuat Scanner",
              content: "$e",
              pagePath: "src/env/extensions/app_function.dart",
              statePath: "")
          .openWith(context);
    }
  }

  static String extractSNString(String message) {
    RegExp regex = RegExp(r'\b\d{4}-\d{4}-\d{4}-\d{4}-\d{4}\b');
    Match? match = regex.firstMatch(message);
    if (match != null) {
      return match.group(0)!;
    }
    return "";
  }

  static void orientationChange(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      log('change to landscape', name: 'orientationChange');
    }
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      log('change to potrait', name: 'orientationChange');
    }
  }

  static void onClipboard(
    BuildContext context, {
    required String data,
    required String content,
  }) async {
    await Clipboard.setData(
      ClipboardData(text: data),
    );
    // ignore: use_build_context_synchronously
    context.alert(
      label: content,
      color: My.green2,
    );
  }

  // static void orientationPotraitChange(BuildContext context) {
  //   if (MediaQuery.of(context).orientation == Orientation.portrait) {
  //     log('change to potrait');
  //   }
  // }

  // static void orientationLandscapeChange(BuildContext context) {
  //   if (MediaQuery.of(context).orientation == Orientation.landscape) {
  //     log('change to landscape');
  //   }
  // }

  static Future<Uint8List> getBytesData(String path) async {
    final byteData = await rootBundle.load(path);
    final uint8List = byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);

    return Uint8List.fromList(uint8List);
  }

  Future<String> getFilePath(String path) async {
    final byteData = await rootBundle.load(path);
    final file = await File(
            '${Directory.systemTemp.path}${path.replaceAll('assets', '')}')
        .create();
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    return file.path;
  }

  static String getMinTopUpEWallet({required String wallet}) {
    double value = 0.0;

    switch (wallet) {
      case 'OVO':
        value = 20000;
        break;
      case 'DANA':
        value = 20000;
        break;
      case 'GOPAY':
        value = 10000;
        break;
      case 'LINKAJA':
        value = 10000;
        break;
      case 'SHOPEEPAY':
        value = 10000;
        break;
      default:
    }
    return AppFunction.formatRupiah(currency: value);
  }

  static String getMonthAbbreviation() {
    DateTime now = DateTime.now();
    return DateFormat('MMM').format(now);
  }

  static int getCurrentYear() {
    DateTime now = DateTime.now();
    return now.year;
  }

  static void guestNagivator({required BuildContext context}) {
    context.show(
      child: AppConfirmationDialog(
        title: 'Daftar Sekarang!',
        subtitle:
            'Saat ini kamu belum memiliki akun, segera daftar dan nikmati keuntungan menjadi member Tandi',
        onYes: () => context.toNamed(
          route: AppRoute.loginPage.path,
        ),
        onNo: () {},
        reversePrio: true,
      ),
    );
  }

  static sheetImagePicker(BuildContext context, AppShortcut my) async {
    context.sheet(
      isScrollable: true,
      child: Container(
        height: 110,
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {
                context.read<ImageCubit>().pickImage();
                context.close();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(
                    text: 'Kamera',
                    weight: FontWeight.w600,
                    size: 12,
                    textColor: my.color.primary,
                  ),
                ],
              ),
            ),
            const Divider(thickness: 1, height: 0),
            InkWell(
              onTap: () {
                context.read<ImageCubit>().pickImage(isFromGallery: true);
                context.close();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(
                    text: 'Galeri',
                    weight: FontWeight.w600,
                    size: 12,
                    textColor: my.color.primary,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
