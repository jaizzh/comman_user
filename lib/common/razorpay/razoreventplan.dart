import 'package:common_user/homepage/New%20Event/main%20screen/singleeventpage.dart/plannn/notification.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayServiceevent {
  RazorpayServiceevent._();
  static final RazorpayServiceevent instance = RazorpayServiceevent._();

  final Razorpay _razorpay = Razorpay();
  bool _inited = false;

  BuildContext? _lastContext;
  int _lastAmountPaise = 0;

  void init() {
    if (_inited) return;
    _inited = true;

    print('🔧 Initializing Razorpay callbacks...');

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
        (PaymentSuccessResponse r) async {
      print('🎉 SUCCESS CALLBACK TRIGGERED!');
      print('Payment ID: ${r.paymentId}');
      print('Order ID: ${r.orderId}');
      print('Signature: ${r.signature}');

      final ctx = _lastContext;
      if (ctx == null) {
        print('❌ Context is null in success callback');
        return;
      }

      // Small delay to ensure Razorpay UI is dismissed
      await Future.delayed(Duration(milliseconds: 500));
      SimpleAwesomeNotification.show("Premium Plan Activated",
          "You are unlocked the premium version of mangal mall.now you can access more feature");
      try {
        // Show success snackbar
        ScaffoldMessenger.of(ctx).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green, // Changed to green for success
            content: Text(
              'Payment Successful! ID: ${r.paymentId}',
              style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        );

        // Test notification
        // print('🔔 Sending test notification...');
        //   await SimpleAwesomeNotification.show('Payment Successful! 🎉',
        //       'Payment ID: ${r.paymentId ?? "Unknown"}');

        // print('✅ Success callback completed');
      } catch (e) {
        print('❌ Error in success callback: $e');
      }
    });

    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, (PaymentFailureResponse r) {
      print('❌ ERROR CALLBACK TRIGGERED!');
      print('Error Code: ${r.code}');
      print('Error Message: ${r.message}');

      final ctx = _lastContext;
      if (ctx == null) {
        print('❌ Context is null in error callback');
        return;
      }

      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Payment failed: ${r.message ?? r.code.toString()}',
            style: TextStyle(
                fontSize: 14.0,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
      );
    });

    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, (ExternalWalletResponse r) {
      print('💳 EXTERNAL WALLET TRIGGERED: ${r.walletName}');
    });

    print('✅ Razorpay callbacks initialized');
  }

  void openCheckout({
    required BuildContext context,
    required String keyId,
    required int amountPaise,
    String? orderId,
  }) {
    print('🚀 Opening Razorpay checkout...');
    print('Amount: $amountPaise paise');
    print('Key ID: $keyId');
    print('Order ID: $orderId');

    _lastContext = context;
    _lastAmountPaise = amountPaise;

    final options = {
      'key': keyId,
      'amount': amountPaise,
      if (orderId != null) 'order_id': orderId,
      'name': 'Your Company',
      'description': 'Test Payment',
      'timeout': 180, // Increased timeout
      'retry': {'enabled': true, 'max_count': 1}, // This is important!
      'prefill': {'contact': '9876543210', 'email': 'user@example.com'},
      'theme': {'color': '#9A2143'},
      'method': {
        'upi': true,
        'card': true,
        'netbanking': true,
        'wallet': true,
      },
    };

    try {
      print('📱 Calling _razorpay.open()...');
      _razorpay.open(options);
    } catch (e, st) {
      print('❌ Razorpay open() error: $e');
      print('Stack trace: $st');
    }
  }

  void dispose() {
    print('🧹 Disposing Razorpay...');
    _razorpay.clear();
  }
}
