import 'package:book_flip/book_flip.dart';
import 'package:common_user/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InvitationFlipBookPage extends StatefulWidget {
  @override
  State<InvitationFlipBookPage> createState() => _InvitationFlipBookPageState();
}

class _InvitationFlipBookPageState extends State<InvitationFlipBookPage> {
  final List<String> invitationImages = [
    'assets/images/invite1.jpg',
    'assets/images/invite2.jpg',
    'assets/images/invite3.jpg',
    'assets/images/invite4.jpg',
    'assets/images/invite5.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.paper,
      appBar: AppBar(
        title: Text("Invitation Flipbook",
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        backgroundColor: AppColors.primary,
      ),
      body: Column(
        children: [
          SizedBox(
              child: BookFlipWidget(content: [
            Image.asset(
              "assets/images/inviter.jpg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "assets/images/inviter2.jpg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "assets/images/inviter3.jpg",
              fit: BoxFit.cover,
            )
          ])),
        ],
      ),
    );
  }
}
