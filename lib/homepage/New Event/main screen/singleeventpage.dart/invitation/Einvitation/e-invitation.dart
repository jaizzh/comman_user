import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:common_user/app_colors.dart';
import 'package:common_user/homepage/New Event/main screen/singleeventpage.dart/invitation/invitationhome.dart';
import 'package:common_user/homepage/New Event/main screen/singleeventpage.dart/invitation/Einvitation/invitationlist.dart';
import 'package:common_user/homepage/New%20Event/main%20screen/singleeventpage.dart/invitation/Einvitation/single-Einvitation.dart';

/// Premium e-Invitation Listing
class Einvitation extends StatefulWidget {
  const Einvitation({super.key});
  @override
  State<Einvitation> createState() => _EinvitationState();
}

class _EinvitationState extends State<Einvitation> {
  // DATA
  late final List<MapEntry<String, String>> all = invitelist.entries.toList();
  List<MapEntry<String, String>> filtered = [];

  // FILTER STATE
  final TextEditingController _searchCtrl = TextEditingController();
  String _searchQuery = '';
  Set<String> _selectedCats = {};

  @override
  void initState() {
    super.initState();
    filtered = List.from(all);
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  // Apply BOTH search + category filters
  void _applyFilters() {
    final q = _searchQuery.toLowerCase().trim();
    final cats = _selectedCats.map((e) => e.toLowerCase()).toSet();

    setState(() {
      filtered = all.where((e) {
        final v = e.value.toLowerCase();
        final matchesQuery = q.isEmpty || v.contains(q);
        final matchesCats = cats.isEmpty || cats.any((c) => v.contains(c));
        return matchesQuery && matchesCats;
      }).toList();
    });
  }

  void _onSearchChanged(String text) {
    _searchQuery = text;
    _applyFilters();
  }

  Future<void> _openFilterSheet() async {
    final result = await filtersheet(context, _selectedCats);
    if (result != null && result is Set<String>) {
      _selectedCats = result;
      _applyFilters();
    }
  }

  @override
  Widget build(BuildContext context) {
    final topSafe = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Premium AppBar
          Container(
            padding: EdgeInsets.only(top: topSafe),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: SizedBox(
              height: 60,
              child: Row(
                children: [
                  const SizedBox(width: 4),
                  IconButton(
                    tooltip: 'Back',
                    icon: const Icon(Icons.arrow_back_ios_new_rounded,
                        color: Colors.black87),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const InvitationHome()),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Invitations",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  // Spacer for symmetry
                  const SizedBox(width: 48),
                ],
              ),
            ),
          ),

          // Search + Filter
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
            child: Row(
              children: [
                Expanded(
                  child: _PremiumSearchField(
                    controller: _searchCtrl,
                    hint: 'Search invitations…',
                    onChanged: _onSearchChanged,
                  ),
                ),
                const SizedBox(width: 10),
                _IconPillButton(
                  icon: Icons.filter_alt_rounded,
                  label: 'Filter',
                  onTap: _openFilterSheet,
                ),
              ],
            ),
          ),

          // Active filter chips preview
          if (_selectedCats.isNotEmpty)
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Wrap(
                spacing: 8,
                runSpacing: -8,
                children: _selectedCats
                    .map((c) => InputChip(
                          label: Text(c),
                          labelStyle: GoogleFonts.inter(
                              fontSize: 12, fontWeight: FontWeight.w600),
                          onDeleted: () {
                            setState(() {
                              _selectedCats.remove(c);
                              _applyFilters();
                            });
                          },
                          backgroundColor: Colors.white,
                          side: BorderSide(color: AppColors.primary, width: 1),
                          deleteIconColor: Colors.black87,
                        ))
                    .toList(),
              ),
            ),

          // Grid
          Expanded(
            child: filtered.isEmpty
                ? const _EmptyState()
                : GridView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 18,
                      childAspectRatio: 3 / 4.2,
                    ),
                    itemCount: filtered.length,
                    itemBuilder: (context, i) {
                      final e = filtered[i];
                      return _InvitationCard(
                        imagePath: e.key,
                        title: e.value,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => singleeinvite(imagevalue: e.key),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

/// ---------- Premium Widgets ----------

class _PremiumSearchField extends StatelessWidget {
  const _PremiumSearchField({
    required this.controller,
    required this.onChanged,
    this.hint,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      elevation: 2,
      shadowColor: const Color(0x12000000),
      child: TextField(
        controller: controller,
        maxLength: 30,
        onChanged: onChanged,
        style: GoogleFonts.inter(fontSize: 14.5, height: 1.2),
        decoration: InputDecoration(
          counterText: '',
          isDense: true,
          hintText: hint ?? 'Search…',
          hintStyle: GoogleFonts.inter(color: Colors.black45),
          prefixIcon: const Icon(Icons.search_rounded, color: Colors.black54),
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE8E8EA)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: AppColors.primary, width: 1.4),
          ),
        ),
      ),
    );
  }
}

class _IconPillButton extends StatelessWidget {
  const _IconPillButton(
      {required this.icon, required this.label, required this.onTap});
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE8E8EA)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0F000000),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primary, size: 20),
            const SizedBox(width: 6),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 13.5,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InvitationCard extends StatelessWidget {
  const _InvitationCard({
    required this.imagePath,
    required this.title,
    required this.onTap,
  });

  final String imagePath;
  final String title;
  final VoidCallback onTap;

  static const double _radius = 16;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_radius),
          boxShadow: const [
            BoxShadow(
              color: Color(0x16000000),
              blurRadius: 12,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(_radius),
          child: Material(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Image + gradient overlay + quick action
                Expanded(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Hero(
                        tag: imagePath,
                        child: Image.asset(
                          imagePath,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const Center(
                            child: Icon(Icons.broken_image_outlined, size: 28),
                          ),
                        ),
                      ),
                      // subtle gradient
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 80,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.transparent, Colors.black54],
                            ),
                          ),
                        ),
                      ),
                      // favorite icon (placeholder action)
                      Positioned(
                        right: 8,
                        top: 8,
                        child: _FrostedIcon(
                          icon: Icons.favorite_border_rounded,
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                ),

                // Title block
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.inter(
                                fontSize: 14.5,
                                fontWeight: FontWeight.w800,
                                color: Colors.black.withOpacity(0.85),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _MiniDivider(color: AppColors.primary),
                          const SizedBox(width: 6),
                          Text('Invite',
                              style: GoogleFonts.inter(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primary)),
                          const SizedBox(width: 6),
                          _MiniDivider(color: AppColors.primary),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FrostedIcon extends StatelessWidget {
  const _FrostedIcon({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Material(
        color: Colors.white.withOpacity(0.75),
        child: InkWell(
          onTap: onTap,
          child: const SizedBox(
            width: 36,
            height: 36,
            child: Icon(Icons.favorite_border_rounded,
                size: 20, color: Colors.black87),
          ),
        ),
      ),
    );
  }
}

class _MiniDivider extends StatelessWidget {
  const _MiniDivider({required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 26,
      height: 2,
      decoration: BoxDecoration(
        color: color.withOpacity(0.8),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.search_off_rounded, size: 48, color: Colors.black38),
          const SizedBox(height: 10),
          Text(
            "No invitations found",
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Try a different keyword or filter",
            style: GoogleFonts.inter(fontSize: 13, color: Colors.black45),
          ),
        ],
      ),
    );
  }
}

/// ---------- Premium Filter Sheet ----------
Future<Set<String>?> filtersheet(
  BuildContext context,
  Set<String> initialSelected,
) {
  return showModalBottomSheet<Set<String>>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (ctx) {
      final height = MediaQuery.of(ctx).size.height * 0.55;
      return _RoundedSheet(
        child: SizedBox(
          height: height,
          child: _FilterBody(initialSelected: initialSelected),
        ),
      );
    },
  );
}

class _RoundedSheet extends StatelessWidget {
  const _RoundedSheet({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
          boxShadow: [
            BoxShadow(
              color: Color(0x22000000),
              blurRadius: 24,
              offset: Offset(0, -6),
            )
          ],
        ),
        child: child,
      ),
    );
  }
}

class _FilterBody extends StatefulWidget {
  const _FilterBody({required this.initialSelected});
  final Set<String> initialSelected;

  @override
  State<_FilterBody> createState() => _FilterBodyState();
}

class _FilterBodyState extends State<_FilterBody> {
  final List<String> categories = const [
    'Wedding',
    'Reception',
    'Birthday',
    'Engagement',
    'Farewell',
    'Anniversary',
    'Baby Shower',
    'Housewarming',
  ];
  late Set<String> selected;

  @override
  void initState() {
    super.initState();
    selected = {...widget.initialSelected};
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Column(
        children: [
          const SizedBox(height: 10),
          Container(
            width: 44,
            height: 5,
            decoration: BoxDecoration(
              color: const Color(0xFFE6E6EA),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 8, 6),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Filtered Search",
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: Colors.black87,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () =>
                      Navigator.pop(context, widget.initialSelected),
                  icon: const Icon(Icons.close_rounded, size: 24),
                )
              ],
            ),
          ),
          Container(height: 1, color: const Color(0xFFF0F0F2)),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Filter by Categories",
                style: GoogleFonts.inter(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 6, 16, 8),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: categories.map((c) {
                  final isSel = selected.contains(c);
                  return FilterChip(
                    label: Text(
                      c,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700,
                        color: isSel ? Colors.white : Colors.black87,
                      ),
                    ),
                    selected: isSel,
                    onSelected: (v) => setState(
                        () => v ? selected.add(c) : selected.remove(c)),
                    selectedColor: AppColors.primary,
                    checkmarkColor: Colors.white,
                    backgroundColor: Colors.white,
                    side: BorderSide(
                        color: isSel
                            ? AppColors.primary
                            : const Color(0xFFE6E6EA)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24)),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  );
                }).toList(),
              ),
            ),
          ),
          Container(height: 1, color: const Color(0xFFF0F0F2)),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 18),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => setState(() => selected.clear()),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: const BorderSide(color: Color(0xFFE6E6EA)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text(
                      "Clear",
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700, color: Colors.black87),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context, selected),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 0,
                    ),
                    child: Text(
                      "Apply",
                      style: GoogleFonts.inter(fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
