import 'package:common_user/common/colors.dart';
import 'package:common_user/homepage/dashboard%20page/mainpage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileDemo extends StatelessWidget {
  const ProfileDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: _ProfileHeader()),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ---------- HEADER ----------
        Stack(
          children: [
            ClipPath(
              clipper: _WaveClipper(),
              child: Container(
                height: 250,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                     
                       Color.fromARGB(255, 216, 185, 107),
                        Color(0xFFEDD498),

                    ],
                  ),
                ),
              ),
            ),

            // top bar (back + menu)
            Positioned(
              left: 4,
              right: 10,
              top: 5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    color: Colors.black,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_)=> MainPage()));
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.menu_rounded),
                    color: Colors.black,
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            // content
            Positioned.fill(
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 20, right: 20, top: 64, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // avatar + name + follow button
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage("assets/images/jega.png")
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               Text(
                                'Marry',
                                style:GoogleFonts.mPlus1(
                                   color:  Colors.black54,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                // ) TextStyle(
                                 
                                //   height: 1.1,
                                // ),
                              ),
                              Row(
                                children: const [
                                  Icon(Icons.location_on_rounded,
                                      size: 16, color: Colors.black54),
                                  SizedBox(width: 7),
                                  Text(
                                    'China Beijing',
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        _FollowButton(
                          onPressed: () {},
                          labelColor: AppColors.buttoncolor,
                        ),
                      ],
                    ),

                    const SizedBox(height: 22),

                    // stats row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        _Stat(number: '648', label: 'No.of.events'),
                         SizedBox(width: 25.0,),
                        _Stat(number: '7', label: 'Current Events'),
                        SizedBox(width: 25.0,),
                        _Stat(number: '1046', label: 'Your Plan'),
                      SizedBox(width: 10.0,)
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Text(
            'Buckets',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.number, required this.label});
  final String number;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          number,
          style: GoogleFonts.sahitya( color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: GoogleFonts.sahitya( color: Color(0xFF9A2143),
            fontSize: 15,
            fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class _FollowButton extends StatelessWidget {
  const _FollowButton({required this.onPressed, required this.labelColor});
  final VoidCallback onPressed;
  final Color labelColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        backgroundColor: AppColors.buttoncolor,
        foregroundColor: labelColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      ),
      child: const Text(
        'Follow',
        style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
      ),
    );
  }
}

/// Creates the wavy bottom edge seen in the screenshot.
class _WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final p = Path()
      ..lineTo(0, size.height - 60);

    // smooth wave (two quadratic beziers)
    p.quadraticBezierTo(
      size.width * 0.25, size.height - 0, // control, end y up
      size.width * 0.5, size.height - 20,
    );
    p.quadraticBezierTo(
      size.width * 0.75, size.height - 40,
      size.width, size.height - 10,
    );

    p
      ..lineTo(size.width, 0)
      ..close();
    return p;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
