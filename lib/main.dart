import 'package:common_user/common/razorpay/razorpay.dart';
import 'package:common_user/homepage/New%20Event/main%20screen/planning%20tools/planningtoolspage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
    WidgetsFlutterBinding.ensureInitialized();
  RazorpayService.instance.init();
  runApp(ProviderScope(child: const   MyApp()));
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'coolie',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
       home: planningtools(),
    );
  }
}
