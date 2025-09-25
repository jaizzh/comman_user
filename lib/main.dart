import 'package:common_user/common/razorpay/razoreventplan.dart';
import 'package:common_user/common/razorpay/razorpay.dart';
import 'package:common_user/features/venue/presentation/model/location_provider.dart';
import 'package:common_user/homepage/New%20Event/main%20screen/singleeventpage.dart/common/giftmoneylog/providersvalues.dart'; // Add this import
import 'package:common_user/homepage/New%20Event/main%20screen/singleeventpage.dart/plannn/notification.dart';
import 'package:common_user/homepage/dashboard%20page/mainpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SimpleAwesomeNotification.init();
  RazorpayService.instance.init();
  RazorpayServiceevent.instance.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // MultiProvider use பண்ணி multiple providers add பண்ணுங்க
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocationProvider()),
        ChangeNotifierProvider(
            create: (_) => formvalues()), // Add your formvalues provider
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      home: MainPage(),
    );
  }
}
