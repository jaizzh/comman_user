import 'package:common_user/homepage/New%20Event/main%20screen/singleeventpage.dart/plannn/notification.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayServiceeventplan {
  RazorpayServiceeventplan._();
  static final RazorpayServiceeventplan instance = RazorpayServiceeventplan._();

  final Razorpay _razorpay = Razorpay();
  bool _inited = false;

  BuildContext? _lastContext;
  int _selectedPlanIndex = 1; // Add this to track selected plan

  void init() {
    if (_inited) return;
    _inited = true;

    // ✅ Fixed: Removed BuildContext from callback signature
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
        (PaymentSuccessResponse response) async {
      final ctx = _lastContext;
      if (ctx == null || !ctx.mounted) return; // ✅ Check if context is valid

      debugPrint('Payment Success: ${response.paymentId}');

      // ✅ Small delay to ensure Razorpay overlay is closed
      await Future.delayed(const Duration(milliseconds: 500));

      // ✅ Use _lastContext, not the non-existent context parameter
      if (ctx.mounted) {
        _showSuccessDialog(ctx);
      }
    });

    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
        (PaymentFailureResponse response) {
      final ctx = _lastContext;
      if (ctx == null || !ctx.mounted) return;

      debugPrint('Payment Error: ${response.code} - ${response.message}');
      //   SimpleNotificationService.init();
      SimpleNotificationService.showNotification(
          title: "Your Premium Plan Was Unlocked",
          body:
              "You're Unlocked More Features By Upgrading the Plan To The Premium");
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Payment failed: ${response.message ?? response.code.toString()}',
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    });

    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
        (ExternalWalletResponse response) {
      debugPrint("External wallet: ${response.walletName}");
    });
  }

  void openCheckout({
    required BuildContext context,
    required String keyId,
    required int amountPaise,
    required int selectedPlanIndex, // ✅ Add this parameter
    String? orderId,
  }) {
    _lastContext = context;
    _selectedPlanIndex = selectedPlanIndex; // ✅ Store selected plan

    final options = {
      'key': keyId,
      'amount': amountPaise, // in paise
      if (orderId != null) 'order_id': orderId,
      'name': 'Your Company',
      'description': 'Premium Plan Subscription',
      'retry': {'enabled': true, 'max_count': 1},
      'prefill': {'contact': '9876543210', 'email': 'user@example.com'},
      'theme': {'color': '#9A2143'},
    };

    try {
      _razorpay.open(options);
    } catch (e, st) {
      debugPrint('Razorpay open() error: $e\n$st');

      // Show error to user
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text('Failed to open payment: $e'),
          ),
        );
      }
    }
  }

  void dispose() => _razorpay.clear();

  void _showSuccessDialog(BuildContext context) {
    const List<String> planTitles = ['Basic', 'Standard', 'Premium'];
    const List<String> prices = ['\$9', '\$19', '\$35'];

    // ✅ Double-check context is still valid
    if (!context.mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false, // ✅ Prevent dismissing accidentally
      builder: (dialogContext) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle_outline,
                  color: Colors.green,
                  size: 48,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Payment Successful!',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${planTitles[_selectedPlanIndex]} Plan (${prices[_selectedPlanIndex]}/month)',
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Your premium features are now active!',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(dialogContext).pop(); // Close dialog
                    // ✅ Navigate to next screen or close current screen
                    Navigator.of(context).pop(true); // Return success result
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
