import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tandi_mobile/env/extension/app_function.dart';
import 'package:tandi_mobile/env/extension/on_context.dart';
import 'package:tandi_mobile/env/model/app_date_model.dart';
import 'package:tandi_mobile/env/variable/banner_slug.dart';
import 'package:tandi_mobile/src/banner/cubit/banner_cubit.dart';
import 'package:tandi_mobile/src/banner/cubit/banner_selection_cubit.dart';
import 'package:tandi_mobile/src/banner/pages/banner_selection_page.dart';
import 'package:tandi_mobile/src/blank_page.dart';
import 'package:tandi_mobile/src/boarding/pages/boarding_page.dart';
import 'package:tandi_mobile/src/bpjs/cubit/bpjs_cubit.dart';
import 'package:tandi_mobile/src/bpjs/pages/bpjs_detail_page.dart';
import 'package:tandi_mobile/src/bpjs/pages/bpjs_page.dart';
import 'package:tandi_mobile/src/change_password/cubit/change_password_cubit.dart';
import 'package:tandi_mobile/src/change_password/pages/change_password_page.dart';
import 'package:tandi_mobile/src/dashboard/pages/dashboard_page.dart';
import 'package:tandi_mobile/src/e_money/cubit/e_money_cubit.dart';
import 'package:tandi_mobile/src/e_money/pages/e_money_page.dart';
import 'package:tandi_mobile/src/e_wallet/cubit/e_wallet_cubit.dart';
import 'package:tandi_mobile/src/e_wallet/pages/e_wallet_nominal_page.dart';
import 'package:tandi_mobile/src/e_wallet/pages/e_wallet_page.dart';
import 'package:tandi_mobile/src/forgot_password/cubit/forgot_password_cubit.dart';
import 'package:tandi_mobile/src/forgot_password/pages/forgot_password_page.dart';
import 'package:tandi_mobile/src/guest/cubit/guest_emoney_cubit.dart';
import 'package:tandi_mobile/src/guest/cubit/guest_ewallet_cubit.dart';
import 'package:tandi_mobile/src/guest/cubit/guest_pln_cubit.dart';
import 'package:tandi_mobile/src/guest/cubit/guest_pln_customer_cubit.dart';
import 'package:tandi_mobile/src/guest/cubit/guest_pulses_cubit.dart';
import 'package:tandi_mobile/src/guest/pages/guest_dashboard_page.dart';
import 'package:tandi_mobile/src/guest/pages/guest_emoney_page.dart';
import 'package:tandi_mobile/src/guest/pages/guest_ewallet_nominal_page.dart';
import 'package:tandi_mobile/src/guest/pages/guest_ewallet_page.dart';
import 'package:tandi_mobile/src/guest/pages/guest_pln_page.dart';
import 'package:tandi_mobile/src/guest/pages/guest_pulse_page.dart';
import 'package:tandi_mobile/src/guest/pages/guest_worship_page.dart';
import 'package:tandi_mobile/src/homepage/cubit/homepage_cubit.dart';
import 'package:tandi_mobile/src/internet_voucher/cubit/generate_cubit.dart';
import 'package:tandi_mobile/src/internet_voucher/cubit/lokasi_cubit.dart';
import 'package:tandi_mobile/src/internet_voucher/cubit/pairing_cubit.dart';
import 'package:tandi_mobile/src/internet_voucher/cubit/report_cubit.dart';
import 'package:tandi_mobile/src/internet_voucher/cubit/voucher_cubit.dart';
import 'package:tandi_mobile/src/internet_voucher/pages/form_generate_pages.dart';
import 'package:tandi_mobile/src/internet_voucher/pages/pairing_web.dart';
import 'package:tandi_mobile/src/internet_voucher/pages/report_page.dart';
import 'package:tandi_mobile/src/internet_voucher/pages/voucher_page.dart';
import 'package:tandi_mobile/src/login/cubit/login_cubit.dart';
import 'package:tandi_mobile/src/login/models/user_model.dart';
import 'package:tandi_mobile/src/login/pages/login_page.dart';
import 'package:tandi_mobile/src/otp/cubit/otp_cubit.dart';
import 'package:tandi_mobile/src/otp/pages/otp_page.dart';
import 'package:tandi_mobile/src/payment/cubit/payment_cubit.dart';
import 'package:tandi_mobile/src/payment/cubit/ppob_payment_detail_cubit.dart';
import 'package:tandi_mobile/src/payment/cubit/subscribe_payment_detail_cubit.dart';
import 'package:tandi_mobile/src/payment/cubit/voucher_payment_cubit.dart';
import 'package:tandi_mobile/src/payment/pages/ppob_payment_detail_page.dart';
import 'package:tandi_mobile/src/payment/pages/select_payment_method_page.dart';
import 'package:tandi_mobile/src/payment/pages/subscribe_payment_detail_page.dart';
import 'package:tandi_mobile/src/payment/pages/payment_page.dart';
import 'package:tandi_mobile/src/payment/pages/voucher_payment_page.dart';
import 'package:tandi_mobile/src/pin/cubit/pin_cubit.dart';
import 'package:tandi_mobile/src/pin/pages/pin_forgot_page.dart';
import 'package:tandi_mobile/src/pin/pages/pin_page.dart';
import 'package:tandi_mobile/src/pln/cubit/pln_cubit.dart';
import 'package:tandi_mobile/src/pln/cubit/pln_customer_cubit.dart';
import 'package:tandi_mobile/src/pln/pages/pln_confirmation_page.dart';
import 'package:tandi_mobile/src/pln/pages/pln_page.dart';
import 'package:tandi_mobile/src/profile/cubit/photo_profile_cubit.dart';
import 'package:tandi_mobile/src/profile/cubit/profile_cubit.dart';
import 'package:tandi_mobile/src/profile/cubit/profile_edit_cubit.dart';
import 'package:tandi_mobile/src/profile/pages/profile_edit_page.dart';
import 'package:tandi_mobile/src/profile/pages/profile_page.dart';
import 'package:tandi_mobile/src/pulses_data/cubit/pulses_data_cubit.dart';
import 'package:tandi_mobile/src/pulses_data/pages/pulses_data_page.dart';
import 'package:tandi_mobile/src/register/cubit/register_cubit.dart';
import 'package:tandi_mobile/src/register/pages/register_page.dart';
import 'package:tandi_mobile/src/register/widgets/register_success_page.dart';
import 'package:tandi_mobile/src/saldo_topup/cubit/saldo_topup_cubit.dart';
import 'package:tandi_mobile/src/saldo_topup/pages/saldo_topup_page.dart';
import 'package:tandi_mobile/src/saldo_transfer/cubit/saldo_transfer_cubit.dart';
import 'package:tandi_mobile/src/saldo_transfer/pages/saldo_transfer_detail_page.dart';
import 'package:tandi_mobile/src/saldo_transfer/pages/saldo_transfer_page.dart';
import 'package:tandi_mobile/src/splash/cubit/splash_cubit.dart';
import 'package:tandi_mobile/src/splash/pages/splash_page.dart';
import 'package:tandi_mobile/src/tour_travel/cubit/calendar_cubit.dart';
import 'package:tandi_mobile/src/tour_travel/cubit/tour_travel_cubit.dart';
import 'package:tandi_mobile/src/tour_travel/cubit/tour_travel_detail_cubit.dart';
import 'package:tandi_mobile/src/tour_travel/cubit/tour_travel_order_cubit.dart';
import 'package:tandi_mobile/src/tour_travel/cubit/tour_travel_ticket_cubit.dart';
import 'package:tandi_mobile/src/tour_travel/pages/tour_travel_dashboard_page.dart';
import 'package:tandi_mobile/src/tour_travel/pages/tour_travel_detail_page.dart';
import 'package:tandi_mobile/src/tour_travel/pages/tour_travel_order_page.dart';
import 'package:tandi_mobile/src/tour_travel/pages/tour_travel_search_location_page.dart';
import 'package:tandi_mobile/src/transaction/cubit/transaction_history_cubit.dart';
import 'package:tandi_mobile/src/transaction/models/transaction_history_model.dart';
import 'package:tandi_mobile/src/transaction/pages/how_to_emoney_page.dart';
import 'package:tandi_mobile/src/transaction/pages/how_to_plnprepaid_page.dart';
import 'package:tandi_mobile/src/transaction/pages/transaction_page.dart';
import 'package:tandi_mobile/src/transfer/cubit/history_transfer_cubit.dart';
import 'package:tandi_mobile/src/transfer/cubit/transfer_cubit.dart';
import 'package:tandi_mobile/src/transfer/pages/transfer_bank_page.dart';
import 'package:tandi_mobile/src/transfer/pages/transfer_detail_page.dart';
import 'package:tandi_mobile/src/transfer/pages/transfer_page.dart';
import 'package:tandi_mobile/src/transfer/pages/transfer_wallet_page.dart';
import 'package:tandi_mobile/src/veea/cubit/customer_veea_cubit.dart';
import 'package:tandi_mobile/src/veea/cubit/generate_veea_cubit.dart';
import 'package:tandi_mobile/src/veea/cubit/pairing_veea_cubit.dart';
import 'package:tandi_mobile/src/veea/cubit/report_veea_cubit.dart';
import 'package:tandi_mobile/src/veea/pages/add_customer_pages.dart';
import 'package:tandi_mobile/src/veea/pages/generate_veea_page.dart';
import 'package:tandi_mobile/src/veea/pages/pairing_veea.dart';
import 'package:tandi_mobile/src/veea/pages/report_veea_pages.dart';
import 'package:tandi_mobile/src/veea/pages/voucher_veea_pages.dart';
import 'package:tandi_mobile/src/worship/cubit/vendor_cubit.dart';
import 'package:tandi_mobile/src/worship/cubit/worship_cubit.dart';
import 'package:tandi_mobile/src/worship/cubit/worship_history_cubit.dart';
import 'package:tandi_mobile/src/worship/pages/worship_page.dart';
import 'package:tandi_mobile/src/worship/states/image_cubit.dart';
import 'package:tandi_mobile/src/internet_voucher/pages/internet_voucher_pages.dart';

part '../enum/app_enum.dart';
part '../class/app_route.dart';
part '../class/app_parse.dart';
part '../model/app_model.dart';
part '../class/app_api.dart';
part '../class/app_assets.dart';

typedef Env = AppEnvironment;

class AppEnvironment {
  static Map<String, Widget Function(BuildContext)> routes = {
    for (AppRoute route in [
      AppRoute.splashPage,
      AppRoute.boardingPage,
      AppRoute.loginPage,
      AppRoute.forgotPasswordPage,
      AppRoute.registerPage,
      AppRoute.otpPage,
      AppRoute.registerSuccessPage,
      AppRoute.guestDashboardPage,
      AppRoute.dashboardPage,
      AppRoute.profilePage,
      AppRoute.profileEditPage,
      AppRoute.pinPage,
      AppRoute.pinForgotPage,
      AppRoute.changePasswordPage,
      AppRoute.selectPaymentMethodPage,
      AppRoute.paymentPage,
      AppRoute.subscribePaymentDetailPage,
      AppRoute.ppobPaymentDetailPage,
      AppRoute.transactionPage,
      AppRoute.worshipPage,
      AppRoute.guestWorshipPage,
      AppRoute.pulsesDataPage,
      AppRoute.guestPulsesPage,
      AppRoute.eWalletPage,
      AppRoute.eWalletNominalPage,
      AppRoute.guestEWalletPage,
      AppRoute.guestEWalletNominalPage,
      AppRoute.plnPage,
      AppRoute.guestPlnPage,
      AppRoute.plnConfirmationPage,
      AppRoute.eMoneyPage,
      AppRoute.guestEMoneyPage,
      AppRoute.transferPage,
      AppRoute.transferBankPage,
      AppRoute.transferEWalletPage,
      AppRoute.transferDetailPage,
      AppRoute.saldoTopupPage,
      AppRoute.saldoTransferPage,
      AppRoute.saldoTransferDetailPage,
      AppRoute.howToEMoneyPage,
      AppRoute.howToPlnPrepaidPage,
      AppRoute.bpjsPage,
      AppRoute.bpjsDetailPage,
      AppRoute.internetVoucherPage,
      AppRoute.formGeneratePage,
      AppRoute.voucherPage,
      AppRoute.pairingPage,
      AppRoute.voucherPaymentPage,
      AppRoute.reportProfitPage,
      AppRoute.pairingVeeaPage,
      AppRoute.generateVeeaPage,
      AppRoute.voucherVeeaPage,
      AppRoute.addCustomerPage,
      AppRoute.reportVeeaPage,
      AppRoute.tourTravelDashboardPage,
      AppRoute.bannerSelectionPage,
      AppRoute.travelSearchLocationPage,
      AppRoute.tourTravelDetailPage,
      AppRoute.tourTravelOrderPage,
      AppRoute.blankPage,
    ])
      route.path: (BuildContext context) => route.page
  };

  // default
  static String initialRoute = AppRoute.splashPage.path;
  static String dummyRoute = '';

  static AppScope scope = AppScope.external;
}
