// ignore_for_file: prefer_const_constructors

import 'package:common_user/app_colors.dart';
import 'package:common_user/homepage/New%20Event/main%20screen/singleeventpage.dart/common/giftmoneylog/moneyforms.dart';
import 'package:common_user/homepage/New%20Event/main%20screen/singleeventpage.dart/common/giftmoneylog/providersvalues.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MoneyLogger extends StatefulWidget {
  const MoneyLogger({super.key});

  @override
  State<MoneyLogger> createState() => _MoneyLoggerState();
}

class _MoneyLoggerState extends State<MoneyLogger>
    with TickerProviderStateMixin {
  late AnimationController _progressController;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    _progressController.forward();
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final screenHeight = size.height;
    final isSmallScreen = screenWidth < 360;
    final isTablet = screenWidth > 768;

    // ❌ REMOVE THIS - Provider already exists globally in main.dart
    // return ChangeNotifierProvider<formvalues>(
    //   create: (_) => formvalues(),
    //   child: Builder(...),
    // );

    // ✅ CORRECT - Direct Scaffold, use global provider
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                color: Colors.white,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeaderSection(isSmallScreen, screenWidth),
                    const SizedBox(height: 6),
                    _buildResponsiveTransactionCard(
                      context: context,
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,
                      isSmallScreen: isSmallScreen,
                      isTablet: isTablet,
                    ),
                    _buildResponsiveActionButtons(
                      context: context,
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,
                      isSmallScreen: isSmallScreen,
                      isTablet: isTablet,
                    ),
                    SizedBox(height: 20.0),
                    listofmonney(context), // ✅ Use global context
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget listofmonney(BuildContext context) {
    // ✅ Use context.watch to get global provider data
    return Consumer<formvalues>(
      builder: (context, provider, child) {
        final values = provider.getAllValues(); // Get all values from provider

        return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  spreadRadius: 1,
                  blurRadius: 1,
                  color: Colors.black26,
                )
              ]),
          child: Column(
            children: [
              SizedBox(height: 10),
              if (values.length == 0) emptymoney(),
              if (values.length > 0)
                Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Money Transaction Log",
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 14.0),

                      // Stats container
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 10.0),
                        height: MediaQuery.of(context).size.height * 0.05,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total money received",
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "${values.length}",
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 16),

                      // Money list
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: values.length,
                        itemBuilder: (context, index) {
                          final item = values[index];
                          return Card(
                            margin: EdgeInsets.only(bottom: 8),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: item['amountType'] == 'Cash'
                                    ? Colors.green
                                    : Colors.blue,
                                child: Icon(
                                  item['amountType'] == 'Cash'
                                      ? Icons.money
                                      : Icons.payment,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              title: Text(
                                item['name'] ?? 'Unknown',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Amount: ₹${item['amount']}'),
                                  if (item['mobile']?.isNotEmpty == true)
                                    Text('Mobile: ${item['mobile']}'),
                                ],
                              ),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    item['forWhom'] ?? '',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.purple,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    item['amountType'] ?? '',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey[600],
                                    ),
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
            ],
          ),
        );
      },
    );
  }

  Widget emptymoney() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50.0),
            Icon(
              Icons.card_giftcard_rounded,
              size: 40.0,
              color: Colors.black45,
            ),
            SizedBox(height: 10.0),
            Text(
              "No Money Gift Available",
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Colors.black45,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              "Start adding money to see them here",
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: Colors.black45,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection(bool isSmallScreen, double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20.0),
        Text(
          'Money Transaction Overview',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        Text(
          "Track and manage all received money from your guests in one centralized location. Monitor the money transactions with real-time updates and comprehensive reporting",
          style: TextStyle(
            fontSize: 12,
            color: Colors.black54,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildResponsiveTransactionCard({
    required BuildContext context,
    required double screenWidth,
    required double screenHeight,
    required bool isSmallScreen,
    required bool isTablet,
  }) {
    return Consumer<formvalues>(
      builder: (context, provider, child) {
        final values = provider.getAllValues();
        final totalAmount = provider.totalAmount;

        return Card(
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  spreadRadius: 1,
                  blurRadius: 8,
                  color: Colors.black.withOpacity(0.08),
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary.withOpacity(0.12),
                        border: Border.all(
                          color: AppColors.primary.withOpacity(0.3),
                          width: 1.5,
                        ),
                      ),
                      child: Icon(
                        Icons.card_giftcard_rounded,
                        color: AppColors.primary,
                        size: 22,
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.04),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: isTablet ? 3 : 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Money Log",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    Text(
                                      "Total transactions: ${values.length}",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  RichText(
                                    textAlign: TextAlign.right,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text:
                                              '₹${totalAmount.toStringAsFixed(0)}',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green.shade600,
                                          ),
                                        ),
                                        TextSpan(
                                          text: ' total',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    '${values.length} entries',
                                    style: TextStyle(
                                      fontSize: isTablet
                                          ? 12
                                          : (isSmallScreen ? 10 : 11),
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          _buildCustomProgressIndicator(
                            progressColor: Colors.green.shade600,
                            backgroundColor: Colors.grey.shade200,
                            height:
                                isTablet ? 12.0 : (isSmallScreen ? 8.0 : 10.0),
                            progress: values.isEmpty ? 0.0 : 0.7,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCustomProgressIndicator({
    required Color progressColor,
    required Color backgroundColor,
    required double height,
    required double progress,
  }) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(height / 2),
        color: backgroundColor,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(height / 2),
        child: AnimatedBuilder(
          animation: _progressController,
          builder: (context, child) {
            return LinearProgressIndicator(
              value: progress * _progressController.value,
              valueColor: AlwaysStoppedAnimation<Color>(progressColor),
              backgroundColor: Colors.transparent,
              minHeight: height,
            );
          },
        ),
      ),
    );
  }

  Widget _buildResponsiveActionButtons({
    required BuildContext context,
    required double screenWidth,
    required double screenHeight,
    required bool isSmallScreen,
    required bool isTablet,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: _buildDownloadButton(context: context),
          ),
          SizedBox(width: 20),
          Expanded(
            flex: 1,
            child: _buildAddGiftButton(context: context),
          ),
        ],
      ),
    );
  }
}

Widget _buildDownloadButton({required BuildContext context}) {
  return ElevatedButton.icon(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
    ),
    onPressed: () {
      // Add download functionality here
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Download functionality coming soon!')),
      );
    },
    icon: Icon(
      Icons.download_rounded,
      size: 22.0,
      color: Colors.black,
    ),
    label: Text(
      "Download",
      style: TextStyle(
        fontSize: 14.0,
        color: AppColors.black,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _buildAddGiftButton({required BuildContext context}) {
  return ElevatedButton.icon(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
    ),
    onPressed: () async {
      final result = await Navigator.push<bool>(
        context,
        MaterialPageRoute(
          builder: (context) => moneyLogForms(),
        ),
      );

      if (result == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("New money entry added!"),
            backgroundColor: Colors.green,
          ),
        );
      }
    },
    icon: Icon(Icons.add_rounded, size: 22.0),
    label: Text(
      "Add Money",
      style: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
