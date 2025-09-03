import 'package:common_user/common/colors.dart';
import 'package:common_user/homepage/New%20Event/main%20screen/singleeventpage.dart/circleinvite.dart';
import 'package:flutter/material.dart';

class majorcont extends StatefulWidget {
  const majorcont({super.key});

  @override
  State<majorcont> createState() => _majorcontState();
}

class _majorcontState extends State<majorcont> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [const Color(0xFFFFFBF2), AppColors.boxboxlight],
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
            border: Border.all(
                color: AppColors.boxlightcolor.withOpacity(0.6), width: 2.0),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  AmountDial(),
                  SizedBox(
                    width: 6.0,
                  ),
                  about(),
                ],
              ),
              Row(
                children: [
                  Row(
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: Text(
                            "No Of Gusets Invited",
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          )),
                      SizedBox(
                        width: 10.0,
                      ),
                      _primaryBtn(
                        label: 'Invite People',
                        icon: Icons.person_add_alt_1_rounded,
                        onTap: () {},
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      _ghostBtn(
                        label: "Co-Hosts",
                        icon: Icons.handshake_rounded,
                        onTap: () {},
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 8.0,
              )
            ],
          )),
    );
  }

  Widget about() {
    // ignore: sized_box_for_whitespace
    return Container(
      height: MediaQuery.of(context).size.height * 0.16,
      width: MediaQuery.of(context).size.width * 0.555,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10.0,
          ),
          Text(
            'Event Invite Collaboration',
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w900,
                color: Colors.black87),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          const Text(
            maxLines: 3,
            'Invite your guests, collaborate with co-hosts, and enjoy a seamless \n event experience.',
            style: TextStyle(fontSize: 12, color: Colors.black54, height: 1.5),
            softWrap: true,
          ),
          const SizedBox(height: 2),
          SizedBox(
            width: 4.0,
          ),
          Row(
            children: [
              Icon(
                Icons.people,
                size: 16.0,
                color: AppColors.buttoncolor,
              ),
              SizedBox(
                width: 4.0,
              ),
              Text(
                "Co-Hosts = 0",
                style: TextStyle(
                    fontSize: 13.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w700),
              ),
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
    return Container(
      height: 30,
      width: MediaQuery.of(context).size.width * 0.280,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.buttoncolor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 6,
          shadowColor: AppColors.buttoncolor.withOpacity(0.35),
        ),
        onPressed: onTap,
        icon: Icon(icon, size: 16),
        label: Text(label,
            style:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 11.0)),
      ),
    );
  }

  Widget _ghostBtn({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      height: 30,
      width: MediaQuery.of(context).size.width * 0.280,
      child: OutlinedButton.icon(
        iconAlignment: IconAlignment.start,
        style: OutlinedButton.styleFrom(
          side: BorderSide(
              color: AppColors.buttoncolor.withOpacity(0.45), width: 1.5),
          foregroundColor: AppColors.buttoncolor,
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: onTap,
        icon: Icon(icon, size: 16),
        label: Text(label,
            style:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 11.0)),
      ),
    );
  }
}
