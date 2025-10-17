// SINGLE WIDGET + LAUNCHER (no external form widgets needed)
import 'dart:io';
import 'package:common_user/homepage/dashboard%20page/invites_visit/model/model.dart';
import 'package:common_user/homepage/dashboard%20page/invites_visit/widgets/riverpod.dart';
import 'package:common_user/homepage/dashboard%20page/invites_visit/widgets/textfieldcont.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:intl/intl.dart';

Future<void> showManualEventBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isDismissible: true,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const _ManualEventSheet(),
  );
}

class _ManualEventSheet extends ConsumerStatefulWidget {
  const _ManualEventSheet();

  @override
  ConsumerState<_ManualEventSheet> createState() => _ManualEventSheetState();
}

class _ManualEventSheetState extends ConsumerState<_ManualEventSheet> {
  final _eventName = TextEditingController();
  final _inviteFrom = TextEditingController();
  final _address = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTime? startdate;
  String? dateinstring;

  final _picker = ImagePicker();
  final List<XFile> _images = [];
  static const int _maxImages = 10;

  Future<void> _pickImages() async {
    final picked = await _picker.pickMultiImage(requestFullMetadata: true);
    if (picked.isEmpty) return;

    // merge by path, cap to 10
    final existing = {for (final x in _images) x.path: x};
    for (final x in picked) {
      existing[x.path] = x;
      if (existing.length >= _maxImages) break;
    }
    setState(() {
      _images
        ..clear()
        ..addAll(existing.values.take(_maxImages));
    });
  }

  void _removeAt(int i) => setState(() => _images.removeAt(i));

  @override
  void dispose() {
    _eventName.dispose();
    _inviteFrom.dispose();
    _address.dispose();
    super.dispose();
    // NOTE: If you want to return data, use: Navigator.pop(context, payload);
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return AnimatedPadding(
      duration: const Duration(milliseconds: 200),
      padding: EdgeInsets.only(bottom: bottom),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Container(
              height: 4,
              width: 48,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 12),

            // Scrollable content
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Row(
                        children: const [
                          Text(
                            "Manual Add Event",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF9A2143),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        "Create a new event invite manually by entering essential details like event name, date, and organizer. Use this option to record events.",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 12),
                      textfieldd(
                          controller: _eventName,
                          hint: "Event Name",
                          length: 20,
                          prefixicon: Icons.event),
                      textfieldd(
                          controller: _inviteFrom,
                          hint: "Invitefrom",
                          length: 20,
                          prefixicon: Icons.person),
                      textfieldd(
                          controller: _address,
                          hint: "Event Address",
                          length: 50,
                          prefixicon: Icons.location_city),

                      const SizedBox(height: 8),
                      textcontainer(
                          onTap: () {
                            choosedate();
                          },
                          prefficon: Icons.date_range,
                          hint: "Start Date",
                          dateee: dateinstring),
                      const SizedBox(height: 12),
                      DottedBorder(
                        color: const Color(0xFF9A2143),
                        strokeWidth: 1,
                        dashPattern: const [8, 4],
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(10),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: _pickImages,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.2,
                            width: double.infinity,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: _images.isNotEmpty
                                ? SingleChildScrollView(
                                    child: Wrap(
                                      spacing: 10,
                                      runSpacing: 10,
                                      children: [
                                        for (int i = 0; i < _images.length; i++)
                                          Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: Image.file(
                                                  File(_images[i].path),
                                                  width: 64,
                                                  height: 64,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Positioned(
                                                top: -6,
                                                right: -6,
                                                child: InkWell(
                                                  onTap: () => _removeAt(i),
                                                  child: Container(
                                                    width: 22,
                                                    height: 22,
                                                    decoration: BoxDecoration(
                                                      color: Colors.black
                                                          .withOpacity(0.8),
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: const Icon(
                                                      Icons.close,
                                                      size: 14,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        if (_images.length < _maxImages)
                                          InkWell(
                                            onTap: _pickImages,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Container(
                                              width: 64,
                                              height: 64,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                    color: Colors.black26),
                                              ),
                                              child: const Icon(Icons.add),
                                            ),
                                          ),
                                      ],
                                    ),
                                  )
                                : Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: const [
                                        Icon(Icons.upload,
                                            color: Color(0xFF9A2143), size: 30),
                                        SizedBox(height: 8),
                                        Text(
                                          'Upload Invitation Images (tap here)\nMax 10 images',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Submit
                      SizedBox(
                        width: double.infinity,
                        child: // ... inside _ManualEventSheetState build → Submit button:
                            ElevatedButton(
                          onPressed: () {
                            // quick validation
                            if (_eventName.text.trim().isEmpty ||
                                _inviteFrom.text.trim().isEmpty ||
                                _address.text.trim().isEmpty ||
                                (dateinstring == null ||
                                    dateinstring!.isEmpty)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Please fill all required fields')),
                              );
                              return;
                            }

                            // Build InviteModel (endDate same as startDate; adjust if you add end-date UI)
                            final String imagePath = _images.isNotEmpty
                                ? _images.first.path // file path string
                                : 'assets/images/inviter6.jpg';
                            final invite = InviteModel(
                              eventName: _eventName.text.trim(),
                              eventType: _address.text,
                              startDate: dateinstring!, // "yyyy-MM-dd"
                              endDate:
                                  dateinstring!, // or '' if you don't want same-day
                              image: imagePath,
                              inviteFrom: _inviteFrom.text.trim(),
                              address: "Manual",
                              multiImages: List<XFile>.from(_images),
                            );

                            // Append to completed invites (IMPORTANT: return the new list)
                            ref
                                .read(invitecompletes.notifier)
                                .update((current) {
                              final List<InviteModel> next =
                                  List<InviteModel>.from(current);
                              next.add(invite);
                              return next;
                            });

                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF9A2143),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: const Text(
                            "Submit",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> choosedate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024, 1, 1),
      lastDate: DateTime(2030, 12, 31),
    );
    if (picked == null) return;

    final storage = DateFormat("yyyy-MM-dd").format(picked); // ✅ parse-safe
    setState(() {
      startdate = picked;
      dateinstring = storage; // InviteModel.startDate uses this
    });
  }

  // Future<void> choosedate() async {
  //   final picked = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime.utc(2024, 1, 1, 0, 0, 0),
  //     lastDate: DateTime.utc(
  //       2030,
  //       1,
  //       1,
  //       1,
  //     ),
  //   );
  //   if (picked == null) return;
  //   final String pickformat = DateFormat("dd-mm-yyyy").format(picked);
  //   setState(() {
  //     dateinstring = pickformat;
  //     startdate = picked;
  //   });
  // }
}
