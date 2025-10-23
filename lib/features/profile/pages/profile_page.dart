import 'package:common_user/app_colors.dart';
import 'package:common_user/features/profile/pages/edit_profile_page.dart';
import 'package:common_user/features/profile/widgets/user_provider.dart';
import 'package:common_user/features/vendor/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context);
    final width = MediaQuery.of(context).size.width;
    final avatarSize = width * 0.23 > 80 ? 80.0 : width * 0.23;

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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileHeader(
                name: provider.name,
                email: provider.email,
                avatarSize: avatarSize,
              ),
              const SizedBox(height: 20),
              ProfileStat(
                icon: Icons.card_giftcard_sharp,
                iconColor: Colors.deepOrangeAccent,
                label: "Created Event",
                count: "1",
              ),
              const SizedBox(height: 5),
              ProfileStat(
                icon: Icons.pending_actions,
                iconColor: Colors.lightBlue,
                label: "Pending Invitations",
                count: "5",
              ),
              const SizedBox(height: 5),
              ProfileStat(
                icon: Icons.check,
                iconColor: Colors.green,
                label: "Complete Invitations",
                count: "15",
              ),
              const SizedBox(height: 5),
              ProfileStat(
                icon: Icons.all_inbox,
                iconColor: Colors.purple,
                label: "Total Invitations",
                count: "20",
              ),
              const SizedBox(height: 5),
              ProfileStat(
                icon: Icons.contact_emergency,
                iconColor: Colors.green,
                label: "No of Contacts",
                count: "200",
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  final String name;
  final String email;
  final double avatarSize;

  const ProfileHeader({
    Key? key,
    required this.name,
    required this.email,
    required this.avatarSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: avatarSize,
          backgroundImage: const AssetImage("assets/images/jega.png"),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              Text(
                name,
                style: GoogleFonts.poppins(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 2,
                ),
              ),
              Text(
                email,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () => navigateWithSlide(context, EditProfilePage()),
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
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ProfileStat extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String count;

  const ProfileStat({
    Key? key,
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        child: Row(
          children: [
            Icon(icon, color: iconColor),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Text(
              count,
              style: GoogleFonts.poppins(
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
