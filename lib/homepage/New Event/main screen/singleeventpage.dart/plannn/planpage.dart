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
    final isTablet = size.width > 600;

    return Container(
      padding: EdgeInsets.all(isTablet ? 32 : 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(isTablet),
          SizedBox(height: isTablet ? 32 : 24),
          _buildPlanCards(isTablet),
          SizedBox(height: isTablet ? 32 : 24),
          _buildContinueButton(isTablet),
        ],
      ),
    );
  }

  Widget _buildHeader(bool isTablet) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Choose Your Plan',
          style: GoogleFonts.inter(
            fontSize: isTablet ? 32 : 28,
            fontWeight: FontWeight.w900,
            color: Colors.black87,
            letterSpacing: -0.5,
          ),
        ),
        SizedBox(height: isTablet ? 12 : 8),
        Text(
          'Select the perfect plan for your needs. Upgrade or downgrade at any time.',
          style: GoogleFonts.inter(
            fontSize: isTablet ? 16 : 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade600,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildPlanCards(bool isTablet) {
    return Column(
      children: plans.map((plan) => _buildPlanCard(plan, isTablet)).toList(),
    );
  }

  Widget _buildPlanCard(PlanData plan, bool isTablet) {
    final isSelected = selectedPlan == plan.type;

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
        margin: EdgeInsets.only(bottom: isTablet ? 20 : 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(isTablet ? 24 : 20),
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
              padding: EdgeInsets.all(isTablet ? 28 : 24),
              child: Row(
                children: [
                  // Plan Icon and Selection Indicator
                  Container(
                    width: isTablet ? 60 : 50,
                    height: isTablet ? 60 : 50,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: isSelected
                            ? [plan.color, plan.color.withOpacity(0.8)]
                            : [Colors.grey.shade300, Colors.grey.shade200],
                      ),
                      borderRadius: BorderRadius.circular(isTablet ? 18 : 15),
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
                          size: isTablet ? 28 : 24,
                        ),
                        if (isSelected)
                          Positioned(
                            top: 4,
                            right: 4,
                            child: Container(
                              width: isTablet ? 18 : 16,
                              height: isTablet ? 18 : 16,
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
                                size: isTablet ? 12 : 10,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),

                  SizedBox(width: isTablet ? 24 : 20),

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
                                fontSize: isTablet ? 22 : 20,
                                fontWeight: FontWeight.w800,
                                color: Colors.black87,
                              ),
                            ),
                            if (plan.isPopular) ...[
                              SizedBox(width: isTablet ? 12 : 8),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: isTablet ? 10 : 8,
                                  vertical: isTablet ? 4 : 3,
                                ),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      const Color(0xFFFF6B6B),
                                      const Color(0xFFFF8E53),
                                    ],
                                  ),
                                  borderRadius:
                                      BorderRadius.circular(isTablet ? 12 : 10),
                                ),
                                child: Text(
                                  'POPULAR',
                                  style: GoogleFonts.inter(
                                    fontSize: isTablet ? 10 : 8,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        SizedBox(height: isTablet ? 6 : 4),
                        Text(
                          plan.description,
                          style: GoogleFonts.inter(
                            fontSize: isTablet ? 14 : 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        SizedBox(height: isTablet ? 12 : 8),
                        Row(
                          children: [
                            Text(
                              plan.price,
                              style: GoogleFonts.inter(
                                fontSize: isTablet ? 28 : 24,
                                fontWeight: FontWeight.w900,
                                color: isSelected ? plan.color : Colors.black87,
                              ),
                            ),
                            Text(
                              plan.period,
                              style: GoogleFonts.inter(
                                fontSize: isTablet ? 14 : 12,
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
                    width: isTablet ? 28 : 24,
                    height: isTablet ? 28 : 24,
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
                            size: isTablet ? 16 : 14,
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
                          borderRadius:
                              BorderRadius.circular(isTablet ? 24 : 20),
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

  Widget _buildContinueButton(bool isTablet) {
    final selectedPlanData =
        plans.firstWhere((plan) => plan.type == selectedPlan);

    return Container(
      width: double.infinity,
      height: isTablet ? 60 : 54,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            selectedPlanData.color,
            selectedPlanData.color.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(isTablet ? 18 : 16),
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
          borderRadius: BorderRadius.circular(isTablet ? 18 : 16),
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
                    fontSize: isTablet ? 18 : 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 0.2,
                  ),
                ),
                SizedBox(width: isTablet ? 12 : 8),
                Icon(
                  Icons.arrow_forward_rounded,
                  color: Colors.white,
                  size: isTablet ? 22 : 20,
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
