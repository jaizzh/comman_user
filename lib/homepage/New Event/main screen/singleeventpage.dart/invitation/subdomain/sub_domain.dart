import 'package:common_user/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class SubdomainCreationPage extends StatefulWidget {
  const SubdomainCreationPage({super.key});

  @override
  State<SubdomainCreationPage> createState() => _SubdomainCreationPageState();
}

class _SubdomainCreationPageState extends State<SubdomainCreationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final List templatelist = [
    "assets/images/template1.png",
    "assets/images/template2.png",
    "assets/images/template3.png",
    "assets/images/template4.png",
  ];

  final TextEditingController _subdomainController = TextEditingController();

  int selectedTemplateIndex = 0;
  bool templateclosebool = false;
  bool isSubdomainValid = false;
  bool isChecking = false;
  String domainSuffix = "Mangal Mall.com";

  final List<TemplateData> temptemp = [
    TemplateData(
      id: "business",
      name: "Business Pro",
      description: "Professional business template with modern design",
      color: const Color(0xFF3B82F6),
      icon: Icons.business_center,
      //   features: ["SEO Optimized", "Mobile Responsive", "Contact Forms"],
      previewImage: "assets/templates/business.png",
    ),
    TemplateData(
      id: "ecommerce",
      name: "Modern Template",
      description: "Complete online store with payment integration",
      color: const Color(0xFF10B981),
      icon: Icons.shopping_cart,
      //   features: ["Payment Gateway", "Inventory Management", "Order Tracking"],
      previewImage: "assets/templates/ecommerce.png",
    ),
    TemplateData(
      id: "portfolio",
      name: "Premium",
      description: "Showcase your work with stunning visual layouts",
      color: const Color(0xFF8B5CF6),
      icon: Icons.palette,
      //   features: ["Gallery", "Blog", "Client Testimonials"],
      previewImage: "assets/templates/portfolio.png",
    ),
    TemplateData(
      id: "Indian Style Template",
      name: "Blog & News",
      description: "Modern blogging platform with social integration",
      color: const Color(0xFFF59E0B),
      icon: Icons.article,
      //   features: ["Social Media", "Comments", "Newsletter"],
      previewImage: "assets/templates/blog.png",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _subdomainController.dispose();
    super.dispose();
  }

  void _checkSubdomainAvailability() async {
    if (_subdomainController.text.isEmpty) return;

    setState(() => isChecking = true);

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isChecking = false;
      isSubdomainValid = _subdomainController.text.length >= 3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        _buildSubdomainSection(),
                        const SizedBox(height: 32),
                        if (templateclosebool == false) templateclose(),
                        if (templateclosebool == true) _buildTemplateSection(),
                        // const SizedBox(height: 32),
                        // _buildDescriptionSection(),
                        const SizedBox(height: 40),
                        _buildActionButtons(),
                        // const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 1,
                      blurRadius: 1,
                      color: Colors.black26,
                    )
                  ],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_ios_new, size: 22),
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Create Subdomain",
                      style: GoogleFonts.inter(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF111827),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSubdomainSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            spreadRadius: 1,
            blurRadius: 1,
            color: Colors.black26,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: 1, blurRadius: 1, color: Colors.black26)
                  ],
                  gradient: LinearGradient(
                    colors: [Colors.white, Colors.white],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.language,
                  color: AppColors.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Subdomain Name",
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF111827),
                      ),
                    ),
                    Text(
                      "Choose a unique subdomain for your website",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: isSubdomainValid
                    ? const Color(0xFF10B981)
                    : const Color(0xFFE5E7EB),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _subdomainController,
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        _checkSubdomainAvailability();
                      } else {
                        setState(() {
                          isSubdomainValid = false;
                          isChecking = false;
                        });
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "Enter subdomain name",
                      hintStyle: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.all(16),
                    ),
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF111827),
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F6),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: Text(
                    domainSuffix,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF6B7280),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          if (isChecking)
            Row(
              children: [
                const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                const SizedBox(width: 12),
                Text(
                  "Checking availability...",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          if (!isChecking && _subdomainController.text.isNotEmpty)
            Row(
              children: [
                Icon(
                  isSubdomainValid ? Icons.check_circle : Icons.cancel,
                  color: isSubdomainValid
                      ? const Color(0xFF10B981)
                      : const Color(0xFFEF4444),
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  isSubdomainValid
                      ? "Subdomain is available!"
                      : "Subdomain is not available or invalid",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isSubdomainValid
                        ? const Color(0xFF10B981)
                        : const Color(0xFFEF4444),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget templateclose() {
    return GestureDetector(
      onTap: () {
        setState(() {
          templateclosebool = true;
        });
      },
      child: Container(
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                spreadRadius: 1,
                blurRadius: 1,
                color: Colors.black38,
              )
            ]),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 1,
                    blurRadius: 1,
                    color: Colors.black26,
                  )
                ],
                gradient: LinearGradient(
                  colors: [Colors.white, Colors.white],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.dashboard_customize,
                color: AppColors.primary,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Choose Template",
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF111827),
                    ),
                  ),
                  Text(
                    "Select a template that fits your needs",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.white),
                child: Icon(
                  Icons.arrow_downward_rounded,
                  color: AppColors.primary,
                  size: 22.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTemplateSection() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            spreadRadius: 1,
            blurRadius: 1,
            color: Colors.black12,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 1,
                      blurRadius: 1,
                      color: Colors.black26,
                    )
                  ],
                  gradient: LinearGradient(
                    colors: [Colors.white, Colors.white],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.dashboard_customize,
                  color: AppColors.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Choose Template",
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF111827),
                      ),
                    ),
                    Text(
                      "Select a template that fits your needs",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      templateclosebool = false;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white),
                    child: Icon(
                      Icons.arrow_upward_rounded,
                      color: AppColors.primary,
                      size: 22.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              child: Row(
                children: [
                  category(
                      texter: "Wedding Party",
                      colorr: AppColors.primary,
                      colorr1: AppColors.primary,
                      colortext: Colors.white),
                  category(
                      texter: "Farewell",
                      colorr: Colors.black54,
                      colorr1: Colors.white,
                      colortext: Colors.black45),
                  category(
                      texter: "Anniversary",
                      colorr: Colors.black54,
                      colorr1: Colors.white,
                      colortext: Colors.black45),
                  category(
                      texter: "Inauguration",
                      colorr: Colors.black54,
                      colorr1: Colors.white,
                      colortext: Colors.black45),
                  category(
                      texter: "Other",
                      colorr: Colors.black54,
                      colorr1: Colors.white,
                      colortext: Colors.black45),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.760,
            ),
            itemCount: temptemp.length,
            itemBuilder: (context, index) {
              return templatecard(template: temptemp[index], index: index);
            },
          ),
        ],
      ),
    );
  }

  Widget category(
      {required String texter,
      required Color colorr,
      required Color colorr1,
      required Color colortext}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: colorr1,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: colorr, width: 0.0),
        ),
        child: Text(
          texter,
          style: TextStyle(
              fontSize: 15.0, fontWeight: FontWeight.bold, color: colortext),
        ),
      ),
    );
  }

  Widget templatecard({required TemplateData template, required int index}) {
    final isSelected = selectedTemplateIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTemplateIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: isSelected
              ? Border.all(color: AppColors.primary, width: 3.0)
              : Border.all(color: Colors.black38),
          boxShadow: [
            BoxShadow(spreadRadius: 1, blurRadius: 1, color: Colors.black38)
          ],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  //  padding: EdgeInsets.all(20.0),
                  height: MediaQuery.of(context).size.height * 0.150,
                  width: MediaQuery.of(context).size.width * 0.4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(templatelist[index])),
                  ),
                ),
                Positioned(
                    right: 8.0,
                    top: 8.0,
                    child: Container(
                      padding: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black26,
                      ),
                      child: Icon(
                        Icons.remove_red_eye_rounded,
                        color: Colors.white,
                      ),
                    ))
              ],
            ),
            SizedBox(
              height: 8.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  template.name,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF111827),
                  ),
                ),
              ],
            ),
            Text(
              template.description,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF6B7280),
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: 16),
        Expanded(
          flex: 2,
          child: ElevatedButton(
            onPressed: isSubdomainValid
                ? () {
                    _createSubdomain();
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.rocket_launch, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                Text(
                  "Create Subdomain",
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _createSubdomain() {
    // Show success dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Row(
          children: [
            const Icon(Icons.check_circle, color: Color(0xFF10B981), size: 28),
            const SizedBox(width: 12),
            Text(
              "Success!",
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your subdomain has been created successfully!",
              style: GoogleFonts.inter(fontSize: 16),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "${_subdomainController.text}$domainSuffix",
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF3B82F6),
                ),
              ),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF10B981),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              "Done",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TemplateData {
  final String id;
  final String name;
  final String description;
  final Color color;
  final IconData icon;
//  final List<String> features;
  final String previewImage;

  TemplateData({
    required this.id,
    required this.name,
    required this.description,
    required this.color,
    required this.icon,
    //   required this.features,
    required this.previewImage,
  });
}
