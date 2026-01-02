import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

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
          'About Us',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
        ),
        backgroundColor: kGold,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo/Image Section
            Center(
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: kGold,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.beach_access, size: 60, color: Colors.white),
              ),
            ),
            const SizedBox(height: 24),

            // About Content
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Uppuveli Beach by DSK',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: kCharcoal,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Luxury Beachfront Resort',
                    style: TextStyle(fontSize: 14, color: kGray),
                  ),
                  const SizedBox(height: 24),
                  _buildSection(
                    'Our Story',
                    'Nestled along the pristine shores of Uppuveli Beach in Trincomalee, Uppuveli Beach by DSK offers an unparalleled luxury beachfront experience. Since our establishment, we have been committed to providing exceptional hospitality and creating unforgettable memories for our guests.\n\nOur resort combines modern amenities with traditional Sri Lankan warmth, offering a perfect blend of relaxation, adventure, and cultural immersion. Whether you\'re seeking a romantic getaway, a family vacation, or a wellness retreat, we provide the perfect setting for your ideal escape.',
                  ),
                  _buildSection(
                    'Our Mission',
                    'To provide exceptional hospitality experiences that celebrate the natural beauty of Sri Lanka\'s east coast while ensuring the highest standards of comfort, service, and sustainability.',
                  ),
                  _buildSection(
                    'Our Values',
                    '• Excellence: We strive for excellence in every aspect of our service\n• Sustainability: We are committed to environmental responsibility\n• Authenticity: We celebrate local culture and traditions\n• Hospitality: We treat every guest as family\n• Innovation: We continuously improve our services and facilities',
                  ),
                  _buildSection(
                    'Facilities & Services',
                    '• Beachfront accommodation with ocean views\n• World-class spa and wellness center\n• Multiple dining venues featuring local and international cuisine\n• Swimming pool and fitness center\n• Water sports and activities\n• Cultural tours and excursions\n• Event and conference facilities',
                  ),
                  _buildSection(
                    'Awards & Recognition',
                    'We are proud to have received recognition for our commitment to excellence in hospitality and sustainable tourism practices.',
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Contact Information
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Contact Us',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: kCharcoal,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildContactItem(Icons.location_on, 'Uppuveli Beach, Trincomalee, Sri Lanka'),
                  const SizedBox(height: 12),
                  _buildContactItem(Icons.phone, '+94 26 123 4567'),
                  const SizedBox(height: 12),
                  _buildContactItem(Icons.email, 'info@uppuvelibeach.com'),
                  const SizedBox(height: 12),
                  _buildContactItem(Icons.language, 'www.uppuvelibeach.com'),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Version Info
            Center(
              child: Text(
                'App Version 1.0.0',
                style: TextStyle(fontSize: 12, color: kGray),
              ),
            ),
            const SizedBox(height: 16),
          ],
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

  Widget _buildContactItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20, color: kGold),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 13, color: kCharcoal),
          ),
        ),
      ],
    );
  }
}


