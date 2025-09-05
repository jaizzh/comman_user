import 'package:common_user/features/vendor/pages/vendor_home.dart';
import 'package:common_user/features/venue/presentation/pages/venue_home.dart';
import 'package:common_user/homepage/dashboard%20page/homepage.dart';
import 'package:common_user/homepage/dashboard%20page/bottomnavigation.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  MainPage({super.key});
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _index = 0;

  final _pages = [
    homepage(),
    VenueHome(), // 1
    VendorHome(), // 2
    // VendorHome(), // 3
    // VendorHome() // 4
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _index, children: _pages),
      bottomNavigationBar: FancyBottomNav(
        currentIndex: _index,
        onChanged: (i) => setState(() => _index = i),
      ),
    );
  }
}
