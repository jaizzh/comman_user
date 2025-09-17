import 'package:common_user/homepage/New%20Event/3rd%20screen/maineventpage.dart';
import 'package:common_user/homepage/New%20Event/main%20screen/planning%20tools/planningtoolspage.dart';
import 'package:common_user/homepage/New%20Event/main%20screen/singleeventpage.dart/fisrthalfpage.dart';
import 'package:common_user/homepage/New%20Event/main%20screen/singleeventpage.dart/invitation/invitationhome.dart';
import 'package:common_user/homepage/New%20Event/main%20screen/singleeventpage.dart/invitation/subdomain/sub_domain.dart';
import 'package:common_user/homepage/New%20Event/main%20screen/singleeventpage.dart/invitation/videoinvitation/videoinvitation.dart';
import 'package:common_user/homepage/New%20Event/main%20screen/singleeventpage.dart/majorcont.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class singleventdashboard extends StatefulWidget {
  const singleventdashboard({super.key});

  @override
  State<singleventdashboard> createState() => _singleventdashboardState();
}

class _singleventdashboardState extends State<singleventdashboard> {
  bool planexpand = false;
  static const Color buttonColor = Color(0xFF9A2143);
  static const Color boxLightColor = Colors.white;
  static const Color primaryWhite = Colors.white;
  static const Color textDark = Colors.black87;

  final ScrollController _scrollController = ScrollController();
  bool _showTitle = false;
  final double _expandedHeight = 120.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.hasClients) {
        bool isCollapsed =
            _scrollController.offset > (_expandedHeight - kToolbarHeight);
        if (isCollapsed != _showTitle) {
          setState(() {
            _showTitle = isCollapsed;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  double _scaleForWidth(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = (w / 375.0).clamp(0.82, 1.6);
    return scale;
  }

  TextStyle _txt(BuildContext context,
      {double baseSize = 14,
      FontWeight weight = FontWeight.w600,
      Color? color,
      String? fontFamily}) {
    final s = _scaleForWidth(context);
    return GoogleFonts.getFont(
      fontFamily ?? 'Inter',
      fontSize: baseSize * s,
      fontWeight: weight,
      color: color ?? textDark,
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = _scaleForWidth(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          _buildPremiumAppBar(context),
          SliverToBoxAdapter(
            child: Column(
              children: [
                singledashhalf(),
                SizedBox(height: 8.0 * s),
                majorcont(), // kept as-is; assumes itself is responsive or sized adaptively
                _buildQuickActions(context),
                _buildFeatureCategories(context),
                _buildEventToolsGrid(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPremiumAppBar(BuildContext context) {
    final s = _scaleForWidth(context);
    return SliverAppBar(
      expandedHeight: _expandedHeight * s,
      pinned: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: _showTitle
          ? Text(
              'Free Plan',
              style: _txt(context,
                  baseSize: 15, weight: FontWeight.w600, color: primaryWhite),
            )
          : null,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          color: buttonColor,
        ),
        child: FlexibleSpaceBar(
          collapseMode: CollapseMode.pin,
          title: !_showTitle
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 6.0),
                        decoration: BoxDecoration(
                          color: primaryWhite.withOpacity(0.18),
                          borderRadius: BorderRadius.circular(12 * s),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.workspace_premium,
                              color: primaryWhite,
                              size: 15,
                            ),
                            SizedBox(
                              width: 6.0,
                            ),
                            Text(
                              "Upgrade To Premium Plan",
                              style: TextStyle(
                                  fontSize: 10.0,
                                  color: primaryWhite,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Text(
                    //   'Jaiz Birthday Party',
                    //   style: _localTxt(context,
                    //       baseSize: 13,
                    //       weight: FontWeight.w600,
                    //       color: primaryWhite),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    //   child: Container(
                    //     padding: EdgeInsets.all(8.0),
                    //     decoration: BoxDecoration(
                    //         color: AppColors.primary.withOpacity(0.1),
                    //         boxShadow: [
                    //           BoxShadow(
                    //             spreadRadius: 1,
                    //             blurRadius: 1,
                    //             color: Colors.black54,
                    //           )
                    //         ]),
                    //     // child: RichText(
                    //     //     text: TextSpan(
                    //     //         text: "Upgrade To Premium Plan",
                    //     //         style: TextStyle(
                    //     //             fontSize: 10.0,
                    //     //             fontWeight: FontWeight.bold,
                    //     //             color: Colors.white))),
                    //   ),
                    // )
                  ],
                )
              : null,
          centerTitle: false,
          titlePadding: EdgeInsets.only(left: 20 * s, bottom: 16 * s),
        ),
      ),
      leading: Padding(
        padding: EdgeInsets.all(8.0 * s),
        child: Container(
          decoration: BoxDecoration(
            color: primaryWhite.withOpacity(0.18),
            borderRadius: BorderRadius.circular(12 * s),
          ),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios_new,
                color: primaryWhite, size: 20 * s),
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => MinimalDemoPage())),
          ),
        ),
      ),
      actions: [
        _buildAppBarAction(context, Icons.notifications_on_rounded, () {}),
        _buildAppBarAction(context, Icons.more_vert_rounded, () {}),
        SizedBox(width: 8 * s),
      ],
    );
  }

  Widget _buildAppBarAction(
      BuildContext context, IconData icon, VoidCallback onTap) {
    final s = _scaleForWidth(context);
    return Padding(
      padding: EdgeInsets.only(right: 8.0 * s),
      child: Container(
        width: 44 * s,
        height: 44 * s,
        decoration: BoxDecoration(
          color: primaryWhite.withOpacity(0.18),
          borderRadius: BorderRadius.circular(12 * s),
        ),
        child: IconButton(
          icon: Icon(icon, color: primaryWhite, size: 20 * s),
          onPressed: onTap,
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    final s = _scaleForWidth(context);
    return Container(
      margin: EdgeInsets.all(20.0 * s),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Quick Actions',
              style: _txt(context, baseSize: 16, weight: FontWeight.w800)),
          SizedBox(height: 12.0 * s),
          Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  context,
                  'Planning Tools',
                  Icons.construction_rounded,
                  () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => planningtools())),
                ),
              ),
              SizedBox(width: 12 * s),
              Expanded(
                child: _buildActionButton(
                  context,
                  'Make Invitation',
                  Icons.mail_outline_rounded,
                  () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => InvitationHome())),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
      BuildContext context, String title, IconData icon, VoidCallback onTap) {
    final s = _scaleForWidth(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(14 * s),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14 * s),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 1,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8 * s),
              decoration: BoxDecoration(
                color: buttonColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10 * s),
              ),
              child: Icon(icon, color: buttonColor, size: 20 * s),
            ),
            SizedBox(width: 12 * s),
            Expanded(
              child: Text(title,
                  style: _txt(context,
                      baseSize: 14,
                      weight: FontWeight.w600,
                      color: Colors.black)),
            ),
            Icon(Icons.arrow_forward_ios_rounded,
                color: Colors.black, size: 16 * s),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCategories(BuildContext context) {
    final s = _scaleForWidth(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20 * s),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Event Features',
              style: _txt(context, baseSize: 16, weight: FontWeight.w800)),
          SizedBox(height: 8 * s),
          _buildFeatureGrid(context),
        ],
      ),
    );
  }

  Widget _buildFeatureGrid(BuildContext context) {
    final s = _scaleForWidth(context);

    final features = [
      FeatureItem(
          'Gift Registry', Icons.card_giftcard_rounded, 0.2, '1/5', Colors.red,
          ontappee: () {}),
      FeatureItem(
        'Money Log',
        Icons.attach_money_rounded,
        0.4,
        '2/4',
        Colors.purpleAccent,
        ontappee: () {},
      ),
      FeatureItem(
        'Gift Log',
        Icons.card_membership_rounded,
        0.1,
        '1/10',
        Colors.lightBlueAccent,
        ontappee: () {},
      ),
      FeatureItem(
        'Money Gifts',
        Icons.monetization_on_rounded,
        0.54,
        '4/6',
        Colors.green,
        ontappee: () {},
      ),
      FeatureItem(
          'Video Invitation', Icons.group_rounded, 0.65, '2/3', Colors.teal,
          ontappee: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => videoinvitation()));
      }),
      FeatureItem(
          'Sub-Domain', Icons.live_tv_rounded, 0.0, 'Ready', Colors.indigo,
          ontappee: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => SubdomainCreationPage()));
      }),
    ];

    // responsive columns: <=420 -> 2, <=900 -> 2, >900 -> 3 (you can tune breakpoints)
    final width = MediaQuery.of(context).size.width;
    int crossAxisCount = 2;
    if (width >= 1000) {
      crossAxisCount = 3;
    } else if (width >= 700) {
      crossAxisCount = 2;
    } else {
      crossAxisCount = 2;
    }

    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: features.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio:
              (width / crossAxisCount) / (150 * s), // approximate height adapt
          crossAxisSpacing: 12 * s,
          mainAxisSpacing: 12 * s,
          mainAxisExtent: MediaQuery.of(context).size.height * 0.120),
      itemBuilder: (context, index) {
        final f = features[index];
        return _buildFeatureCard(context, f);
      },
    );
  }

  Widget _buildFeatureCard(BuildContext context, FeatureItem feature) {
    final s = _scaleForWidth(context);
    return GestureDetector(
      onTap: feature.ontappee,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8 * s),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 1,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8 * s),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 1,
                        blurRadius: 1,
                        color: Colors.black12,
                      )
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10 * s),
                    border: Border.all(color: buttonColor.withOpacity(0.06)),
                  ),
                  child: Icon(feature.icon,
                      color: feature.iconcolor, size: 20 * s),
                ),
                const Spacer(),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8 * s, vertical: 4 * s),
                  decoration: BoxDecoration(
                    color: boxLightColor,
                    borderRadius: BorderRadius.circular(10 * s),
                  ),
                  child: Text(
                    feature.status,
                    style: GoogleFonts.inter(
                      fontSize: 11 * s,
                      fontWeight: FontWeight.w600,
                      color: textDark,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 4 * s),
            Text(
              feature.title,
              style: GoogleFonts.inter(
                fontSize: 14 * s,
                fontWeight: FontWeight.w700,
                color: textDark,
              ),
            ),
            SizedBox(height: 8 * s),
            ClipRRect(
              borderRadius: BorderRadius.circular(4 * s),
              child: LinearProgressIndicator(
                value: feature.progress.clamp(0.0, 1.0),
                backgroundColor: Colors.black12,
                valueColor: AlwaysStoppedAnimation(buttonColor),
                minHeight: 6 * s,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventToolsGrid(BuildContext context) {
    final s = _scaleForWidth(context);

    final tools = [
      ToolItem('Money/Task Report', Icons.analytics_rounded, () {}),
      ToolItem('Chat To The Guest', Icons.chat_rounded, () {}),
      ToolItem('Manual Contact Entry', Icons.contact_phone_rounded, () {}),
    ];

    return Container(
      margin: EdgeInsets.all(20.0 * s),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Additional Tools',
              style: _txt(context, baseSize: 16, weight: FontWeight.w800)),
          //  SizedBox(height: 14 * s),
          Row(
            children: tools
                .map((tool) => Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: tools.indexOf(tool) < tools.length - 1
                              ? 12 * s
                              : 0,
                        ),
                        child: _buildToolCard(context, tool),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildToolCard(BuildContext context, ToolItem tool) {
    final s = _scaleForWidth(context);
    return GestureDetector(
      onTap: tool.onTap,
      child: Container(
        padding: EdgeInsets.all(14 * s),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10 * s),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      spreadRadius: 1, blurRadius: 1, color: Colors.black26)
                ],
                borderRadius: BorderRadius.circular(12 * s),
              ),
              child: Icon(tool.icon, color: buttonColor, size: 22 * s),
            ),
            SizedBox(height: 10 * s),
            Text(
              tool.title,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 12 * s,
                fontWeight: FontWeight.w600,
                color: textDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FeatureItem {
  final String title;
  final IconData icon;
  final double progress;
  final String status;
  final Color iconcolor;
  final VoidCallback? ontappee;

  FeatureItem(this.title, this.icon, this.progress, this.status, this.iconcolor,
      {required this.ontappee});
}

class ToolItem {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  ToolItem(this.title, this.icon, this.onTap);
}
