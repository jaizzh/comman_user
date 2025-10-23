// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:common_user/app_colors.dart';
import 'package:common_user/features/vendor/widgets/navigation.dart';
import 'package:common_user/features/view_invites/pages/view_invite_page.dart';
import 'package:common_user/homepage/dashboard%20page/invites_visit/model/model.dart';
import 'package:common_user/homepage/dashboard%20page/invites_visit/screens/fullimagescreen.dart';
import 'package:common_user/homepage/dashboard%20page/invites_visit/screens/manualevent.dart';
import 'package:common_user/homepage/dashboard%20page/invites_visit/screens/ourimage.dart';
import 'package:common_user/homepage/dashboard%20page/invites_visit/widgets/bottomscreen.dart';
import 'package:common_user/homepage/dashboard%20page/invites_visit/widgets/riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class calendermain extends ConsumerStatefulWidget {
  final DateTime? startdatedp;
  final DateTime? enddatedp;
  final int? comporincompint;
  final int? inviteormanual;
  const calendermain({
    super.key,
    required this.startdatedp,
    required this.enddatedp,
    required this.comporincompint,
    required this.inviteormanual,
  });
  @override
  ConsumerState<calendermain> createState() => _calendermainState();
}

class _calendermainState extends ConsumerState<calendermain> {
  DateTime? startdateor;
  DateTime? enddateor;
  int? selectedcategory;
  int? inviteee;
  void initState() {
    super.initState();
    startdateor = widget.startdatedp;
    enddateor = widget.enddatedp;
    selectedcategory = widget.comporincompint;
    inviteee = widget.inviteormanual;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 14.0),
            child: GestureDetector(
              onTap: () {
                showManualEventBottomSheet(context);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 6.0),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Row(
                  children: [
                    Text(
                      "+ Add event",
                      style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              inviteconttext(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: invitecontactgrid(),
              ),
              const SizedBox(height: 10.0),
              invitecompletetext(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: invitecompleted(),
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget inviteconttext() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Invited Events (${ref.watch(inviteecontact.notifier).state.length})",
            style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          Text(
            "An event invitation is a formal or casual request to attend a special occasion or gathering. It provides essential details such as the event name, date, time, and location",
            style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: Colors.black45),
          ),
        ],
      ),
    );
  }

  Widget invitecompletetext() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Upcoming Events (${ref.watch(invitecompletes.notifier).state.length})",
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              GestureDetector(
                onTap: () {
                  showFilterBottomSheet(context);
                },
                child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 1,
                            blurRadius: 1,
                            color: Colors.black12,
                          )
                        ],
                        borderRadius: BorderRadius.circular(6.0)),
                    child: Row(
                      children: [
                        Icon(
                          size: 20.0,
                          Icons.shopping_cart_checkout_rounded,
                        ),
                        SizedBox(
                          width: 6.0,
                        ),
                        Text(
                          "Sort & Filter",
                          style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                      ],
                    )),
              ),
            ],
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            "An event invitation is a formal or casual request to attend a special occasion or gathering. It provides essential details such as the event name, date, time, and location",
            style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: Colors.black45),
          ),
        ],
      ),
    );
  }

  Widget invitecontactgrid() {
    final contacts = ref.watch(inviteecontact);
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 12.0,
          childAspectRatio: 7 / 10),
      itemCount: contacts.length,
      itemBuilder: (context, index) {
        final invitecon = contacts[index];
        return Card(
          elevation: 4.0,
          child: Container(
            padding: EdgeInsets.all(6.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 1,
                    blurRadius: 1,
                    color: Colors.black12,
                  )
                ]),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.125,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(invitecon.image),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          invitecon.eventName,
                          style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Row(
                          children: [
                            Text(
                              "invite by -",
                              style: TextStyle(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black45),
                            ),
                            SizedBox(
                              width: 6.0,
                            ),
                            Text(
                              invitecon.inviteFrom,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 11.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.0350,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                      ),
                      onPressed: () {
                        // READ callbacks to mutate state
                        ref.read(inviteecontact.notifier).update((list) {
                          final newList = List<InviteModel>.from(list);
                          final removedInvite = newList.removeAt(index);
                          // move to completed
                          ref
                              .read(invitecompletes.notifier)
                              .update((c) => [...c, removedInvite]);
                          return newList;
                        });
                      },
                      child: const Text(
                        "Accept",
                        style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.0350,
                    child: ElevatedButton(
                      onPressed: () {
                        ref.read(inviteecontact.notifier).update((list) {
                          final newList = List<InviteModel>.from(list)
                            ..removeAt(index);
                          return newList;
                        });
                      },
                      child: const Text(
                        "Decline",
                        style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget invitecompleted() {
    final completed = ref.watch(invitecompletes);

    final now = DateTime.now();
    DateTime strip(DateTime d) => DateTime(d.year, d.month, d.day);
    final today = strip(now);

    final filtered = completed.where((e) {
      final parsed = DateTime.tryParse(e.startDate); // expects "yyyy-MM-dd"
      if (parsed == null) return false;

      final d = strip(parsed);

      // Date range (inclusive)
      if (startdateor != null && d.isBefore(strip(startdateor!))) return false;
      if (enddateor != null && d.isAfter(strip(enddateor!))) return false;

      // Category: 0/null=All, 1=Completed(past), 2=Incompleted(today & future)
      if (selectedcategory == 1 && !d.isBefore(today)) return false;
      if (selectedcategory == 2 && d.isBefore(today)) return false;

      // Manual/Invited: 0/null=All, 1=Manual only, 2=Invited only
      final addr = (e.address).trim().toLowerCase();
      final isManual = addr == 'manual';
      if (inviteee == 1 && isManual) return false; // keep only Manual
      if (inviteee == 2 && !isManual) return false; // keep only Invited

      return true;
    }).toList();

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 16.0,
        crossAxisSpacing: 16.0,
        crossAxisCount: 2,
        childAspectRatio: 7 / 10,
      ),
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final invitecon = filtered[index];

        return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Container(
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- Image section ---
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: GestureDetector(
                        onTap: () => openImageBookMixed(
                          context,
                          invitecon.multiImages.isNotEmpty
                              ? invitecon.multiImages
                              : <Object>[invitecon.image],
                          start: 0,
                        ),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height *
                              0.125, // or AspectRatio(16/9)
                          width: double.infinity,
                          child: Image(
                            image: resolveImage(invitecon.image), // <-- THIS
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 10,
                      top: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.85),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          invitecon.startDate,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // --- Text details ---
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 6.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Event Name
                      Text(
                        invitecon.eventName,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: 2),

                      // Invite From (protected with Expanded)
                      Row(
                        children: [
                          const Text(
                            "invite by -",
                            style: TextStyle(
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black45,
                            ),
                          ),
                          const SizedBox(width: 6.0),
                          Expanded(
                            child: Text(
                              invitecon.inviteFrom,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 4),

                      // Event Type
                      if (invitecon.address == "Manual")
                        Row(
                          children: [
                            Icon(
                              Icons.location_city,
                              color: Colors.black,
                              size: 20.0,
                            ),
                            SizedBox(
                              width: 6.0,
                            ),
                            SizedBox(
                              width: 100,
                              child: Text(
                                invitecon.eventType,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      if (invitecon.address != "Manual")
                        Text(
                          invitecon.eventType,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ),

                const SizedBox(height: 6.0),
                if (invitecon.address == "Manual")
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 0.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 6.0),
                        child: Text(
                          "Manual",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),

                if (invitecon.address != "Manual")
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 0.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 6.0),
                        child: Text(
                          "VIEW",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  ImageProvider resolveImage(String path) {
    return path.startsWith('assets/')
        ? AssetImage(path)
        : FileImage(File(path));
  }
}
