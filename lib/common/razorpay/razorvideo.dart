import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
// import your dialog + pages:
import 'package:common_user/homepage/New Event/main screen/singleeventpage.dart/invitation/invitationhome.dart';
import 'package:common_user/homepage/New Event/main screen/singleeventpage.dart/invitation/videoinvitation/popup.dart';

class RazorpayServicevideo {
  RazorpayServicevideo._();
  static final RazorpayServicevideo instance = RazorpayServicevideo._();

  final Razorpay _razorpay = Razorpay();
  bool _inited = false;

  BuildContext? _lastContext;
  int _lastAmountPaise = 0;

  void init() {
    if (_inited) return;
    _inited = true;

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
        (PaymentSuccessResponse r) async {
      final ctx = _lastContext;
      if (ctx == null) return;

      // (Optional) tiny delay to ensure Razorpay overlay is gone
      await Future.microtask(() {});

      // Show your premium success dialog
      Navigator.of(ctx).push(
        MaterialPageRoute(builder: (_) => const InvitationHome()),
      );
      showPremiumSuccessDialog(
        context: ctx,
        title: "Payment Successful",
        message:
            "Your video invitation payment (₹${(_lastAmountPaise / 100).toStringAsFixed(0)}) is successful. Ready to create your video?",
        buttonText: "Continue",
        onButtonPressed: () {
          Navigator.of(ctx).pop(); // close dialog
        },
      );
    });

    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, (PaymentFailureResponse r) {
      final ctx = _lastContext;
      if (ctx == null) return;

      // You can show an error dialog/snackbar here if you like
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              'Payment failed: ${r.message ?? r.code.toString()}',
              style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            )),
      );
    });

    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, (ExternalWalletResponse r) {
      debugPrint("External wallet: ${r.walletName}");
    });
  }

  void openCheckout({
    required BuildContext context,
    required String keyId,
    required int amountPaise,
    String? orderId,
  }) {
    _lastContext = context;
    _lastAmountPaise = amountPaise;

    final options = {
      'key': keyId,
      'amount': amountPaise, // in paise
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
