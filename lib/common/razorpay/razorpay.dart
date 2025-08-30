import 'package:common_user/common/razorpay/razorbool.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:common_user/common/razorpay/razorsuccess.dart';
import 'package:common_user/homepage/dashboard%20page/mainpage.dart';

class RazorpayService {
  RazorpayService._();
  static final RazorpayService instance = RazorpayService._();

  final Razorpay _razorpay = Razorpay();
  bool _inited = false;

  BuildContext? _lastContext; // capture context for callbacks
  int _lastAmountPaise = 0;   // e.g., to show in success dialog

  void init() {
    if (_inited) return;
    _inited = true;

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, (PaymentSuccessResponse r) async {
      final ctx = _lastContext;
      if (ctx == null) return;

      EventGate.showEventSummary.value = true;
         Navigator.of(ctx).push(MaterialPageRoute(builder: (_)=> MainPage()));
      // 1) optional: show success dialog
      await showPaymentSuccessDialog(ctx, amountPaise: _lastAmountPaise, orderId: r.orderId);

      // 2) go to success page (replace or push as you prefer)
      Navigator.of(ctx).pushReplacement(
        MaterialPageRoute(builder: (_) => MainPage()),
      );
    });

    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, (PaymentFailureResponse r) {
      final ctx = _lastContext;
      if (ctx == null) return;
      EventGate.showEventSummary.value = false;
      // Navigate to error page with details
      // Navigator.of(ctx).push(
      //   MaterialPageRoute(
      //     builder: (_) => FailurePage(
      //       code: r.code,
      //       message: r.message ?? 'Payment failed',
      //     ),
      //   ),
      // );
    });

    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, (ExternalWalletResponse r) {
      debugPrint("Wallet: ${r.walletName}");
    });
  }

  void openCheckout({
    required BuildContext context,  // <-- capture context here
    required String keyId,
    required int amountPaise,
    String? orderId,
  }) {
    _lastContext = context;
    _lastAmountPaise = amountPaise;

    final options = {
      'key': keyId,
      'amount': amountPaise, // int paise
      if (orderId != null) 'order_id': orderId,
      'name': 'Your Company',
      'description': 'Order #1234',
      'retry': {'enabled': true, 'max_count': 1},
      'prefill': {'contact': '9876543210', 'email': 'user@example.com'},
      'theme': {'color': '#9A2143'},
    };

    try {
      _razorpay.open(options);
    } catch (e, st) {
      debugPrint('Razorpay open() error: $e\n$st');
    }
  }

  void dispose() => _razorpay.clear();
}


// import 'package:common_user/common/razorpay/razorsuccess.dart';
// import 'package:common_user/homepage/dashboard%20page/mainpage.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';

// class RazorpayService {
//   RazorpayService._();
//   static final RazorpayService instance = RazorpayService._();

//   final Razorpay _razorpay = Razorpay();
//   bool _inited = false;

//   void init() {
//     if (_inited) return;
//     _inited = true;
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _onSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _onError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _onExternalWallet);
//   }

//   void openCheckout({
//     required String keyId,
//     required int amountPaise,
//     String? orderId,
//   }) {
//     final options = {
//       'key': keyId,
//       'amount': amountPaise,                 // int, paise
//       if (orderId != null) 'order_id': orderId,
//       'name': 'Your Company',
//       'description': 'Order #1234',
//       'retry': {'enabled': true, 'max_count': 1},
//       'prefill': {'contact': '9876543210', 'email': 'user@example.com'},
//       'theme': {'color': '#9A2143'},
//     };
//     try {
//       _razorpay.open(options);
//     } catch (e, st) {
//       debugPrint('Razorpay open() error: $e\n$st');
//     }
//   }

//   void _onSuccess(PaymentSuccessResponse r,BuildContext context) {
//     debugPrint("Success: ${r.paymentId}");
//     showPaymentSuccessDialog(context, amountPaise: 100);
//     Navigator.push(context, MaterialPageRoute(builder: (_) => MainPage()));
//   } 
//   void _onError  (PaymentFailureResponse r) 
//   {
//     debugPrint("Error: ${r.code} ${r.message}");
//   } 
//   void _onExternalWallet(ExternalWalletResponse r) => debugPrint("Wallet: ${r.walletName}");

//   void dispose() => _razorpay.clear();
// }

