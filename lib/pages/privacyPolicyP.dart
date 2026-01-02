import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  static const Color kGold = Color(0xFFC9A633);
  static const Color kBg = Color(0xFFF9F8F3);
  static const Color kCharcoal = Color(0xFF2C3E3F);
  static const Color kGray = Color(0xFF7A8A8D);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Privacy Policy',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
        ),
        backgroundColor: kGold,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Privacy Policy',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: kCharcoal,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Last updated: January 2026',
                style: TextStyle(fontSize: 12, color: kGray),
              ),
              const SizedBox(height: 24),
              _buildSection(
                '1. Introduction',
                'Uppuveli Beach by DSK ("we", "our", or "us") is committed to protecting your privacy. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our mobile application.',
              ),
              _buildSection(
                '2. Information We Collect',
                'We collect information that you provide directly to us, including:\n\n• Personal identification information (name, email, phone number)\n• Booking and reservation details\n• Payment information\n• Profile preferences and settings\n• Communication preferences',
              ),
              _buildSection(
                '3. How We Use Your Information',
                'We use the information we collect to:\n\n• Process and manage your bookings and reservations\n• Send you booking confirmations and updates\n• Provide customer support\n• Improve our services and user experience\n• Send promotional materials (with your consent)\n• Comply with legal obligations',
              ),
              _buildSection(
                '4. Information Sharing',
                'We do not sell, trade, or rent your personal information to third parties. We may share your information only in the following circumstances:\n\n• With service providers who assist us in operating our app\n• When required by law or to protect our rights\n• With your explicit consent',
              ),
              _buildSection(
                '5. Data Security',
                'We implement appropriate technical and organizational measures to protect your personal information against unauthorized access, alteration, disclosure, or destruction.',
              ),
              _buildSection(
                '6. Your Rights',
                'You have the right to:\n\n• Access your personal information\n• Correct inaccurate data\n• Request deletion of your data\n• Object to processing of your data\n• Data portability',
              ),
              _buildSection(
                '7. Cookies and Tracking',
                'Our app may use cookies and similar tracking technologies to enhance your experience. You can control cookie preferences through your device settings.',
              ),
              _buildSection(
                '8. Children\'s Privacy',
                'Our services are not intended for children under 18 years of age. We do not knowingly collect personal information from children.',
              ),
              _buildSection(
                '9. Changes to This Policy',
                'We may update this Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page and updating the "Last updated" date.',
              ),
              _buildSection(
                '10. Contact Us',
                'If you have any questions about this Privacy Policy, please contact us at:\n\nEmail: privacy@uppuvelibeach.com\nPhone: +94 26 123 4567\nAddress: Uppuveli Beach by DSK, Trincomalee, Sri Lanka',
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: kCharcoal,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(
              fontSize: 13,
              color: kCharcoal,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}


