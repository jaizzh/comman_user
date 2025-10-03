import 'package:common_user/app_colors.dart';
import 'package:flutter/material.dart';

class ViewInvitePage extends StatefulWidget {
  const ViewInvitePage({super.key});

  @override
  State<ViewInvitePage> createState() => _ViewInvitePageState();
}

class _ViewInvitePageState extends State<ViewInvitePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.paper,
      appBar: AppBar(
        backgroundColor: AppColors.paper,
        surfaceTintColor: AppColors.paper,
      ),
    );
  }
}
