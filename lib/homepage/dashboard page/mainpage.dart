import 'package:common_user/features/venue/presentation/pages/venue_home.dart';
import 'package:common_user/homepage/dashboard%20page/bottomnavigation.dart';
import 'package:common_user/homepage/dashboard%20page/homepage.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _index = 0;

  // TODO: replace these with your real pages
  final _pages = const <Widget>[
    homepage(), // 0
    VenueHome(),
    // VendorTab(),      // 2
    // SendGiftTab(),    // 3
    // InvitationTab(),  // 4
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
