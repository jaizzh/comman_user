import 'package:common_user/common/razorpay/razoreventplan.dart';
import 'package:common_user/common/razorpay/razorpay.dart';
import 'package:common_user/features/product/widgets/cart_provider.dart';
import 'package:common_user/features/product/widgets/gift_registry_provider.dart';
import 'package:common_user/features/profile/widgets/user_provider.dart';
import 'package:common_user/features/splash/presentation/pages/splash_screen.dart';
import 'package:common_user/features/venue/presentation/model/location_provider.dart';
import 'package:common_user/homepage/New%20Event/main%20screen/singleeventpage.dart/plannn/notification.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as legacy;
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SimpleAwesomeNotification.init();
  RazorpayService.instance.init();
  RazorpayServiceevent.instance.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    legacy.MultiProvider(
      providers: [
        legacy.ChangeNotifierProvider(create: (_) => LocationProvider()),
        legacy.ChangeNotifierProvider(create: (_) => CartProvider()),
        legacy.ChangeNotifierProvider(create: (_) => GiftRegistryProvider()),
        legacy.ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const ProviderScope(
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        home: SplashScreen(),
      ),
    );
  }
}
