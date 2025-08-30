import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class MyAppper extends StatelessWidget {
  const MyAppper({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: RazorpayTest());
  }
}

class RazorpayTest extends StatefulWidget {
  const RazorpayTest({super.key});
  @override
  State<RazorpayTest> createState() => _RazorpayTestState();
}

class _RazorpayTestState extends State<RazorpayTest> {
  late final Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, (r) {
      debugPrint('SUCCESS ${r.paymentId}');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Payment success')),
      );
    });
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, (r) {
      debugPrint('ERROR ${r.code} ${r.message}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${r.message}')),
      );
    });
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, (r) {
      debugPrint('WALLET ${r.walletName}');
    });
  }

  void _pay() {
    final options = {
      'key': 'rzp_test_qnICfDxMOIbOaI',  // your TEST key
      'amount': 500,                   // int, paise
      'name': 'Demo',
      'description': 'Test order',
      'retry': {'enabled': true, 'max_count': 1},
      'prefill': {'contact': '9999999999', 'email': 'test@example.com'},
      'theme': {'color': '#9A2143'},
    };
    try {
      _razorpay.open(options);
    } catch (e, st) {
      debugPrint('open() error: $e\n$st');
    }
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: ElevatedButton(onPressed: _pay, child: const Text('Pay ₹500'))),
    );
  }
}
