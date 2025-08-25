import 'package:common_user/common/colors.dart';
import 'package:common_user/homepage/New%20Event/main%20screen/singleeventpage.dart/circleinvite.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class majorcont extends StatefulWidget {
  const majorcont({super.key});

  @override
  State<majorcont> createState() => _majorcontState();
}

class _majorcontState extends State<majorcont> {
  @override
  Widget build(BuildContext context) {
    return Container(
       width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [const Color(0xFFFFFBF2), AppColors.boxboxlight],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(color: AppColors.boxlightcolor.withOpacity(0.6)),
      ),
      child:Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
              "Friends & Family",
              style: GoogleFonts.inter(
                color:  AppColors.buttoncolor,
                fontSize: 19,
                fontWeight: FontWeight.w700,
              ),
            ),
            ],
          ),
          SizedBox(height: 10.0,),
          Row(
            children: [
              AmountDial(),
              SizedBox(width: 10.0,),
              about(),
            ],
          ),
          SizedBox(height: 10.0,),
                 Container(
          height: 1,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.transparent, AppColors.boxlightcolor, Colors.transparent],
            ),
          ),
        ),
        SizedBox(height: 12.0,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
                _primaryBtn(
              label: 'Invite People',
              icon: Icons.person_add_alt_1_rounded,
              onTap: () {},
            ),
            _ghostBtn(
              label: 'Collaboration',
              icon: Icons.handshake_rounded,
              onTap: () {},
            ),
          ],
        )
        ],
      ) 
    );
  }
  Widget about(){
    // ignore: sized_box_for_whitespace
    return Container(
      height: MediaQuery.of(context).size.height * 0.225,
      width:  MediaQuery.of(context).size.width * 0.450,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.0,),
          Text(
                'Event Invite Collaboration',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.black87),
                overflow: TextOverflow.ellipsis,
              ),
         const SizedBox(height: 6),
         const Text(
          maxLines: 4,
           'Invite your guests, collaborate with co-hosts, and enjoy a seamless event experience.',
           style: TextStyle(fontSize: 14, color: Colors.black54, height: 1.35),
           softWrap: true,
        ),
         const SizedBox(height: 12),
                        SizedBox(width:4.0,),
               Row(
                children: [
                  Icon(Icons.people,size: 22.0,color: AppColors.buttoncolor,),SizedBox(width: 4.0,),
                   Text("Co-Hosts = 0",style: TextStyle(fontSize: 16.0,color: Colors.black54,fontWeight: FontWeight.w700),),
                ],
               ),
        ],
      ),
    );
  }
   Widget _primaryBtn({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 160),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.buttoncolor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          elevation: 6,
          shadowColor: AppColors.buttoncolor.withOpacity(0.35),
        ),
        onPressed: onTap,
        icon: Icon(icon, size: 20),
        label: Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
      ),
    );
  }

  Widget _ghostBtn({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 160),
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: AppColors.buttoncolor.withOpacity(0.45), width: 1.5),
          foregroundColor: AppColors.buttoncolor,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        onPressed: onTap,
        icon: Icon(icon, size: 20),
        label: Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
      ),
    );
  }
}