import 'package:common_user/common/colors.dart';
import 'package:common_user/homepage/New%20Event/main%20screen/singleeventpage.dart/timer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class singledashhalf extends StatefulWidget {
  const singledashhalf({super.key});

  @override
  State<singledashhalf> createState() => _singledashhalfState();
}

class _singledashhalfState extends State<singledashhalf> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          firstcont(),
        ],
      ),
    );
  }

  Widget firstcont() {
    return Stack(
      children: [
        Container(
          child: Column(
            children: [
              Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColors.boxboxlight,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.elliptical(200, 100),
                          bottomRight: Radius.elliptical(200, 100))),
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: Column(
                                  children: [
                                    Text(
                                      "jegaz Birthday Party",
                                      style: GoogleFonts.yaldevi(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.buttoncolor),
                                    ),
                                    SizedBox(
                                      height: 4.0,
                                    ),
                                    Row(
                                      children: [
                                        Text("Night Party",
                                            style: TextStyle(
                                                fontSize: 15.0,
                                                color: Colors.black54,
                                                fontWeight: FontWeight.bold)),
                                        SizedBox(
                                          width: 6.0,
                                        ),
                                        Container(
                                            height: 10.0,
                                            width: 2.0,
                                            color: Colors.black54),
                                        SizedBox(
                                          width: 6.0,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              color: Colors.black54,
                                              size: 16.0,
                                            ),
                                            Text(
                                              "Madhurai",
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 0.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                PremiumCountdownContainer(
                                  initialDuration:
                                      Duration(days: 12, hours: 5, minutes: 32),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Container(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Events Completed",
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  Text(
                                    "3/14",
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 4.0,
                              ),
                              ClipRRect(
                                  borderRadius:
                                      BorderRadiusGeometry.circular(8.0),
                                  child: LinearProgressIndicator(
                                    backgroundColor: Colors.white,
                                    value: 0.3,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.green),
                                    minHeight: 12.0,
                                    stopIndicatorRadius: 20.0,
                                    stopIndicatorColor: Colors.black,
                                  ))
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.0),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.workspace_premium_rounded,
                                  color: AppColors.buttoncolor,
                                  size: 20.0,
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Text(
                                  "Upgrade To Premium Plan",
                                  style: GoogleFonts.sahitya(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  )),
              Container(
                height: MediaQuery.of(context).size.height * 0.15,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: -MediaQuery.of(context).size.height * 0.01 +
              MediaQuery.of(context).size.height * 0.03,
          right: 0,
          left: 0,
          top: MediaQuery.of(context).size.height * 0.225,
          child: _buildPremiumVenueVendorSection(),
        ),
      ],
    );
  }

  Widget _buildPremiumVenueVendorSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: _buildUltraPremiumVenueCard(
                  title: "Venues",
                  subtitle: "Perfect locations for your event",
                  count: "0/1",
                  total: "100+ Premium Venues Available",
                  imagePath: "assets/images/vendoror.png",
                  color: const Color(0xFF3B82F6),
                  icon: Icons.location_city_rounded,
                  progress: 0.0,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: _buildUltraPremiumVenueCard(
                  title: "Vendors",
                  subtitle: "Trusted service partners",
                  count: "0/3",
                  total: "500+ Verified Vendors Available",
                  imagePath: "assets/images/venueor.png",
                  color: const Color(0xFF10B981),
                  icon: Icons.store_rounded,
                  progress: 0.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUltraPremiumVenueCard({
    required String title,
    required String subtitle,
    required String count,
    required String total,
    required String imagePath,
    required Color color,
    required IconData icon,
    required double progress,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 32,
            offset: const Offset(0, 16),
            spreadRadius: -4,
          ),
          BoxShadow(
            color: color.withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // Premium Header Section
          Stack(children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    color.withOpacity(0.08),
                    color.withOpacity(0.05),
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: Column(
                children: [
                  // Title Row
                  SizedBox(
                    height: 6.0,
                  ),
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  // Premium Image Display
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 90,
                              width: 90,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: color.withOpacity(0.3),
                                  width: 3,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: color.withOpacity(0.25),
                                    blurRadius: 16,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Image.asset(
                                  imagePath,
                                  height: 60,
                                  width: 60,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: color.withOpacity(0.1),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(icon, color: color, size: 36),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 8.0,
              right: 10.0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      color.withOpacity(0.15),
                      color.withOpacity(0.08),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: color.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Text(
                  count,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: color,
                  ),
                ),
              ),
            ),
          ]),

          // Premium Stats Section
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                Container(
                  height: 10,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        width:
                            MediaQuery.of(context).size.width * progress * 0.35,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [color, color.withOpacity(0.8)],
                          ),
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: color.withOpacity(0.4),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  total,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black45,
                  ),
                ),

                const SizedBox(height: 10),

                // Premium Action Button
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          color.withOpacity(0.15),
                          color.withOpacity(0.08),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: color.withOpacity(0.3),
                        width: 1.5,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Browse $title",
                          style: GoogleFonts.mukta(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: color,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.arrow_forward_rounded,
                          size: 18,
                          color: color,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 12.0,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
