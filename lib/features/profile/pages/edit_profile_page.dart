import 'package:common_user/app_colors.dart';
import 'package:common_user/features/profile/widgets/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _noController;
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<UserProvider>(context, listen: false);
    _nameController = TextEditingController(text: provider.name);
    _emailController = TextEditingController(text: provider.email);
    _noController = TextEditingController(text: provider.no);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _noController.dispose();
    super.dispose();
  }

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
          "Edit Profile",
          style: GoogleFonts.poppins(fontSize: 19, fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage("assets/images/jega.png"),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            textfiled("Name", Icons.person, _nameController),
            const SizedBox(
              height: 12,
            ),
            textfiled("Email", Icons.email, _emailController),
            const SizedBox(
              height: 12,
            ),
            textfiled("Mobile No", Icons.phone, _noController),
            const SizedBox(
              height: 32,
            ),
            GestureDetector(
                onTap: () {
                  provider.updateName(_nameController.text,
                      _emailController.text, _noController.text);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Name updated!")),
                  );
                },
                child: editButton())
          ],
        ),
      ),
    );
  }

  Widget textfiled(
      String labeltext, IconData icon, TextEditingController controller) {
    return Card(
      elevation: 5,
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: AppColors.white),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
                border: InputBorder.none,
                labelText: labeltext,
                prefixIcon: Icon(icon)),
          )),
    );
  }

  Widget editButton() {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(15),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.primary,
        ),
        child: Center(
          child: Text(
            "Save",
            style: GoogleFonts.poppins(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: AppColors.white),
          ),
        ),
      ),
    );
  }
}
