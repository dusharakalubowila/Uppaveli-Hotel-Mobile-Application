import 'package:flutter/material.dart';
import '../../pages/homeP.dart';
import '../../pages/exploreP.dart';
import '../../pages/bookmarkP.dart';
import '../../pages/profileP.dart';

/// Shared bottom navigation bar component
/// Used across all main pages for consistent navigation
class BottomNavBar extends StatelessWidget {
  final int activeIndex;

  const BottomNavBar({
    super.key,
    required this.activeIndex,
  });

  static const Color kGold = Color(0xFFC9A633);
  static const Color kCharcoal = Color(0xFF2C3E3F);
  static const Color kActiveColor = Color(0xFF0D3B2E);
  static const Color kInactiveColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 74,
      color: kGold,
      padding: const EdgeInsets.only(bottom: 6, top: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavItem(
            label: 'Home',
            icon: Icons.home_outlined,
            isActive: activeIndex == 0,
            onTap: () => _navigateToHome(context),
          ),
          _NavItem(
            label: 'Explore',
            icon: Icons.search_outlined,
            isActive: activeIndex == 1,
            onTap: () => _navigateToExplore(context),
          ),
          _NavItem(
            label: 'Bookmark',
            icon: Icons.favorite_border,
            isActive: activeIndex == 2,
            onTap: () => _navigateToBookmark(context),
          ),
          _NavItem(
            label: 'Profile',
            icon: Icons.person_outline,
            isActive: activeIndex == 3,
            onTap: () => _navigateToProfile(context),
          ),
        ],
      ),
    );
  }

  void _navigateToHome(BuildContext context) {
    if (activeIndex == 0) return; // Already on home
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const HomePage(
          displayName: 'User',
          isGuest: false,
          initialTabIndex: 0,
        ),
      ),
    );
  }

  void _navigateToExplore(BuildContext context) {
    if (activeIndex == 1) return; // Already on explore
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const ExplorePage(),
      ),
    );
  }

  void _navigateToBookmark(BuildContext context) {
    if (activeIndex == 2) return; // Already on bookmark
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const BookmarkPage(),
      ),
    );
  }

  void _navigateToProfile(BuildContext context) {
    if (activeIndex == 3) return; // Already on profile
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const ProfilePage(),
      ),
    );
  }
}

/// Navigation item widget
class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.label,
    required this.icon,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final activeColor = isActive ? BottomNavBar.kActiveColor : BottomNavBar.kInactiveColor.withOpacity(0.85);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: SizedBox(
        width: 74,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: activeColor),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                color: activeColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

