import 'package:flutter/material.dart';
import '../core/widgets/bottom_nav_bar.dart';
import 'loyaltyP.dart';
import 'welcomeP.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static const Color kGold = Color(0xFFC9A633);
  static const Color kBg = Color(0xFFF9F8F3);
  static const Color kCharcoal = Color(0xFF2C3E3F);
  static const Color kGray = Color(0xFF7A8A8D);

  // Mock user data
  final String userName = 'John Doe';
  final String userEmail = 'john.doe@example.com';
  final String userPhone = '+94 77 123 4567';
  final int loyaltyPoints = 1200;
  final int totalBookings = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: kCharcoal,
          ),
        ),
        backgroundColor: kGold,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            // User Info Card
            _buildUserInfoCard(),
            const SizedBox(height: 16),
            // Quick Stats
            _buildQuickStats(),
            const SizedBox(height: 16),
            // Menu Items
            _buildMenuSection(context),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(activeIndex: 3),
    );
  }

  // ==================== USER INFO CARD ====================
  Widget _buildUserInfoCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: kGold.withOpacity(0.15),
              border: Border.all(color: kGold, width: 2),
            ),
            child: const Icon(
              Icons.person,
              size: 40,
              color: kGold,
            ),
          ),
          const SizedBox(width: 16),
          // User Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: kCharcoal,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.email_outlined, size: 14, color: kGray),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        userEmail,
                        style: const TextStyle(
                          fontSize: 13,
                          color: kGray,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.phone_outlined, size: 14, color: kGray),
                    const SizedBox(width: 6),
                    Text(
                      userPhone,
                      style: const TextStyle(
                        fontSize: 13,
                        color: kGray,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Edit Button
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: kGold),
            onPressed: () {
              debugPrint('Edit profile tapped');
              // TODO: Navigate to edit profile page
            },
          ),
        ],
      ),
    );
  }

  // ==================== QUICK STATS ====================
  Widget _buildQuickStats() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _statItem(
              icon: Icons.stars_rounded,
              label: 'Loyalty Points',
              value: loyaltyPoints.toString(),
              onTap: () {
                debugPrint('Loyalty points tapped');
                // TODO: Navigate to loyalty page
              },
            ),
          ),
          Container(
            width: 1,
            height: 40,
            color: Colors.black12,
          ),
          Expanded(
            child: _statItem(
              icon: Icons.book_outlined,
              label: 'Bookings',
              value: totalBookings.toString(),
              onTap: () {
                debugPrint('Bookings tapped');
                // TODO: Navigate to bookings page
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _statItem({
    required IconData icon,
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Icon(icon, color: kGold, size: 24),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: kCharcoal,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                color: kGray,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // ==================== MENU SECTION ====================
  Widget _buildMenuSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Account',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: kCharcoal,
            ),
          ),
        ),
        _buildMenuItem(
          icon: Icons.person_outline,
          title: 'Edit Profile',
          onTap: () {
            debugPrint('Edit Profile tapped');
            // TODO: Navigate to edit profile page
          },
        ),
        _buildMenuItem(
          icon: Icons.book_outlined,
          title: 'My Bookings',
          onTap: () {
            debugPrint('My Bookings tapped');
            // TODO: Navigate to bookings page
          },
        ),
        _buildMenuItem(
          icon: Icons.stars_rounded,
          title: 'Loyalty Points',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => LoyaltyDashboardPage(
                  previousPoints: loyaltyPoints,
                  pointsEarnedThisBooking: 0,
                  pointsUsedInPayment: 0,
                  lifetimeStays: totalBookings,
                  pointsThisYear: loyaltyPoints,
                ),
              ),
            );
          },
        ),
        _buildMenuItem(
          icon: Icons.payment_outlined,
          title: 'Payment Methods',
          onTap: () {
            debugPrint('Payment Methods tapped');
            // TODO: Navigate to payment methods page
          },
        ),
        const SizedBox(height: 16),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Support',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: kCharcoal,
            ),
          ),
        ),
        _buildMenuItem(
          icon: Icons.help_outline,
          title: 'Help & Support',
          onTap: () {
            debugPrint('Help & Support tapped');
            // TODO: Navigate to help page
          },
        ),
        _buildMenuItem(
          icon: Icons.info_outline,
          title: 'About',
          onTap: () {
            debugPrint('About tapped');
            // TODO: Show about dialog
          },
        ),
        _buildMenuItem(
          icon: Icons.privacy_tip_outlined,
          title: 'Privacy Policy',
          onTap: () {
            debugPrint('Privacy Policy tapped');
            // TODO: Navigate to privacy policy page
          },
        ),
        _buildMenuItem(
          icon: Icons.description_outlined,
          title: 'Terms & Conditions',
          onTap: () {
            debugPrint('Terms & Conditions tapped');
            // TODO: Navigate to terms page
          },
        ),
        const SizedBox(height: 16),
        // Logout Button
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: ElevatedButton(
            onPressed: () => _showLogoutDialog(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade50,
              foregroundColor: Colors.red,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.red.shade200),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.logout, size: 20),
                SizedBox(width: 8),
                Text(
                  'Log Out',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ==================== MENU ITEM ====================
  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: kGold.withOpacity(0.15),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: kGold, size: 20),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: kCharcoal,
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right,
          color: kGray,
          size: 20,
        ),
        onTap: onTap,
      ),
    );
  }

  // ==================== LOGOUT DIALOG ====================
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Log Out'),
        content: const Text('Are you sure you want to log out?'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Navigate to welcome page
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const WelcomePage()),
                (route) => false,
              );
            },
            child: const Text(
              'Log Out',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

