part of '../class/app_env.dart';

class AppRoute {
  const AppRoute({required this.path, required this.page});
  final String path;
  final Widget page;

  static AppRoute splashPage = AppRoute(
    path: 'splashPage',
    page: BlocProvider(
      create: (_) => SplashCubit()..splash(),
      child: const SplashPage(),
    ),
  );

  static AppRoute boardingPage = const AppRoute(
    path: 'boardingPage',
    page: BoardingPage(),
  );

  static AppRoute loginPage = AppRoute(
    path: 'loginPage',
    page: BlocProvider(
      create: (context) => LoginCubit(),
      child: const LoginPage(),
    ),
  );

  static AppRoute forgotPasswordPage = AppRoute(
    path: 'forgotPasswordPage',
    page: BlocProvider(
      create: (context) => ForgotPasswordCubit(),
      child: const ForgotPasswordPage(),
    ),
  );

  static AppRoute registerPage = AppRoute(
    path: 'registerPage',
    page: BlocProvider(
      create: (context) => RegisterCubit(),
      child: const RegisterPage(),
    ),
  );

  static AppRoute otpPage = AppRoute(
    path: 'otpPage',
    page: BlocProvider(
      create: (context) => OtpCubit(),
      child: Builder(
        builder: (context) {
          var modal = context.modal<Map<String, dynamic>?>();
          if (modal?['isResend'] == true) {
            context.read<OtpCubit>().resendOtp(
                  numberPhone: modal?['numberPhone'],
                );
          }
          return const OtpPage();
        },
      ),
    ),
  );

  static AppRoute registerSuccessPage = const AppRoute(
    path: 'registerSuccessPage',
    page: RegisterSuccessPage(),
  );

  static AppRoute dashboardPage = AppRoute(
    path: 'dashboardPage',
    page: MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ProfileCubit()..getProfile()),
        BlocProvider(create: (_) => HomepageCubit()),
        BlocProvider(
          create: (_) => TransactionHistoryCubit()..getTransactionHistory(),
        ),
        BlocProvider(
          create: (_) => BannerCubit()..getBanner(bannerSlug: BannerSlug.home),
        ),
        BlocProvider(create: (_) => LokasiCubit()),
      ],
      child: const DashboardPage(),
    ),
  );

  static AppRoute guestDashboardPage = AppRoute(
    path: 'guestDashboardPage',
    page: MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => BannerCubit()..getBanner(bannerSlug: BannerSlug.home),
        ),
      ],
      child: const GuestDashboardPage(),
    ),
  );

  static AppRoute worshipPage = AppRoute(
    path: 'worshipPage',
    page: MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ImageCubit()),
        BlocProvider(create: (_) => WorshipCubit()),
        BlocProvider(create: (_) => WorshipHistoryCubit()..getWorshipHistory()),
        BlocProvider(create: (_) => VendorCubit()..getVendor()),
        BlocProvider(
          create: (_) =>
              BannerCubit()..getBanner(bannerSlug: BannerSlug.hajiUmrah),
        ),
      ],
      child: const WorshipPage(),
    ),
  );

  static AppRoute guestWorshipPage = AppRoute(
    path: 'guestWorshipPage',
    page: MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ImageCubit()),
        BlocProvider(
          create: (_) =>
              BannerCubit()..getBanner(bannerSlug: BannerSlug.hajiUmrah),
        ),
      ],
      child: const GuestWorshipPage(),
    ),
  );

  static AppRoute profilePage = AppRoute(
    path: 'profilePage',
    page: MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => TransactionHistoryCubit()..getTransactionHistory(),
        ),
        BlocProvider(create: (_) => ProfileCubit()..getProfile()),
      ],
      child: const ProfilePage(),
    ),
  );

  static AppRoute profileEditPage = AppRoute(
    path: 'profileEditPage',
    page: MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ProfileCubit()..getProfile()),
        BlocProvider(create: (_) => ProfileEditCubit()),
        BlocProvider(create: (_) => PhotoProfileCubit()),
      ],
      child: const ProfileEditPage(),
    ),
  );

  static AppRoute pinPage = AppRoute(
    path: 'pinPage',
    page: BlocProvider(
      create: (_) => PinCubit(),
      child: const PinPage(),
    ),
  );

  static AppRoute pinForgotPage = AppRoute(
    path: 'pinForgotPage',
    page: BlocProvider(
      create: (_) => PinCubit(),
      child: const PinForgotPage(),
    ),
  );

  static AppRoute changePasswordPage = AppRoute(
    path: 'changePasswordPage',
    page: MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ChangePasswordCubit()),
      ],
      child: const ChangePasswordPage(),
    ),
  );

  static AppRoute selectPaymentMethodPage = AppRoute(
    path: 'selectPaymentMethodPage',
    page: MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => PaymentCubit()),
      ],
      child: Builder(builder: (context) {
        var modal = context.modal<Map<String, dynamic>?>();

        double amount = modal?['amount'] ?? 0;

        log('amount : $amount', name: 'selectPaymentMethodPage');
        context.read<PaymentCubit>().getPaymentMethod(amount: amount);

        return const SelectPaymentMethodPage();
      }),
    ),
  );

  static AppRoute paymentPage = AppRoute(
    path: 'paymentPage',
    page: MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => PaymentCubit()),
        BlocProvider(create: (_) => PpobPaymentDetailCubit()),
        BlocProvider(create: (_) => PinCubit()),
      ],
      child: Builder(
        builder: (context) {
          var modal = context.modal<Map<String, dynamic>?>();
          double amount = 0;
          if (modal?['product'].runtimeType.toString() == 'PlnCustomerModel') {
            amount = AppFunction.extractNumberFromString(
                modal?['product'].totalBayar);
          } else {
            amount = modal?['product'].priceSell ?? 10000;
          }

          log('amount : $amount', name: 'paymentPageRoute');
          context.read<PaymentCubit>().getPaymentMethod(amount: amount);

          return const PaymentPage();
        },
      ),
    ),
  );

  static AppRoute subscribePaymentDetailPage = AppRoute(
    path: 'subscribePaymentDetailPage',
    page: MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SubscribePaymentDetailCubit()),
        BlocProvider(create: (_) => ProfileCubit()),
      ],
      child: Builder(
        builder: (context) {
          var args = context.modal<Map<String, dynamic>?>();

          String paymentMethod;

          if (args?['transactionable'] == null) {
            log('with paymentMethod');
            log('${args?['paymentMethod']}');
            paymentMethod = args?['paymentMethod']!;
          } else {
            log('with transactionable');
            Transactionable? transactionable = args?['transactionable'];

            paymentMethod = transactionable!.method;
          }

          context
              .read<SubscribePaymentDetailCubit>()
              .postInquirySubscribe(paymentMethod: paymentMethod);

          return const SubscribePaymentDetailPage();
        },
      ),
    ),
  );

  static AppRoute ppobPaymentDetailPage = AppRoute(
    path: 'ppobPaymentDetailPage',
    page: MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => PpobPaymentDetailCubit()),
      ],
      child: Builder(
        builder: (context) {
          var args = context.modal<Map<String, dynamic>?>();

          log('history :${args?['history']}');

          if (args?['history'] == null) {
            log('ppob new inquiry');
            var paymentMethod = args?['paymentMethod'];
            var paymentImage = args?['paymentImage'];
            var receiveNumber = args?['receiveNumber'];
            var product = args?['product'];
            var isTagihanPln = args?['isTagihanPln'];

            log('paymentImage : $paymentImage', name: 'ppobPaymentDetailPage');
            log('paymentMethod : $paymentMethod',
                name: 'ppobPaymentDetailPage');
            log('receiveNumber : $receiveNumber',
                name: 'ppobPaymentDetailPage');
            log('product: ${product.runtimeType}',
                name: 'ppobPaymentDetailPage');
            log('isTagihanPln: $isTagihanPln', name: 'ppobPaymentDetailPage');

            log('inquiryCount : ${context.read<PpobPaymentDetailCubit>().inquiryCount}',
                name: 'ppobPaymentDetailPage');

            // log('Isi VoucherPaymentModel : ${product}',
            //     name: 'ppobPaymentDetailPage');

            if (context.read<PpobPaymentDetailCubit>().inquiryCount == 0) {
              if (product.runtimeType.toString() == 'TopUpModel') {
                context.read<PpobPaymentDetailCubit>().postInquiryTopupWallet(
                      amount: product.priceSell,
                      paymentMethod: paymentMethod,
                    );
              } else if (product.runtimeType.toString() ==
                  'VoucherPaymentModel') {
                // log('isi voucher payment di post inquiry');
                context.read<PpobPaymentDetailCubit>().postInquiryPpob(
                      productId: product!.productId,
                      receiveNumber: receiveNumber,
                      paymentMethod: paymentMethod,
                      isTagihanPln: isTagihanPln,
                      isBayarVoucher: true,
                      productVoucher: product,
                    );
              } else if (product.runtimeType.toString() == 'VeeaPaymentModel') {
                // log('isi voucher payment di post inquiry');
                context.read<PpobPaymentDetailCubit>().postInquiryPpob(
                      productId: product!.productId,
                      receiveNumber: receiveNumber,
                      paymentMethod: paymentMethod,
                      isTagihanPln: isTagihanPln,
                      isBayarVoucher: true,
                      productVoucher: product,
                    );
              } else if (product.runtimeType.toString() == 'AdsConfirmModel') {
                context.read<PpobPaymentDetailCubit>().postInquiryBanner(
                      model: product,
                      paymentMethod: paymentMethod,
                    );
              } else if (product.runtimeType.toString() ==
                  'TourTravelProductModel') {
                context.read<PpobPaymentDetailCubit>().postInquiryTourTravel(
                      model: product,
                      paymentMethod: paymentMethod,
                    );
              } else {
                context.read<PpobPaymentDetailCubit>().postInquiryPpob(
                      productId: isTagihanPln ? 'PLN' : product!.id,
                      receiveNumber: receiveNumber,
                      paymentMethod: paymentMethod,
                      isTagihanPln: isTagihanPln,
                    );
              }
            }

            context.read<PpobPaymentDetailCubit>().inquiryCount++;
          } else {
            log('ppob continue inquiry (History)');
          }

          return const PpobPaymentDetailPage();
        },
      ),
    ),
  );

  static AppRoute voucherPaymentPage = AppRoute(
    path: 'voucherPaymentPage',
    page: MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => VoucherPaymentCubit()),
        BlocProvider(create: (_) => PaymentCubit()),
        BlocProvider(create: (_) => PpobPaymentDetailCubit()),
        BlocProvider(create: (_) => PinCubit()),
      ],
      child: Builder(
        builder: (context) {
          var modal = context.modal<Map<String, dynamic>?>();
          double amount = 0;

          log(modal?['product'].totalBayarVoucher, name: 'modal-amount');

          amount = double.tryParse(modal?['product'].totalBayarVoucher) ?? 0.0;

          log('amount : $amount', name: 'voucherPaymentPageRoute');
          context.read<PaymentCubit>().getPaymentMethod(amount: amount);

          return const VoucherPaymentPage();
        },
      ),
    ),
  );

  static AppRoute transactionPage = AppRoute(
    path: 'transactionPage',
    page: MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => TransactionHistoryCubit()
              ..getTransactionHistory(isFull: true)
              ..generateMonthYearList()),
      ],
      child: const TransactionPage(),
    ),
  );

  static AppRoute pulsesDataPage = AppRoute(
    path: 'pulsesDataPage',
    page: MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => PulsesDataCubit()..getHistoryPulsesData(),
        ),
      ],
      child: const PulsesDataPage(),
    ),
  );

  static AppRoute guestPulsesPage = AppRoute(
    path: 'guestPulsesPage',
    page: MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => GuestPulsesCubit()),
      ],
      child: const GuestPulsePage(),
    ),
  );

  static AppRoute eWalletPage = AppRoute(
    path: 'eWalletPage',
    page: MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => EWalletCubit()..getHistoryEWallet(),
        ),
      ],
      child: const EWalletPage(),
    ),
  );

  static AppRoute eWalletNominalPage = AppRoute(
    path: 'eWalletNominalPage',
    page: MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => EWalletCubit()),
        BlocProvider(create: (_) => ProfileCubit()..getProfile()),
      ],
      child: const EWalletNominalPage(),
    ),
  );

  static AppRoute guestEWalletPage = AppRoute(
    path: 'guestEWalletPage',
    page: MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => GuestEwalletCubit()),
      ],
      child: const GuestEwalletPage(),
    ),
  );

  static AppRoute guestEWalletNominalPage = AppRoute(
    path: 'guestEWalletNominalPage',
    page: MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => GuestEwalletCubit()),
      ],
      child: const GuestEwalletNominalPage(),
    ),
  );

  static AppRoute plnPage = AppRoute(
    path: 'plnPage',
    page: MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => PlnCubit()
            ..getHistoryPln()
            ..getPlnPrePaidProduct(),
        ),
        BlocProvider(create: (_) => PlnCustomerCubit()),
      ],
      child: const PlnPage(),
    ),
  );

  static AppRoute guestPlnPage = AppRoute(
    path: 'guestPlnPage',
    page: MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => GuestPlnCubit()..getPlnPrePaidProduct()),
        BlocProvider(create: (_) => GuestPlnCustomerCubit()),
      ],
      child: const GuestPlnPage(),
    ),
  );

  static AppRoute plnConfirmationPage = AppRoute(
    path: 'plnConfirmationPage',
    page: MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => PlnCustomerCubit()),
      ],
      child: const PlnConfirmationPage(),
    ),
  );

  static AppRoute eMoneyPage = AppRoute(
    path: 'eMoneyPage',
    page: MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => EMoneyCubit()..getHistoryEWallet()),
      ],
      child: const EMoneyPage(),
    ),
  );

  static AppRoute guestEMoneyPage = AppRoute(
    path: 'guestEMoneyPage',
    page: MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => GuestEmoneyCubit()),
      ],
      child: const GuestEmoneyPage(),
    ),
  );

  static AppRoute transferPage = AppRoute(
    path: 'transferPage',
    page: MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => TransferCubit()),
        BlocProvider(
            create: (_) =>
                BannerCubit()..getBanner(bannerSlug: BannerSlug.transfer)),
      ],
      child: const TransferPage(),
    ),
  );

  static AppRoute transferBankPage = AppRoute(
    path: 'transferBankPage',
    page: MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => TransferCubit()..getListTransfer(type: 'BANK')),
        BlocProvider(
            create: (_) =>
                HistoryTransferCubit()..getHistoryTransfer(category: 'BANK')),
      ],
      child: const TransferBankPage(),
    ),
  );

  static AppRoute transferEWalletPage = AppRoute(
    path: 'transferEWalletPage',
    page: MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => TransferCubit()..getListTransfer(type: 'EWALLET')),
        BlocProvider(
            create: (_) => HistoryTransferCubit()
              ..getHistoryTransfer(category: 'EWALLET')),
      ],
      child: const TransferEWalletPage(),
    ),
  );

  static AppRoute transferDetailPage = AppRoute(
    path: 'transferDetailPage',
    page: MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => TransferCubit()),
        BlocProvider(create: (_) => PinCubit()),
        BlocProvider(create: (_) => ProfileCubit()..getProfile()),
      ],
      child: const TransferDetailPage(),
    ),
  );

  static AppRoute saldoTopupPage = AppRoute(
    path: 'saldoTopupPage',
    page: MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SaldoTopupCubit()),
        BlocProvider(
            create: (_) =>
                BannerCubit()..getBanner(bannerSlug: BannerSlug.isiSaldo)),
      ],
      child: const SaldoTopupPage(),
    ),
  );

  static AppRoute saldoTransferPage = AppRoute(
    path: 'saldoTransferPage',
    page: MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SaldoTransferCubit()),
        BlocProvider(
          create: (_) =>
              HistoryTransferCubit()..getHistoryTransfer(category: 'TRANSFER'),
        ),
      ],
      child: const SaldoTransferPage(),
    ),
  );

  static AppRoute saldoTransferDetailPage = AppRoute(
    path: 'saldoTransferDetailPage',
    page: MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SaldoTransferCubit()),
        BlocProvider(create: (_) => ProfileCubit()..getProfile()),
      ],
      child: const SaldoTransferDetailPage(),
    ),
  );

  static AppRoute howToEMoneyPage = const AppRoute(
    path: 'howToEMoneyPage',
    page: HowToEmoneyPage(),
  );

  static AppRoute howToPlnPrepaidPage = const AppRoute(
    path: 'howToPlnPrepaidPage',
    page: HowToPlnPrepaidPage(),
  );

  static AppRoute bpjsPage = AppRoute(
    path: 'bpjsPage',
    page: MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => BpjsCubit()),
      ],
      child: const BpjsPage(),
    ),
  );

  static AppRoute bpjsDetailPage = AppRoute(
    path: 'bpjsDetailPage',
    page: MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => BpjsCubit()),
      ],
      child: const BpjsDetailPage(),
    ),
  );

  static AppRoute internetVoucherPage = AppRoute(
    path: 'internetVoucherPage',
    page: MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LokasiCubit()..cekToken()),
        BlocProvider(
          create: (_) =>
              BannerCubit()..getBanner(bannerSlug: BannerSlug.internetVoucher),
        ),
        BlocProvider(create: (_) => BannerCubit()),
        BlocProvider(create: (_) => PinCubit()),
        BlocProvider(create: (_) => PairingCubit()),
      ],
      child: const InternetVoucherPage(),
    ),
  );

  static AppRoute formGeneratePage = AppRoute(
      path: 'formGeneratePage',
      page: MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => VoucherCubit()),
            BlocProvider(create: (_) => GenerateCubit()),
          ],
          child: Builder(builder: (context) {
            var args = context.modal<Map<String, dynamic>?>();

            context
                .read<VoucherCubit>()
                .getVoucher(idLokasi: args?['id_lokasi']);

            return const FormGeneratePage();
          })
          // const FormGeneratePage(),
          ));

  static AppRoute voucherPage = const AppRoute(
    path: 'voucherPage',
    page: VoucherPage(),
    // MultiBlocProvider(
    //   providers: [
    //     BlocProvider(create: (_) => LokasiCubit()..getLokasi()),
    //   ],
    //   child: const VoucherPage(),
    // ),
  );

  static AppRoute voucherVeeaPage = const AppRoute(
    path: 'voucherVeeaPage',
    page: VoucherVeeaPage(),
  );

  static AppRoute pairingPage = AppRoute(
      path: 'pairingWeb',
      page: MultiBlocProvider(
        providers: [BlocProvider(create: (_) => PairingCubit())],
        child: const PairingWeb(),
      ));

  static AppRoute reportProfitPage = AppRoute(
    path: 'reportProfitPage',
    page: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ReportCubit()),
        ],
        child: Builder(
          builder: (context) {
            var args = context.modal<Map<String, dynamic>?>();

            context.read<ReportCubit>().getInfo(idLokasi: args?['idLokasi']);

            return const ReportPage();
          },
        )
        // ReportPage(),
        ),
  );

  static AppRoute pairingVeeaPage = AppRoute(
    path: 'pairingVeeaPage',
    page: MultiBlocProvider(
      providers: [BlocProvider(create: (_) => PairingVeeaCubit())],
      child: const PairingVeea(),
    ),
    // PairingVeea(),
  );

  static AppRoute addCustomerPage = AppRoute(
    path: 'addCustomerPage',
    page: MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CustomerVeeaCubit(),
        )
      ],
      child: const AddCustomer(),
    ),
  );

  static AppRoute generateVeeaPage = AppRoute(
    path: 'generateVeeaPage',
    page: MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => GenerateVeeaCubit()..getJenisVoucher(),
        ),
        BlocProvider(
          create: (_) => CustomerVeeaCubit(),
        )
      ],
      child: const GenerateVeea(),
    ),
  );

  static AppRoute reportVeeaPage = AppRoute(
    path: 'reportVeeaPage',
    page: MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ReportVeeaCubit()..veeaHistory(),
        ),
      ],
      child: const ReportVeeaPage(),
    ),
  );

  static AppRoute bannerSelectionPage = AppRoute(
    path: 'bannerSelectionPage',
    page: MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => BannerSelectionCubit()),
        BlocProvider(create: (_) => ImageCubit()),
        BlocProvider(create: (_) => PinCubit()),
        BlocProvider(create: (_) => PpobPaymentDetailCubit()),
      ],
      child: Builder(builder: (context) {
        var modal = context.modal<Map<String, dynamic>?>();

        context.read<BannerSelectionCubit>().setBannerLocation(
              modal?['locationBanner'] ?? '',
            );

        context.read<BannerSelectionCubit>().getAdsPricing(
              bannerSlug: modal?['bannerSlug'] ?? '',
            );
        return const BannerSelectionPage();
      }),
    ),
  );

  // static AppRoute tourTravelPage = AppRoute(
  //   path: 'tourTravelPage',
  //   page: MultiBlocProvider(
  //     providers: [
  //       BlocProvider(
  //         create: (_) => TourTravelCubit()..getTourTravel(),
  //       ),
  //       BlocProvider(
  //         create: (_) =>
  //             BannerCubit()..getBanner(bannerSlug: BannerSlug.tourTravel),
  //       ),
  //     ],
  //     child: const TourTravelPage(),
  //   ),
  // );

  static AppRoute tourTravelDashboardPage = AppRoute(
    path: 'tourTravelDashboardPage',
    page: MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => TourTravelCubit()..getTourTravel(),
        ),
        BlocProvider(
          create: (_) =>
              BannerCubit()..getBanner(bannerSlug: BannerSlug.tourTravel),
        ),
        BlocProvider(
          create: (_) => TourTravelTicketCubit()..getTourTravelTicket(),
        ),
      ],
      child: const TourTravelDashboardPage(),
    ),
  );

  static AppRoute travelSearchLocationPage = AppRoute(
    path: 'travelSearchLocationPage',
    page: MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => TourTravelCubit(),
        ),
      ],
      child: const TourTravelSearchLocationPage(),
    ),
  );

  static AppRoute tourTravelDetailPage = AppRoute(
    path: 'tourTravelDetailPage',
    page: MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => TourTravelDetailCubit()),
        BlocProvider(
          create: (_) => CalendarCubit()..getDaysInMonth(DateTime.now()),
        ),
      ],
      child: Builder(builder: (context) {
        var modal = context.modal<Map<String, dynamic>?>();

        String tourId = modal?['tourId']!;
        context
            .read<TourTravelDetailCubit>()
            .getTourTravelDetail(tourId: tourId);

        return const TourTravelDetailPage();
      }),
    ),
  );

  static AppRoute tourTravelOrderPage = AppRoute(
    path: 'tourTravelOrderPage',
    page: MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => TourTravelOrderCubit()..syncDataPassanger(),
        ),
        BlocProvider(create: (_) => PpobPaymentDetailCubit()),
        BlocProvider(create: (_) => PinCubit()),
      ],
      child: Builder(
        builder: (context) {
          var modal = context.modal<Map<String, dynamic>?>();

          context.read<TourTravelOrderCubit>().setData(
                tourDetail: modal!['tourDetail'],
                package: modal['package'],
              );

          context
              .read<TourTravelOrderCubit>()
              .setSelectedDate(date: modal['date']);
          return const TourTravelOrderPage();
        },
      ),
    ),
  );

  static AppRoute blankPage = const AppRoute(
    path: 'blankPage',
    page: BlankPage(),
  );
}
