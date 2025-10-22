import 'package:common_user/app_colors.dart';
import 'package:common_user/features/profile/pages/edit_profile_page.dart';
import 'package:common_user/features/profile/widgets/user_provider.dart';
import 'package:common_user/features/vendor/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.paper,
      appBar: AppBar(
        backgroundColor: AppColors.paper,
        surfaceTintColor: AppColors.paper,
        centerTitle: true,
        title: Text(
          "My Profile",
          style: GoogleFonts.poppins(fontSize: 19, fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            profile(provider.name, provider.email),
            const SizedBox(
              height: 20,
            ),
            details(
              Icons.card_giftcard_sharp,
              Colors.deepOrangeAccent,
              "Created Event",
              "1",
            ),
            const SizedBox(
              height: 5,
            ),
            details(
              Icons.pending_actions,
              Colors.lightBlue,
              "Pending Invitations",
              "5",
            ),
            const SizedBox(
              height: 5,
            ),
            details(
              Icons.check,
              Colors.green,
              "Complete Invitations",
              "15",
            ),
            const SizedBox(
              height: 5,
            ),
            details(
              Icons.all_inbox,
              Colors.purple,
              "Total Invitations",
              "20",
            ),
            const SizedBox(
              height: 5,
            ),
            details(
              Icons.contact_emergency,
              Colors.green,
              "No of Contacts",
              "200",
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Purchased Gifts",
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }

  Widget gift() {
    return Container();
  }

  Widget line() {
    return Container(
      height: 50,
      width: 1,
      color: AppColors.black.withOpacity(0.2),
    );
  }

  Widget details(IconData icon, Color iconcolor, String name, String count) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: iconcolor,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              name,
              style: GoogleFonts.poppins(
                  fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const Spacer(),
            Text(
              count,
              style: GoogleFonts.poppins(
                  fontSize: 17, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              width: 20,
            )
          ],
        ),
      ),
    );
  }

  Widget detailss() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Text(
              "0",
              style: GoogleFonts.poppins(
                  fontSize: 20, fontWeight: FontWeight.w500),
            ),
            Text(
              "Create Events",
              style: GoogleFonts.poppins(fontSize: 12),
            )
          ],
        ),
        line(),
        Column(
          children: [
            Text(
              "1",
              style: GoogleFonts.poppins(
                  fontSize: 20, fontWeight: FontWeight.w500),
            ),
            Text(
              "Pending Invitations",
              style: GoogleFonts.poppins(fontSize: 12),
            )
          ],
        ),
        line(),
        Column(
          children: [
            Text(
              "0",
              style: GoogleFonts.poppins(
                  fontSize: 20, fontWeight: FontWeight.w500),
            ),
            Text(
              "Total Invitations",
              style: GoogleFonts.poppins(fontSize: 12),
            )
          ],
        )
      ],
    );
  }

  Widget profile(String name, String email) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CircleAvatar(
          radius: 60,
          backgroundImage: AssetImage("assets/images/jega.png"),
        ),
        const SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            Text(
              " $name",
              style: GoogleFonts.poppins(
                  fontSize: 17, fontWeight: FontWeight.w500, letterSpacing: 2),
            ),
            Text(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              "  $email",
              style: GoogleFonts.poppins(
                  fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 2),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                navigateWithSlide(context, EditProfilePage());
              },
              child: Card(
                color: AppColors.primary,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 8,
                  ),
                  child: Text(
                    "Edit Profile",
                    style: GoogleFonts.poppins(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: AppColors.white),
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
