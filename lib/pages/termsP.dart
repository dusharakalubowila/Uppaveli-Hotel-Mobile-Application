import 'package:flutter/material.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

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
          'Terms & Conditions',
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
                'Terms & Conditions',
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
                '1. Acceptance of Terms',
                'By accessing and using the Uppuveli Beach mobile application, you accept and agree to be bound by the terms and provision of this agreement.',
              ),
              _buildSection(
                '2. Use License',
                'Permission is granted to temporarily download one copy of the materials on Uppuveli Beach\'s app for personal, non-commercial transitory viewing only. This is the grant of a license, not a transfer of title.',
              ),
              _buildSection(
                '3. Bookings and Reservations',
                '• All bookings are subject to availability\n• Prices are subject to change without notice\n• Cancellation policies apply as per booking terms\n• Payment must be made in full or as per agreed terms\n• We reserve the right to refuse service',
              ),
              _buildSection(
                '4. Cancellation and Refund Policy',
                '• Cancellations made 48 hours before check-in: Full refund\n• Cancellations made 24-48 hours before: 50% refund\n• Cancellations made less than 24 hours: No refund\n• Refunds will be processed within 7-14 business days',
              ),
              _buildSection(
                '5. User Accounts',
                'You are responsible for maintaining the confidentiality of your account credentials. You agree to notify us immediately of any unauthorized use of your account.',
              ),
              _buildSection(
                '6. Prohibited Activities',
                'You agree not to:\n\n• Use the app for any unlawful purpose\n• Attempt to gain unauthorized access to the app\n• Transmit any viruses or malicious code\n• Interfere with the app\'s functionality\n• Use automated systems to access the app',
              ),
              _buildSection(
                '7. Intellectual Property',
                'All content, features, and functionality of the app, including but not limited to text, graphics, logos, and software, are the property of Uppuveli Beach by DSK and are protected by copyright and trademark laws.',
              ),
              _buildSection(
                '8. Limitation of Liability',
                'Uppuveli Beach by DSK shall not be liable for any indirect, incidental, special, consequential, or punitive damages resulting from your use of the app.',
              ),
              _buildSection(
                '9. Indemnification',
                'You agree to indemnify and hold harmless Uppuveli Beach by DSK from any claims, damages, losses, liabilities, and expenses arising out of your use of the app.',
              ),
              _buildSection(
                '10. Modifications',
                'We reserve the right to modify these terms at any time. Your continued use of the app after any changes constitutes acceptance of the new terms.',
              ),
              _buildSection(
                '11. Governing Law',
                'These terms shall be governed by and construed in accordance with the laws of Sri Lanka, without regard to its conflict of law provisions.',
              ),
              _buildSection(
                '12. Contact Information',
                'For questions about these Terms & Conditions, please contact us at:\n\nEmail: legal@uppuvelibeach.com\nPhone: +94 26 123 4567\nAddress: Uppuveli Beach by DSK, Trincomalee, Sri Lanka',
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


