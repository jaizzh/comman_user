import 'package:common_user/common/colors.dart';
import 'package:common_user/homepage/New%20Event/3rd%20screen/maineventpage.dart';
import 'package:common_user/homepage/New%20Event/main%20screen/planning%20tools/planningtoolspage.dart';
import 'package:common_user/homepage/New%20Event/main%20screen/singleeventpage.dart/fisrthalfpage.dart';
import 'package:common_user/homepage/New%20Event/main%20screen/singleeventpage.dart/invitation/invitationhome.dart';
import 'package:common_user/homepage/New%20Event/main%20screen/singleeventpage.dart/majorcont.dart';
import 'package:common_user/homepage/New%20Event/main%20screen/singleeventpage.dart/timer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class singleventdashboard extends StatefulWidget {
  const singleventdashboard({super.key});

  @override
  State<singleventdashboard> createState() => _singleventdashboardState();
}

class _singleventdashboardState extends State<singleventdashboard> {
  bool planexpand = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: AppColors.boxlightcolor,
        toolbarHeight: MediaQuery.of(context).size.height * 0.06,
        backgroundColor: AppColors.boxlightcolor,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
              size: 18.0,
            ),
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => demopage())),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.card_giftcard_rounded,
                color: Colors.black,
                size: 18.0,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.edit,
                color: Colors.black,
                size: 18.0,
              ))
        ],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              singledashhalf(),
              SizedBox(
                height: 12.0,
              ),
              majorcont(),
              SizedBox(
                height: 20.0,
              ),
              commontools(),
              SizedBox(
                height: 20.0,
              ),
              labell("Event Features"),
              SizedBox(
                height: 8.0,
              ),
              planning(),
              SizedBox(
                height: 10.0,
              ),
              threefiles(),
              SizedBox(
                height: 15.0,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                width: double.infinity,
                child: Image.asset(fit: BoxFit.cover, "assets/images/temp.jpg"),
              ),
            ],
          ),
        ),
      )),
    );
  }

  Widget labell(String text) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              text,
              style: GoogleFonts.inter(
                color: AppColors.buttoncolor,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );

  Widget commontools() {
    return SizedBox(
        child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          commmontoolcontainer(
              toolname: "Gift Registry",
              toolvalue: 0.2,
              colodf: Colors.amberAccent.shade400,
              Subtoolname: 'Add Some Gift Registry',
              valuesstring: '1/5'),
          commmontoolcontainer(
              toolname: "Invitation",
              toolvalue: 0.4,
              colodf: Colors.cyanAccent,
              Subtoolname: 'Make invitation for your event',
              valuesstring: '1/4'),
          commmontoolcontainer(
              toolname: "Video Invitation",
              toolvalue: 0.1,
              colodf: Colors.greenAccent,
              Subtoolname: 'Video invitation for your gustes',
              valuesstring: '1/10'),
          commmontoolcontainer(
              toolname: "Money Gifts Report",
              toolvalue: 0.542,
              colodf: Colors.tealAccent,
              Subtoolname: 'Receive your money gift',
              valuesstring: '4/6'),
          commmontoolcontainer(
              toolname: "Co-Hosts",
              toolvalue: 0.651,
              colodf: Colors.amberAccent.shade100,
              Subtoolname: 'Collab with your friends & family',
              valuesstring: '2/3'),
        ],
      ),
    ));
  }

  Widget commmontoolcontainer({
    required String toolname,
    required double toolvalue,
    required Color colodf,
    required String Subtoolname,
    required String valuesstring,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.085,
        width: MediaQuery.of(context).size.width * 0.440,
        decoration: BoxDecoration(
          color: colodf,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: CircularProgressIndicator(
                      value: toolvalue,
                      strokeWidth: 5,
                      backgroundColor: Colors.grey.shade300,
                      valueColor:
                          const AlwaysStoppedAnimation(Color(0xFF9A2143)),
                    ),
                  ),
                  Text(
                    valuesstring,
                    style: const TextStyle(
                        fontSize: 11.0,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10.0),

            // 👇 Expanded gives text enough width to wrap into 2 lines
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    toolname,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 12.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    Subtoolname,
                    maxLines: 2, // allow 2 lines
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 11.0,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget planning() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => planningtools()));
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6.0),
              boxShadow: [
                BoxShadow(
                  spreadRadius: 1,
                  blurRadius: 1,
                  color: Colors.black26,
                )
              ]),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 6.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Planning Tools",
                    style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.buttoncolor)),
                SizedBox(
                  width: 4.0,
                ),
                Icon(
                  Icons.construction,
                  color: AppColors.buttoncolor,
                  size: 16.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget invitecontainer() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }

  Widget threefiles() {
    // PDF (Layout Docs)
    const layoutDocs = FileBadge(
      title: 'Live Stream Link',
      fileType: 'PDF',
      sizeLabel: '10MB',
      bgColor: const Color(0xFFF8D9DC), // pastel blush
      iconBg: const Color(0xFFF2A7B2), // deeper pink
      icon: Icons.picture_as_pdf, // close match to Acrobat glyph
    );

// MOV (Presentation)
    final presentation = FileBadge(
      title: 'Invitation Upload',
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => InvitationHome()));
      },
      fileType: 'MOV',
      sizeLabel: '10MB',
      bgColor: const Color(0xFFDCEBFF), // pastel blue
      iconBg: const Color(0xFF78B6FF), // deeper blue
      icon: Icons.movie_creation_rounded,
    );

    const comingsoon = FileBadge(
      title: 'Add Google Map',
      fileType: 'MOV',
      sizeLabel: '10MB',
      bgColor: const Color(0xFFDCEBFF), // pastel blue
      iconBg: Color.fromARGB(255, 255, 146, 107), // deeper blue
      icon: Icons.location_on_rounded,
    );

// ZIP (All Assets)
    const allAssets = FileBadge(
      title: 'Expense Report',
      fileType: 'ZIP',
      sizeLabel: '10MB',
      bgColor: const Color(0xFFFBE7CC), // pastel sand
      iconBg: const Color(0xFFF0B85A), // deeper amber
      icon: Icons.folder_zip_rounded, // or Icons.archive_rounded
    );

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          layoutDocs,
          presentation,
          comingsoon,
          allAssets,
        ],
      ),
    );
  }
}

class FileBadge extends StatelessWidget {
  const FileBadge({
    super.key,
    required this.title,
    required this.fileType, // e.g., "PDF"
    required this.sizeLabel, // e.g., "10MB"
    required this.bgColor, // pastel square (outer)
    required this.iconBg, // deeper inner tile
    required this.icon, // use a close-looking icon
    this.onTap,
    this.squareSize = 72, // outer square size
  });

  final String title;
  final String fileType;
  final String sizeLabel;
  final Color bgColor;
  final Color iconBg;
  final IconData icon;
  final double squareSize;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Pastel rounded square with subtle shadow
          Container(
            width: MediaQuery.of(context).size.width * 0.190,
            height: MediaQuery.of(context).size.height * 0.085,
            // decoration: BoxDecoration(
            //   color: bgColor,
            //   borderRadius: BorderRadius.circular(8),
            //   boxShadow: [
            //     BoxShadow(
            //       color: Colors.black.withOpacity(0.06),
            //       blurRadius: 10,
            //       offset: const Offset(0, 4),
            //     ),
            //   ],
            // ),
            child: Center(
              // inner rounded tile
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: squareSize * 0.4,
                    height: squareSize * 0.4,
                    decoration: BoxDecoration(
                      color: iconBg,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(icon,
                        color: Colors.white, size: squareSize * 0.30),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    title,
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        height: 1.0),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
