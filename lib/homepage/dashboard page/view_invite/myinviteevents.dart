// ignore_for_file: avoid_print

import 'dart:async';
import 'package:common_user/homepage/dashboard%20page/view_invite/invitehistorypage.dart';
import 'package:flutter/material.dart';
import 'package:common_user/app_colors.dart';
import 'package:common_user/homepage/dashboard%20page/view_invite/manualadd.dart';

class MyInviteEvents extends StatefulWidget {
  final List<Map<dynamic, dynamic>> completelistinvite;
  final Function(Map<dynamic, dynamic>)? onEventAdded; // Add callback parameter

  const MyInviteEvents({
    super.key,
    required this.completelistinvite,
    this.onEventAdded,
  });

  @override
  State<MyInviteEvents> createState() => _MyInviteEventsState();
}

class _MyInviteEventsState extends State<MyInviteEvents> {
  final target = DateTime(2025, 10, 10, 18, 00);
  late List<Map<dynamic, dynamic>> _invites;

  @override
  void initState() {
    super.initState();
    _invites = List<Map<dynamic, dynamic>>.from(widget.completelistinvite);
  }

  @override
  void didUpdateWidget(MyInviteEvents oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.completelistinvite != widget.completelistinvite) {
      setState(() {
        _invites = List<Map<dynamic, dynamic>>.from(widget.completelistinvite);
      });
    }
  }

  String niceLeft(Duration d) {
    if (d.isNegative) return 'Expired';
    final days = d.inDays;
    final hh = (d.inHours % 24).toString().padLeft(2, '0');
    final mm = (d.inMinutes % 60).toString().padLeft(2, '0');
    final ss = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '${days > 0 ? '${days}d ' : ''}$hh:$mm:$ss';
  }

  void _openManualSheet() {
    manualinvitesheet(
      context,
      onEventAdded: (Map<dynamic, dynamic> newEvent) {
        setState(() {
          _invites.add(newEvent);
        });
        // Also call the parent callback if provided
        if (widget.onEventAdded != null) {
          widget.onEventAdded!(newEvent);
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('Event "${newEvent['eventname']}" added successfully!'),
            backgroundColor: AppColors.primary,
            duration: Duration(seconds: 2),
          ),
        );
      },
    );
  }

  // Debug helper method to check what values are actually stored
  String _getDisplayText(Map<dynamic, dynamic> completed) {
    print("=== Debug Event Data ===");
    print("Full event data: $completed");
    print("invitefrom: '${completed["invitefrom"]}'");
    print("inviteFrom: '${completed["inviteFrom"]}'");
    print("relationship: '${completed["relationship"]}'");
    print("========================");

    // 1st Priority: inviteFrom values
    if (completed["invitefrom"] != null &&
        completed["invitefrom"].toString().trim().isNotEmpty) {
      print("Showing invitefrom: ${completed["invitefrom"]}");
      return "Invited By: ${completed["invitefrom"]}";
    }
    if (completed["inviteFrom"] != null &&
        completed["inviteFrom"].toString().trim().isNotEmpty) {
      print("Showing inviteFrom: ${completed["inviteFrom"]}");
      return "Invited By: ${completed["inviteFrom"]}";
    }

    // 2nd Priority: relationship value
    if (completed["relationship"] != null &&
        completed["relationship"].toString().trim().isNotEmpty) {
      print("Showing relationship: ${completed["relationship"]}");
      return "Relationship: ${completed["relationship"]}";
    }

    // 3rd Priority: fallback
    print("Showing fallback: Manual Entry");
    return "Manual Entry";
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_invites.isEmpty)
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.hourglass_empty_rounded,
                    size: 40.0,
                    color: AppColors.primary,
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "Currently there are no events available",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),

          // Events List
          if (_invites.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Upcoming Events",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "The below events are upcoming events hosted by your contact list or manually accepted by you to participate in the event",
                  style: TextStyle(fontSize: 12.0, color: Colors.black54),
                ),
                SizedBox(height: 10.0),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _invites.length,
                  itemBuilder: (context, index) {
                    final completed = _invites[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: 12),
                      child: Card(
                        elevation: 4.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 14.0, vertical: 10.0),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: AppColors.paper,
                                    boxShadow: [
                                      BoxShadow(
                                        spreadRadius: 1,
                                        blurRadius: 1,
                                        color: Colors.black26,
                                      )
                                    ],
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10.0),
                                      topLeft: Radius.circular(10.0),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        child: Text(
                                          completed["eventname"]?.toString() ??
                                              'Untitled Event',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            "Time Remaining :",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black54,
                                            ),
                                          ),
                                          SizedBox(width: 6.0),
                                          StreamBuilder<Duration>(
                                            stream: Stream.periodic(
                                              const Duration(seconds: 1),
                                              (_) => target
                                                  .difference(DateTime.now()),
                                            ),
                                            builder: (context, snapshot) {
                                              final d = snapshot.data ??
                                                  target.difference(
                                                      DateTime.now());
                                              return Text(
                                                niceLeft(d),
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                  color: d.isNegative
                                                      ? Colors.red
                                                      : Colors.green,
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 6),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // Priority-based display logic
                                          Flexible(
                                            flex: 3,
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20.0,
                                                  vertical: 4.0),
                                              decoration: BoxDecoration(
                                                color: AppColors.primary,
                                                borderRadius: BorderRadius.only(
                                                  topRight:
                                                      Radius.circular(10.0),
                                                  bottomRight:
                                                      Radius.circular(10.0),
                                                ),
                                              ),
                                              child: Text(
                                                _getDisplayText(completed),
                                                style: TextStyle(
                                                  fontSize: 13.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 8.0),
                                          // Show city if available
                                          if (completed["city"] != null &&
                                              completed["city"]
                                                  .toString()
                                                  .isNotEmpty)
                                            Flexible(
                                              flex: 2,
                                              child: Text(
                                                completed["city"].toString(),
                                                style: TextStyle(
                                                  fontSize: 13.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black54,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 2.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10.0)),
                                      color: AppColors.lightGold,
                                    ),
                                    child: Text(
                                      "Starts at ${completed["startdate"]?.toString() ?? 'TBD'}",
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Container(
                              height: 1.0,
                              width: double.infinity,
                              color: Colors.black12,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 14.0, vertical: 6.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    color: Colors.black26,
                                  )
                                ],
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10.0),
                                  bottomRight: Radius.circular(10.0),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "See Event Details",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12.0, vertical: 4.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4.0),
                                      color: AppColors.primary,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.remove_red_eye_rounded,
                                          color: Colors.white,
                                          size: 14.0,
                                        ),
                                        SizedBox(width: 4.0),
                                        Text(
                                          "View",
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
        ],
      ),
    );
  }
}
