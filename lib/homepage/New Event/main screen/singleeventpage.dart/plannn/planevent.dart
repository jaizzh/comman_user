// ignore_for_file: prefer_const_constructors
import 'package:common_user/app_colors.dart';
import 'package:common_user/common/razorpay/razoreventplan.dart';
import 'package:flutter/material.dart';

class PremiumPlanEvent extends StatefulWidget {
  const PremiumPlanEvent({super.key});
  @override
  State<PremiumPlanEvent> createState() => _PremiumPlanEventState();
}

class _PremiumPlanEventState extends State<PremiumPlanEvent> {
  int selectedPlanIndex = 1; // Default Standard plan selected
  PageController pageController =
      PageController(initialPage: 1, viewportFraction: 0.8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildPremiumAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 10),
            _buildHeaderSection(),
            SizedBox(height: 10),
            _buildPlanCarousel(),
            SizedBox(height: 14),
            _buildSelectedPlanDetails(),
            Spacer(),
            _buildContinueButton(),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildPremiumAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      title: Text(
        "Choose Your Plan",
        style: TextStyle(
          fontSize: 17.5,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      leading: Container(
        margin: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.primary,
            size: 20,
          ),
          onPressed: () {
            Navigator.maybePop(context);
          },
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Text(
            "Unlock Premium Features",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 4),
          Text(
            "Choose the perfect plan for your needs",
            style: TextStyle(
              fontSize: 11,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanCarousel() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.550,
      child: PageView.builder(
        controller: pageController,
        onPageChanged: (index) {
          setState(() {
            selectedPlanIndex = index;
          });
        },
        itemCount: 3,
        itemBuilder: (context, index) {
          return AnimatedContainer(
            duration: Duration(milliseconds: 300),
            margin: EdgeInsets.symmetric(
                horizontal: 8, vertical: selectedPlanIndex == index ? 0 : 20),
            child: _buildPlanCard(index),
          );
        },
      ),
    );
  }

  Widget _buildPlanCard(int index) {
    List<Map<String, dynamic>> plans = [
      {
        'title': 'BASIC',
        'price': '9',
        'color1': Color(0xFF9A2143),
        'color2': Color(0xFF9A2143).withOpacity(0.5),
        'featuresicon': [
          Icons.event_note,
          Icons.group,
          Icons.design_services,
          Icons.email,
          Icons.web_stories_rounded,
          Icons.toll_outlined
        ],
        'featurevalue': [
          "50",
          "2",
          "Subdomain",
          "\$2000",
          "3",
          "10",
        ],
        'features': [
          'Invite People',
          'Vendor',
          'Gift Registry',
          'Money Gifts',
          "website",
          "Planning Tools"
        ],
        'isPopular': false,
      },
      {
        'title': 'STANDARD',
        'price': '19',
        'color1': Color(0xFF9A2143),
        'color2': Color(0xFF9A2143).withOpacity(0.5),
        'featurevalue': [
          "50",
          "2",
          "Subdomain",
          "\$2000",
          "3",
          "10",
        ],
        'features': [
          'Invite People',
          'Vendor',
          'Gift Registry',
          'Money Gifts',
          "website",
          "Planning Tools"
        ],
        'featuresicon': [
          Icons.event_note,
          Icons.group,
          Icons.design_services,
          Icons.email,
          Icons.web_stories_rounded,
          Icons.toll_outlined
        ],
        'isPopular': true,
      },
      {
        'title': 'PREMIUM',
        'price': '35',
        'color1': Color(0xFF9A2143),
        'color2': Color(0xFF9A2143).withOpacity(0.5),
        'featurevalue': [
          "50",
          "2",
          "Subdomain",
          "\$2000",
          "3",
          "10",
        ],
        'features': [
          'Invite People',
          'Vendor',
          'Gift Registry',
          'Money Gifts',
          "website",
          "Planning Tools"
        ],
        'featuresicon': [
          Icons.event_note,
          Icons.group,
          Icons.design_services,
          Icons.email,
          Icons.web_stories_rounded,
          Icons.toll_outlined
        ],
        'isPopular': false,
      },
    ];

    final plan = plans[index];
    final isSelected = selectedPlanIndex == index;

    return GestureDetector(
      onTap: () {
        pageController.animateToPage(index,
            duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
      },
      child: Card(
        elevation: 4.0,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border:
                isSelected ? Border.all(color: plan['color2'], width: 2) : null,
            boxShadow: [
              if (isSelected)
                BoxShadow(
                  color: plan['color2'].withOpacity(0.3),
                  blurRadius: 20,
                  spreadRadius: 5,
                  offset: Offset(0, 10),
                ),
            ],
          ),
          child: Stack(
            children: [
              // Popular badge
              if (plan['isPopular'])
                Positioned(
                  top: -5,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [plan['color1'], plan['color2']],
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        'MOST POPULAR',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),

              // Decorative circles
              _buildDecorativeCircles(plan['color2']),

              // Main content
              Padding(
                padding: EdgeInsets.all(0),
                child: Column(
                  children: [
                    SizedBox(height: plan['isPopular'] ? 20 : 15),

                    // Circular header
                    Container(
                      width: MediaQuery.of(context).size.height * 0.17,
                      height: MediaQuery.of(context).size.height * 0.2,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [plan['color1'], plan['color2']],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: plan['color2'].withOpacity(0.4),
                            blurRadius: 20,
                            offset: Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            plan['title'],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                            ),
                          ),
                          SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '\$',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                plan['price'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'PER\nMONTH',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              height: 1.1,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 10),

                    // Features list with icons
                    Expanded(
                      child: Column(
                        children: List.generate(
                          plan['features'].length,
                          (featureIndex) => _buildFeatureItem(
                            plan['features'][featureIndex],
                            plan['color2'],
                            plan['featuresicon'][featureIndex],
                            plan['featurevalue'][featureIndex],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDecorativeCircles(Color color) {
    return Stack(
      children: [
        Positioned(
          top: 60,
          left: 15,
          child: _decorativeCircle(8, color),
        ),
        Positioned(
          top: 100,
          right: 25,
          child: _decorativeCircle(6, color),
        ),
        Positioned(
          bottom: 150,
          left: 180,
          child: _decorativeCircle(10, color),
        ),
        Positioned(
          bottom: 80,
          right: 15,
          child: _decorativeCircle(8, color),
        ),
        Positioned(
          bottom: 40,
          right: 35,
          child: _decorativeCircle(6, color),
        ),
      ],
    );
  }

  Widget _decorativeCircle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withOpacity(0.6),
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildFeatureItem(
      String feature, Color accentColor, IconData iconss, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 14.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(top: 2),
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  iconss,
                  color: Colors.white,
                  size: 12,
                ),
              ),
              SizedBox(width: 12),
              Text(
                feature,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  height: 1.4,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(value),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildSelectedPlanDetails() {
    List<String> planTitles = ['Basic', 'Standard', 'Premium'];
    List<String> planDescriptions = [
      'Perfect for small events and personal use',
      'Ideal for growing businesses and regular events',
      'Complete solution for large-scale events'
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        elevation: 5.0,
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(spreadRadius: 1, blurRadius: 1, color: Colors.black26)
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.star_rounded,
                    color: Colors.amber,
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Text(
                    '${planTitles[selectedPlanIndex]} Plan Selected',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6),
              Text(
                planDescriptions[selectedPlanIndex],
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    List<Color> colors1 = [
      Color(0xFF9A2143),
      Color(0xFF9A2143),
      Color(0xFF9A2143),
    ];
    List<Color> colors2 = [
      Color(0xFF9A2143).withOpacity(0.7),
      Color(0xFF9A2143).withOpacity(0.7),
      Color(0xFF9A2143).withOpacity(0.7),
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.05,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [colors1[selectedPlanIndex], colors2[selectedPlanIndex]],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: colors2[selectedPlanIndex].withOpacity(0.4),
              blurRadius: 15,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: MaterialButton(
          onPressed: () {
            // Calculate amount based on selected plan
            //  final amounts = [900, 1900, 3500]; // In paise (₹9, ₹19, ₹35)
            // final amount = amounts[selectedPlanIndex];
            RazorpayServiceevent.instance.init();
            RazorpayServiceevent.instance.openCheckout(
                context: context,
                keyId: "rzp_test_1DP5mmOlF5G5ag",
                amountPaise: 10000);
            // // Initialize and open Razorpay
            // RazorpayServiceeventplan.instance.init();
            // RazorpayServiceeventplan.instance.openCheckout(
            //   context: context,
            //   keyId: "rzp_test_1DP5mmOlF5G5ag",
            //   amountPaise: amount,
            //   selectedPlanIndex: selectedPlanIndex, // Pass selected plan
            // );
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Continue with ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                ['Basic', 'Standard', 'Premium'][selectedPlanIndex],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8),
              Icon(
                Icons.arrow_forward_rounded,
                color: Colors.white,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
