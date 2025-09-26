import 'dart:async';
import 'package:common_user/features/vendor/widgets/navigation.dart';
import 'package:common_user/features/view_invites/pages/view_invite_page.dart';
import 'package:flutter/material.dart';
import 'package:common_user/app_colors.dart';

class MyInviteEvents extends StatefulWidget {
  final List<Map<dynamic, dynamic>> completelistinvite;
  MyInviteEvents({super.key, required this.completelistinvite});

  @override
  State<MyInviteEvents> createState() => _MyInviteEventsState();
}

class _MyInviteEventsState extends State<MyInviteEvents> {
  final target = DateTime(2025, 10, 10, 18, 00);

  // Nice formatter like "12d 03:14:55"
  String niceLeft(Duration d) {
    if (d.isNegative) return 'Expired';
    final days = d.inDays;
    final hh = (d.inHours % 24).toString().padLeft(2, '0');
    final mm = (d.inMinutes % 60).toString().padLeft(2, '0');
    final ss = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '${days > 0 ? '${days}d ' : ''}$hh:$mm:$ss';
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.completelistinvite.length == 0)
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.hourglass_empty_rounded,
                    size: 40.0,
                    color: AppColors.primary,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Currently there is no events available",
                    style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54),
                  )
                ],
              ),
            ),
          if (widget.completelistinvite.length != 0)
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Upcoming Events",
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Text(
                    "The below events are upcoming events host by your contact list or manaually accepted by you to participated in the event",
                    style: TextStyle(fontSize: 12.0, color: Colors.black54),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  ListView.builder(
                    shrinkWrap: true, // ✅ important
                    physics:
                        const NeverScrollableScrollPhysics(), // ✅ important
                    itemCount: widget.completelistinvite.length,
                    itemBuilder: (context, index) {
                      final completed = widget.completelistinvite[index];
                      return Container(
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
                                            topLeft: Radius.circular(10.0))),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          child: Text(
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              completed["eventname"],
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w800,
                                              )),
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
                                            SizedBox(
                                              width: 6.0,
                                            ),
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
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20.0,
                                                  vertical: 4.0),
                                              decoration: BoxDecoration(
                                                  color: AppColors.primary,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  10.0),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  10.0))),
                                              child: Text(
                                                "Invited By",
                                                style: TextStyle(
                                                    fontSize: 13.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                            ),
                                            Text(
                                              "Jega Bro Office",
                                              style: TextStyle(
                                                  fontSize: 13.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black54),
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
                                                topRight:
                                                    Radius.circular(10.0)),
                                            color: AppColors.lightGold),
                                        child: Text(
                                          "Starts at  ${completed["startdate"]}",
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      ))
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
                                        bottomRight: Radius.circular(10.0))),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "See Event Details",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        navigateWithSlide(
                                            context, const ViewInvitePage());
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12.0, vertical: 4.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                          color: AppColors.primary,
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.remove_red_eye_rounded,
                                              color: Colors.white,
                                              size: 14.0,
                                            ),
                                            SizedBox(
                                              width: 4.0,
                                            ),
                                            Text(
                                              "View",
                                              style: TextStyle(
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
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
            )
        ],
      ),
    );
  }
}
