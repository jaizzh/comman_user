// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:common_user/app_colors.dart';
import 'package:common_user/homepage/dashboard%20page/invites_visit/screens/calenderspage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// OPTIONAL: If you have AppColors in your project, keep it.
// Otherwise uncomment the fallback below.
// class AppColors {
//   static const primary = Colors.teal;
// }

Future<Map<String, dynamic>?> showFilterBottomSheet(BuildContext context) {
  return showModalBottomSheet<Map<String, dynamic>>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    builder: (ctx) => const _FilterSheetWrapper(),
  );
}

/// Wrapper -> rounded top + constrained height (responsive)
class _FilterSheetWrapper extends StatelessWidget {
  const _FilterSheetWrapper();

  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.of(context).size.height * 0.80; // responsive
    return Align(
      alignment: Alignment.bottomCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: maxHeight,
          minWidth: MediaQuery.of(context).size.width,
        ),
        child: const Material(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          child: _FilterSheet(),
        ),
      ),
    );
  }
}

class _FilterSheet extends StatefulWidget {
  const _FilterSheet();

  @override
  State<_FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<_FilterSheet> {
  // Dates
  String? startDateString;
  String? endDateString;
  DateTime? startDate;
  DateTime? endDate;

  // Category (single select with checkbox look)
  final List<String> compOrIncomp = const ["All", "Completed", "Incompleted"];
  int selectedIndexCompleted = 0; // default All

  // Manual / Invited (cards)
  int selectedInviteManual = 0; // 0=All,1=Invited,2=Manual

  // Helpers
  final df = DateFormat('dd-MM-yyyy');

  Color get primary =>
      // replace with AppColors.primary if available
      // AppColors.primary;
      AppColors.primary;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: LayoutBuilder(
        builder: (context, c) {
          return Column(
            children: [
              const SizedBox(height: 10),
              // Grabber
              Container(
                height: 6,
                width: 44,
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 10),

              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Sort & Filter",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.black87),
                      onPressed: () => Navigator.pop(context),
                    )
                  ],
                ),
              ),

              // Body (scrollable)
              Expanded(
                child: SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionTitle("Date Range"),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: _DateField(
                              label: "Start Date",
                              value: startDateString,
                              icon: Icons.date_range,
                              onTap: () async {
                                final picked =
                                    await _chooseDate(initial: startDate);
                                if (picked == null) return;
                                setState(() {
                                  startDate = picked;
                                  startDateString = df.format(picked);
                                  // reset end if invalid
                                  if (endDate != null &&
                                      endDate!.isBefore(startDate!)) {
                                    endDate = null;
                                    endDateString = null;
                                  }
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _DateField(
                              label: "End Date",
                              value: endDateString,
                              icon: Icons.date_range,
                              onTap: () async {
                                final init =
                                    endDate ?? startDate ?? DateTime.now();
                                final picked = await _chooseDate(initial: init);
                                if (picked == null) return;
                                if (startDate != null &&
                                    picked.isBefore(startDate!)) {
                                  _toast(
                                      "End date cannot be before start date");
                                  return;
                                }
                                setState(() {
                                  endDate = picked;
                                  endDateString = df.format(picked);
                                });
                              },
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 18),
                      _sectionTitle("Events Category"),
                      const SizedBox(height: 8),
                      // Using Column (few items) instead of ListView for simplicity
                      Column(
                        children: List.generate(compOrIncomp.length, (index) {
                          final isSelected =
                              selectedIndexCompleted == index; // single select
                          return CheckboxListTile(
                            contentPadding: EdgeInsets.zero,
                            activeColor: primary,
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Text(
                              compOrIncomp[index],
                              style: TextStyle(
                                  fontWeight:
                                      isSelected ? FontWeight.w600 : null),
                            ),
                            value: isSelected,
                            onChanged: (bool? value) {
                              setState(() {
                                selectedIndexCompleted = value == true
                                    ? index
                                    : selectedIndexCompleted;
                              });
                              debugPrint(
                                  "Category index: $index | value: ${compOrIncomp[index]}");
                            },
                          );
                        }),
                      ),

                      const SizedBox(height: 10),
                      _sectionTitle("Manual or Invited"),
                      const SizedBox(height: 10),

                      // Selectable cards (responsive wrap)
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          _SelectCard(
                            label: "All",
                            isSelected: selectedInviteManual == 0,
                            primary: primary,
                            onTap: () => setState(() {
                              selectedInviteManual = 0;
                            }),
                          ),
                          _SelectCard(
                            label: "Invited",
                            isSelected: selectedInviteManual == 1,
                            primary: primary,
                            onTap: () => setState(() {
                              selectedInviteManual = 1;
                            }),
                          ),
                          _SelectCard(
                            label: "Manual",
                            isSelected: selectedInviteManual == 2,
                            primary: primary,
                            onTap: () => setState(() {
                              selectedInviteManual = 2;
                            }),
                          ),
                        ],
                      ),

                      const SizedBox(height: 80), // space above sticky footer
                    ],
                  ),
                ),
              ),

              // Sticky footer actions
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      spreadRadius: 0,
                      offset: const Offset(0, -4),
                      color: Colors.black.withOpacity(0.06),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          side: BorderSide(color: primary, width: 1.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          foregroundColor: primary,
                        ),
                        onPressed: _onClear,
                        child: const Text(
                          "Clear",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                        ),
                        onPressed: _onApply,
                        child: const Text(
                          "Apply",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<DateTime?> _chooseDate({DateTime? initial}) {
    return showDatePicker(
      context: context,
      initialDate: initial ?? DateTime.now(),
      firstDate: DateTime(2020, 1, 1),
      lastDate: DateTime(2035, 12, 31),
    );
  }

  void _toast(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  void _onClear() {
    setState(() {
      startDate = null;
      endDate = null;
      startDateString = null;
      endDateString = null;
      selectedIndexCompleted = 0;
      selectedInviteManual = 0;
    });
  }

  void _onApply() {
    // Return the selected values to caller
    // final result = {
    //   "startDate": startDate,
    //   "endDate": endDate,
    //   "startDateString": startDateString,
    //   "endDateString": endDateString,
    //   "categoryIndex": selectedIndexCompleted,
    //   "categoryLabel": compOrIncomp[selectedIndexCompleted],
    //   "inviteManualIndex": selectedInviteManual, // 0/1/2
    //   "inviteManualLabel": ["All", "Invited", "Manual"][selectedInviteManual],
    // };
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => calendermain(
                  startdatedp: startDate,
                  enddatedp: endDate,
                  comporincompint: selectedIndexCompleted,
                  inviteormanual: selectedInviteManual,
                )));
  }

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14.5,
        fontWeight: FontWeight.w700,
        color: Colors.black87,
      ),
    );
  }
}

/// Nice input-like date field
class _DateField extends StatelessWidget {
  final String label;
  final String? value;
  final IconData icon;
  final VoidCallback onTap;

  const _DateField({
    required this.label,
    required this.value,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasValue = (value != null && value!.isNotEmpty);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Ink(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black12),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: Colors.black54),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                hasValue ? value! : label,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  color: hasValue ? Colors.black : Colors.black45,
                  fontWeight: hasValue ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(width: 6),
            Icon(Icons.keyboard_arrow_down, color: Colors.black38),
          ],
        ),
      ),
    );
  }
}

/// Selectable card (All / Invited / Manual)
class _SelectCard extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final Color primary;

  const _SelectCard({
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.primary,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? primary.withOpacity(0.10) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? primary : Colors.black12,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isSelected)
              Padding(
                padding: const EdgeInsets.only(right: 6.0),
                child: Icon(Icons.check_circle, size: 18, color: primary),
              ),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? primary : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
