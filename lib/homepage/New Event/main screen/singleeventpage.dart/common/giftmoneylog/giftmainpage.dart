import 'package:common_user/app_colors.dart';
import 'package:common_user/homepage/New%20Event/main%20screen/singleeventpage.dart/common/giftmoneylog/giftforms.dart';
import 'package:common_user/homepage/New%20Event/main%20screen/singleeventpage.dart/common/giftmoneylog/giftlog1.dart';
import 'package:common_user/homepage/New%20Event/main%20screen/singleeventpage.dart/common/giftmoneylog/providersvalues.dart';
import 'package:common_user/homepage/New%20Event/main%20screen/singleeventpage.dart/common/giftmoneylog/moneylogger.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GiftLog extends StatefulWidget {
  final List<Map<String, String>> initialGiftValues;

  const GiftLog(this.initialGiftValues, {super.key});

  @override
  State<GiftLog> createState() => _GiftLogState();
}

class _GiftLogState extends State<GiftLog> {
  @override
  void initState() {
    super.initState();
    // Add initial values to provider if any
    if (widget.initialGiftValues.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final provider = context.read<formvalues>();
        for (var item in widget.initialGiftValues) {
          provider.addValue(item);
        }
      });
    }
  }

  // ✅ FIXED: Proper navigation with data handling
  // Future<void> _openGiftForm() async {
  //   final result = await Navigator.push<List<Map<String, String>>>(
  //     context,
  //     MaterialPageRoute(builder: (context) => const GiftLogForms()),
  //   );

  //   // Handle the returned data
  //   if (result != null && result.isNotEmpty && mounted) {
  //     final provider = context.read<formvalues>();

  //     // Add all returned entries to provider
  //     for (var entry in result) {
  //       provider.addValue(entry);
  //     }

  //     // Show success message
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text("${result.length} gift entries added successfully!"),
  //         backgroundColor: Colors.green,
  //         duration: const Duration(seconds: 2),
  //       ),
  //     );
  //   }
  // }
  Future<void> _openGiftForm() async {
    print('🔵 Opening GiftLogForms...'); // Debug print

    final result = await Navigator.push<List<Map<String, String>>>(
      context,
      MaterialPageRoute(builder: (context) => const GiftLogForms()),
    );

    print('🔵 Received result: $result'); // Debug print

    // Handle the returned data
    if (result != null && result.isNotEmpty && mounted) {
      print('🔵 Adding ${result.length} items to provider'); // Debug print
      final provider = context.read<formvalues>();

      // Add all returned entries to provider
      for (var entry in result) {
        print('🔵 Adding entry: $entry'); // Debug print
        provider.addValue(entry); // This will call the alias method
      }

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("${result.length} gift entries added successfully!"),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );
    } else {
      print('🔴 No data received or empty result'); // Debug print
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final isSmallScreen = screenWidth < 360;

    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Container(
            margin:
                EdgeInsets.only(left: screenWidth * 0.04, top: 8, bottom: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black26, blurRadius: 8, offset: Offset(0, 2))
              ],
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_rounded,
                  color: AppColors.primary, size: isSmallScreen ? 18 : 20),
              onPressed: () => Navigator.maybePop(context),
            ),
          ),
          title: Text("Gift/Money Log",
              style: TextStyle(
                  fontSize: isSmallScreen ? 14.0 : 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              // Header with stats
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(screenWidth * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Jaiz Wedding",
                        style: TextStyle(
                            fontSize: isSmallScreen ? 16.0 : 18.0,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary)),
                    Text("Wedding-Party",
                        style: TextStyle(
                            fontSize: isSmallScreen ? 12.0 : 14.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54)),
                    const SizedBox(height: 10),

                    // Stats consumer
                    Consumer<formvalues>(
                      builder: (context, provider, child) {
                        final allItems = provider.getAllValues();
                        final giftItems = allItems
                            .where((item) => item.containsKey('giftname'))
                            .toList();
                        final packedCount = giftItems
                            .where((item) => item['giftType'] == 'Packed')
                            .length;
                        final unpackedCount = giftItems
                            .where((item) => item['giftType'] == 'Unpacked')
                            .length;

                        return Card(
                          elevation: 4.0,
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    color: Colors.black26)
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Text("Total Register",
                                    style: TextStyle(
                                        fontSize: isSmallScreen ? 14.0 : 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                                const SizedBox(height: 6),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    _buildSimpleStatItem("${giftItems.length}",
                                        "Gifts", isSmallScreen),
                                    Container(
                                        width: 1,
                                        height: 30,
                                        color: Colors.grey.shade300),
                                    _buildSimpleStatItem("$packedCount",
                                        "Packed", isSmallScreen),
                                    Container(
                                        width: 1,
                                        height: 30,
                                        color: Colors.grey.shade300),
                                    _buildSimpleStatItem("$unpackedCount",
                                        "Unpacked", isSmallScreen),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              // Tabs
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TabBar(
                  indicator: const UnderlineTabIndicator(
                    borderSide:
                        BorderSide(width: 3.0, color: AppColors.primary),
                    insets: EdgeInsets.symmetric(horizontal: 40),
                  ),
                  labelColor: AppColors.primary,
                  unselectedLabelColor: Colors.grey,
                  labelStyle: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                  tabs: const [Tab(text: "Gift Log"), Tab(text: "Money Log")],
                ),
              ),

              Expanded(
                child: TabBarView(
                  children: [
                    // ✅ Existing GiftLogger with provider data
                    Consumer<formvalues>(
                      builder: (context, provider, child) {
                        final giftItems = provider
                            .getAllValues()
                            .where((item) => item.containsKey('giftname'))
                            .toList();

                        return GiftLogger(
                          items: giftItems, // ✅ Real data from provider
                          onAddPressed: _openGiftForm,
                        );
                      },
                    ),
                    const MoneyLogger(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSimpleStatItem(String value, String label, bool isSmallScreen) {
    return Column(
      children: [
        Text(value,
            style: TextStyle(
                fontSize: isSmallScreen ? 18 : 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primary)),
        const SizedBox(height: 5),
        Text(label,
            style: TextStyle(
                fontSize: isSmallScreen ? 12 : 14,
                fontWeight: FontWeight.w500,
                color: Colors.black54)),
      ],
    );
  }
}
