import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class PremiumChoosePlanContainer extends StatefulWidget {
  final Function(PlanType)? onPlanSelected;

  const PremiumChoosePlanContainer({
    Key? key,
    this.onPlanSelected,
  }) : super(key: key);

  @override
  State<PremiumChoosePlanContainer> createState() =>
      _PremiumChoosePlanContainerState();
}

class _PremiumChoosePlanContainerState extends State<PremiumChoosePlanContainer>
    with TickerProviderStateMixin {
  PlanType selectedPlan = PlanType.pro;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  final List<PlanData> plans = [
    PlanData(
      type: PlanType.basic,
      name: 'Basic',
      price: '\$9',
      period: '/month',
      description: 'Perfect for getting started',
      features: ['10 Projects', 'Basic Support', '2GB Storage'],
      color: const Color(0xFF6366F1),
      isPopular: false,
    ),
    PlanData(
      type: PlanType.pro,
      name: 'Pro',
      price: '\$29',
      period: '/month',
      description: 'Best for growing businesses',
      features: [
        '100 Projects',
        'Priority Support',
        '50GB Storage',
        'Advanced Analytics'
      ],
      color: const Color(0xFF8B5CF6),
      isPopular: true,
    ),
    PlanData(
      type: PlanType.premium,
      name: 'Premium',
      price: '\$99',
      period: '/month',
      description: 'For large enterprises',
      features: [
        'Unlimited Projects',
        '24/7 Support',
        '500GB Storage',
        'Custom Integrations'
      ],
      color: const Color(0xFFEC4899),
      isPopular: false,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    // Responsive breakpoints
    final isSmallScreen = width < 360;
    final isMediumScreen = width >= 360 && width < 600;
    final isTablet = width >= 600 && width < 900;

    // Responsive multipliers
    final paddingMultiplier = isSmallScreen
        ? 0.04
        : isMediumScreen
            ? 0.045
            : isTablet
                ? 0.05
                : 0.055;
    final spacingMultiplier = isSmallScreen
        ? 0.025
        : isMediumScreen
            ? 0.03
            : isTablet
                ? 0.035
                : 0.04;

    return Container(
      padding: EdgeInsets.all(width * paddingMultiplier),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(width, height),
          SizedBox(height: height * spacingMultiplier),
          _buildPlanCards(width, height),
          SizedBox(height: height * spacingMultiplier),
          _buildContinueButton(width, height),
        ],
      ),
    );
  }

  Widget _buildHeader(double width, double height) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Choose Your Plan',
          style: GoogleFonts.inter(
            fontSize: width * 0.06, // Responsive font size
            fontWeight: FontWeight.w900,
            color: Colors.black87,
            letterSpacing: -0.5,
          ),
        ),
        SizedBox(height: height * 0.01),
        Text(
          'Select the perfect plan for your needs. Upgrade or downgrade at any time.',
          style: GoogleFonts.inter(
            fontSize: width * 0.025, // Responsive font size
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade600,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildPlanCards(double width, double height) {
    return Column(
      children:
          plans.map((plan) => _buildPlanCard(plan, width, height)).toList(),
    );
  }

  Widget _buildPlanCard(PlanData plan, double width, double height) {
    final isSelected = selectedPlan == plan.type;
    final cardMargin = height * 0.02;
    final borderRadius = width * 0.05;
    final iconSize = width * 0.12;
    final checkIconSize = width * 0.04;

    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        setState(() {
          selectedPlan = plan.type;
        });
        if (isSelected) {
          _animationController.forward().then((_) {
            _animationController.reverse();
          });
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: EdgeInsets.only(bottom: cardMargin),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          gradient: isSelected
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    plan.color.withOpacity(0.1),
                    Colors.white,
                    plan.color.withOpacity(0.05),
                  ],
                )
              : LinearGradient(
                  colors: [Colors.white, Colors.grey.shade50],
                ),
          border: Border.all(
            color: isSelected ? plan.color : Colors.grey.shade200,
            width: isSelected ? 2.5 : 1.5,
          ),
          boxShadow: [
            if (isSelected) ...[
              BoxShadow(
                color: plan.color.withOpacity(0.25),
                blurRadius: 25,
                offset: const Offset(0, 10),
                spreadRadius: 0,
              ),
            ],
            BoxShadow(
              color: Colors.black.withOpacity(isSelected ? 0.1 : 0.05),
              blurRadius: isSelected ? 20 : 10,
              offset: Offset(0, isSelected ? 8 : 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(width * 0.06),
              child: Row(
                children: [
                  // Plan Icon and Selection Indicator
                  Container(
                    width: iconSize,
                    height: iconSize,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: isSelected
                            ? [plan.color, plan.color.withOpacity(0.8)]
                            : [Colors.grey.shade300, Colors.grey.shade200],
                      ),
                      borderRadius: BorderRadius.circular(iconSize * 0.3),
                      boxShadow: [
                        if (isSelected)
                          BoxShadow(
                            color: plan.color.withOpacity(0.4),
                            blurRadius: 15,
                            offset: const Offset(0, 6),
                          ),
                      ],
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(
                          _getPlanIcon(plan.type),
                          color:
                              isSelected ? Colors.white : Colors.grey.shade600,
                          size: iconSize * 0.5,
                        ),
                        if (isSelected)
                          Positioned(
                            top: iconSize * 0.08,
                            right: iconSize * 0.08,
                            child: Container(
                              width: checkIconSize,
                              height: checkIconSize,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.check,
                                color: plan.color,
                                size: checkIconSize * 0.6,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),

                  SizedBox(width: width * 0.05),

                  // Plan Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              plan.name,
                              style: GoogleFonts.inter(
                                fontSize: width * 0.05,
                                fontWeight: FontWeight.w800,
                                color: Colors.black87,
                              ),
                            ),
                            if (plan.isPopular) ...[
                              SizedBox(width: width * 0.02),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.025,
                                  vertical: height * 0.005,
                                ),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFFFF6B6B),
                                      Color(0xFFFF8E53),
                                    ],
                                  ),
                                  borderRadius:
                                      BorderRadius.circular(width * 0.025),
                                ),
                                child: Text(
                                  'POPULAR',
                                  style: GoogleFonts.inter(
                                    fontSize: width * 0.02,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        SizedBox(height: height * 0.005),
                        Text(
                          plan.description,
                          style: GoogleFonts.inter(
                            fontSize: width * 0.03,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        SizedBox(height: height * 0.01),
                        Row(
                          children: [
                            Text(
                              plan.price,
                              style: GoogleFonts.inter(
                                fontSize: width * 0.06,
                                fontWeight: FontWeight.w900,
                                color: isSelected ? plan.color : Colors.black87,
                              ),
                            ),
                            Text(
                              plan.period,
                              style: GoogleFonts.inter(
                                fontSize: width * 0.03,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Radio Button
                  Container(
                    width: width * 0.06,
                    height: width * 0.06,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected ? plan.color : Colors.grey.shade400,
                        width: 2,
                      ),
                      color: isSelected ? plan.color : Colors.transparent,
                    ),
                    child: isSelected
                        ? Icon(
                            Icons.check,
                            color: Colors.white,
                            size: width * 0.035,
                          )
                        : null,
                  ),
                ],
              ),
            ),

            // Animated Selection Overlay
            if (isSelected)
              Positioned.fill(
                child: AnimatedBuilder(
                  animation: _scaleAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _scaleAnimation.value,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(borderRadius),
                          gradient: LinearGradient(
                            colors: [
                              plan.color.withOpacity(0.1),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildContinueButton(double width, double height) {
    final selectedPlanData =
        plans.firstWhere((plan) => plan.type == selectedPlan);
    final buttonHeight = height * 0.07;
    final borderRadius = width * 0.04;

    return Container(
      width: double.infinity,
      height: buttonHeight,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            selectedPlanData.color,
            selectedPlanData.color.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: selectedPlanData.color.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius),
          onTap: () {
            HapticFeedback.mediumImpact();
            widget.onPlanSelected?.call(selectedPlan);
          },
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Continue with ${selectedPlanData.name}',
                  style: GoogleFonts.inter(
                    fontSize: width * 0.04,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 0.2,
                  ),
                ),
                SizedBox(width: width * 0.02),
                Icon(
                  Icons.arrow_forward_rounded,
                  color: Colors.white,
                  size: width * 0.05,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData _getPlanIcon(PlanType type) {
    switch (type) {
      case PlanType.basic:
        return Icons.rocket_launch_rounded;
      case PlanType.pro:
        return Icons.workspace_premium_rounded;
      case PlanType.premium:
        return Icons.diamond_rounded;
    }
  }
}

// Data Models
enum PlanType { basic, pro, premium }

class PlanData {
  final PlanType type;
  final String name;
  final String price;
  final String period;
  final String description;
  final List<String> features;
  final Color color;
  final bool isPopular;

  PlanData({
    required this.type,
    required this.name,
    required this.price,
    required this.period,
    required this.description,
    required this.features,
    required this.color,
    required this.isPopular,
  });
}
