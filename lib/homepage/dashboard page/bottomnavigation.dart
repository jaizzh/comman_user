// ignore_for_file: deprecated_member_use
import 'package:common_user/common/colors.dart';
import 'package:flutter/material.dart';

/// === The bottom navigation bar ===
class FancyBottomNav extends StatefulWidget {
  const FancyBottomNav({
    super.key,
    required this.currentIndex,
    required this.onChanged,
  });

  final int currentIndex;
  final ValueChanged<int> onChanged;

  @override
  State<FancyBottomNav> createState() => _FancyBottomNavState();
}

class _FancyBottomNavState extends State<FancyBottomNav> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      //  minimum: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Container(
        height: 84,
        // color: AppColors.boxlightcolor,
        //padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: const BoxDecoration(
          color: Colors.white,
          //    borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 24,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavItem(
              label: 'Home',
              icon: Icons.home_outlined,
              index: 0,
              isActive: widget.currentIndex == 0,
              onTap: widget.onChanged,
            ),
            _NavItem(
              label: 'Venue',
              icon: Icons.place,
              index: 1,
              isActive: widget.currentIndex == 1,
              onTap: widget.onChanged,
            ),
            _NavItem(
              label: 'Vendor',
              icon: Icons.assignment_ind_sharp,
              index: 2,
              isActive: widget.currentIndex == 2,
              onTap: widget.onChanged,
            ),
            _NavItem(
              label: 'Send_Gift',
              icon: Icons.card_giftcard_outlined,
              index: 3,
              isActive: widget.currentIndex == 3,
              onTap: widget.onChanged,
            ),
            _NavItem(
              label: 'Invitation',
              icon: Icons.insert_invitation_outlined,
              index: 4,
              isActive: widget.currentIndex == 4,
              onTap: widget.onChanged,
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.label,
    required this.icon,
    required this.index,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final int index;
  final bool isActive;
  final ValueChanged<int> onTap;
  static final Color _accent = AppColors.buttoncolor;
  static final Color _accentLight = AppColors.buttoncolor.withOpacity(.200);
  static const Color _iconInactive = Color(0xFF5A5A5A);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () => onTap(index),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // icon chip background (only for active)
            AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeInOut,
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: isActive ? _accentLight : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                size: 24,
                color: isActive ? _accent : _iconInactive,
              ),
            ),
            const SizedBox(height: 6),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isActive ? _accent : _iconInactive.withOpacity(.7),
              ),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}
