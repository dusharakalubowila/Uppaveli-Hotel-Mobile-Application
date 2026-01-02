import 'package:flutter/material.dart';
import '../core/widgets/bottom_nav_bar.dart';

class FacilityDetailPage extends StatelessWidget {
  final String facilityId;

  const FacilityDetailPage({
    super.key,
    required this.facilityId,
  });

  static const Color kGold = Color(0xFFC9A633);
  static const Color kBg = Color(0xFFF9F8F3);
  static const Color kCharcoal = Color(0xFF2C3E3F);
  static const Color kGray = Color(0xFF7A8A8D);

  // Mock facility data
  static final Map<String, Map<String, dynamic>> facilityData = {
    'fac-001': {
      'id': 'fac-001',
      'name': 'Beach front Swimming pool',
      'hours': '7 AM - 9 PM ( Everyday )',
      'imageUrl': 'assets/images/beach.png',
      'description':
          'The beachfront swimming pool offers uninterrupted views of the ocean, allowing guests to relax just steps from the shoreline. Surrounded by sea breeze and open skies, it is an ideal spot for a refreshing swim, sunbathing, or enjoying the calm coastal atmosphere throughout the day.',
      'type': 'pool',
      'guidelines': [
        {'icon': '👶', 'text': 'PROPER POOL ATTIRE SHOULD BE WORN ALL TIMES'},
        {'icon': '📏', 'text': 'MAXIMUM DEPTH IS 1.2 METERS'},
        {'icon': '🚿', 'text': 'PLEASE SHOWER BEFORE ENTERING THE POOL'},
        {'icon': '👨‍👩‍👧', 'text': 'CHILDREN MUST BE SUPERVISED AT ALL TIMES'},
        {'icon': '🏊', 'text': 'NO DIVING'},
        {'icon': '🏋️', 'text': 'NO LIFEGUARD ON DUTY'},
        {'icon': '🍺', 'text': 'NO GLASS CONTAINERS OR ALCOHOLIC DRINKS'},
      ],
    },
    'fac-002': {
      'id': 'fac-002',
      'name': 'GYM',
      'hours': '24 hrs ( Everyday )',
      'imageUrl': 'assets/images/room.png',
      'description':
          'Our gym is designed to support your fitness and well-being in a calm, comfortable setting. Equipped with essential workout facilities, it offers a convenient space to stay active, energized, and balanced during your stay at Uppuveli Beach by DSK.',
      'type': 'gym',
      'gallery': [
        'assets/images/beach.png',
        'assets/images/breeze.png',
        'assets/images/garden.png',
        'assets/images/room.png',
      ],
      'etiquette': [
        {'icon': '🏋️', 'text': 'GYM FACILITIES ARE AVAILABLE EXCLUSIVELY FOR IN-HOUSE GUESTS'},
        {'icon': '👟', 'text': 'KINDLY WEAR APPROPRIATE FITNESS ATTIRE AND TRAINING SHOES'},
        {'icon': '💪', 'text': 'EXERCISE MINDFULLY AND WITHIN YOUR PERSONAL CAPACITY'},
        {'icon': '🧘', 'text': 'BEGIN EACH SESSION WITH A WARM-UP AND CONCLUDE WITH A COOL-DOWN'},
        {'icon': '📋', 'text': 'MAINTAIN HYDRATION THROUGHOUT YOUR WORKOUT'},
        {'icon': '⚠️', 'text': 'DISCONTINUE EXERCISE IMMEDIATELY IF YOU EXPERIENCE DISCOMFORT OR DIZZINESS'},
      ],
    },
    'fac-003': {
      'id': 'fac-003',
      'name': 'Pool Bar',
      'hours': '2 PM - 5 PM ( Everyday )',
      'imageUrl': 'assets/images/breeze.png',
      'description':
          'The Pool Bar offers a relaxed atmosphere where guests can enjoy refreshing beverages, light meals, and stunning ocean views. Perfect for unwinding after a day at the beach or pool.',
      'type': 'dining',
      'menu': {
        'APPERATIEF (50 ML)': [
          {'name': 'Martini Bianco', 'price': 650.00},
          {'name': 'Martini Rosso', 'price': 650.00},
          {'name': 'Martini Dry', 'price': 650.00},
          {'name': 'Ricard', 'price': 1900.00},
          {'name': 'Pernod', 'price': 1900.00},
        ],
        'SHERY & PORT (50 ML)': [
          {'name': 'Cockhurns ruby', 'price': 1150.00},
          {'name': 'Cockhurns tawny', 'price': 1150.00},
        ],
        'WHISKY (25 ML)': [],
        'PREMIUM': [
          {'name': 'Glenliger', 'price': 2800.00},
          {'name': 'Glenfiddish 12y', 'price': 2475.00},
          {'name': 'Aberfeldy', 'price': 2350.00},
          {'name': 'Monkey shoulder', 'price': 2200.00},
          {'name': 'Chivas regais', 'price': 2100.00},
          {'name': 'Markers Mark', 'price': 1790.00},
        ],
      },
    },
    'fac-004': {
      'id': 'fac-004',
      'name': 'Thendral Bliss',
      'hours': '9 AM - 8 PM ( Everyday )',
      'imageUrl': 'assets/images/beach.png',
      'description':
          'Thendral Bliss Spa offers a serene sanctuary for relaxation and rejuvenation. Experience traditional Ayurvedic treatments, therapeutic massages, and wellness therapies in a tranquil setting that harmonizes mind, body, and spirit.',
      'type': 'spa',
      'guidelines': [
        {'icon': '🧘', 'text': 'APPOINTMENTS ARE RECOMMENDED FOR ALL TREATMENTS'},
        {'icon': '⏰', 'text': 'ARRIVE 15 MINUTES BEFORE YOUR SCHEDULED APPOINTMENT'},
        {'icon': '🔇', 'text': 'MAINTAIN SILENCE TO PRESERVE THE PEACEFUL ATMOSPHERE'},
        {'icon': '📱', 'text': 'PLEASE KEEP MOBILE DEVICES ON SILENT MODE'},
        {'icon': '👕', 'text': 'COMFORTABLE ATTIRE IS RECOMMENDED FOR TREATMENTS'},
        {'icon': '💆', 'text': 'INFORM YOUR THERAPIST OF ANY MEDICAL CONDITIONS OR ALLERGIES'},
        {'icon': '🌿', 'text': 'TREATMENTS USE NATURAL AYURVEDIC OILS AND HERBS'},
      ],
    },
  };

  @override
  Widget build(BuildContext context) {
    final facility = facilityData[facilityId] ?? facilityData['fac-001']!;

    return Scaffold(
      backgroundColor: kBg,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          facility['name'] as String,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Image with Hours Badge
            _buildHeroImage(facility),

            const SizedBox(height: 16),

            // Description Section
            _buildDescriptionCard(facility),

            const SizedBox(height: 12),

            // Conditional sections based on facility type
            if (facility['type'] == 'pool' || facility['type'] == 'gym' || facility['type'] == 'spa')
              _buildGuidelinesCard(facility, context),

            if (facility['type'] == 'gym') ...[
              const SizedBox(height: 12),
              _buildGallerySection(facility),
            ],

            if (facility['type'] == 'gym') ...[
              const SizedBox(height: 12),
              _buildEtiquetteCard(facility),
            ],

            if (facility['type'] == 'dining') ...[
              const SizedBox(height: 12),
              _buildMenuCard(facility),
            ],

            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(activeIndex: 1), // Explore is active when viewing facility
    );
  }

  // ==================== HERO IMAGE ====================
  Widget _buildHeroImage(Map facility) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
          child: Image.asset(
            facility['imageUrl'] as String,
            width: double.infinity,
            height: 250,
            fit: BoxFit.cover,
          ),
        ),
        // Operating Hours Badge - Complex design with grey background and gold badge inside
        Positioned(
          bottom: 16,
          left: 16,
          right: 16,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Gold badge with "Opening Hours"
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: kGold,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Opening Hours',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // Hours text
                Text(
                  facility['hours'] as String,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                // Swimming icon
                const Icon(
                  Icons.pool,
                  color: Colors.white,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ==================== DESCRIPTION CARD ====================
  Widget _buildDescriptionCard(Map facility) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        facility['description'] as String,
        style: const TextStyle(
          fontSize: 13,
          color: kGray,
          height: 1.6,
        ),
      ),
    );
  }

  // ==================== GUIDELINES CARD ====================
  Widget _buildGuidelinesCard(Map facility, BuildContext context) {
    final guidelines = facility['guidelines'] as List<Map<String, String>>?;
    if (guidelines == null || guidelines.isEmpty) return const SizedBox.shrink();

    String sectionTitle;
    if (facility['type'] == 'pool') {
      sectionTitle = 'Pool Safety & Usage Guidelines';
    } else if (facility['type'] == 'gym') {
      sectionTitle = 'Gym Safety & Usage Guidelines';
    } else if (facility['type'] == 'spa') {
      sectionTitle = 'Spa Guidelines & Etiquette';
    } else {
      sectionTitle = 'Guidelines';
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            sectionTitle,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: kCharcoal,
            ),
          ),
          const SizedBox(height: 16),
          ...guidelines.map<Widget>((rule) {
            // Map emoji to Material icons
            IconData iconData = Icons.info;
            if (rule['icon'] == '👶') iconData = Icons.child_care;
            else if (rule['icon'] == '📏') iconData = Icons.straighten;
            else if (rule['icon'] == '🚿') iconData = Icons.shower;
            else if (rule['icon'] == '👨‍👩‍👧') iconData = Icons.family_restroom;
            else if (rule['icon'] == '🏊') iconData = Icons.pool;
            else if (rule['icon'] == '🏋️') iconData = Icons.fitness_center;
            else if (rule['icon'] == '🍺') iconData = Icons.local_drink;
            else if (rule['icon'] == '🧘') iconData = Icons.self_improvement;
            else if (rule['icon'] == '⏰') iconData = Icons.access_time;
            else if (rule['icon'] == '🔇') iconData = Icons.volume_off;
            else if (rule['icon'] == '📱') iconData = Icons.phone_android;
            else if (rule['icon'] == '👕') iconData = Icons.checkroom;
            else if (rule['icon'] == '💆') iconData = Icons.spa;
            else if (rule['icon'] == '🌿') iconData = Icons.eco;

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Circular gold badge with icon
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: kGold,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      iconData,
                      size: 18,
                      color: kCharcoal,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      rule['text'] ?? '',
                      style: const TextStyle(
                        fontSize: 12,
                        color: kCharcoal,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  // ==================== GALLERY SECTION ====================
  Widget _buildGallerySection(Map facility) {
    final gallery = facility['gallery'] as List<String>?;
    if (gallery == null || gallery.isEmpty) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Gallery',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: kCharcoal,
            ),
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 1.33, // 160/120
            ),
            itemCount: gallery.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  // TODO: Show fullscreen image viewer
                  debugPrint('Gallery image tapped: ${gallery[index]}');
                },
                borderRadius: BorderRadius.circular(12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    gallery[index],
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // ==================== ETIQUETTE CARD ====================
  Widget _buildEtiquetteCard(Map facility) {
    final etiquette = facility['etiquette'] as List<Map<String, String>>?;
    if (etiquette == null || etiquette.isEmpty) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Fitness Etiquette & Wellness Notes',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: kCharcoal,
            ),
          ),
          const SizedBox(height: 16),
          ...etiquette.map<Widget>((note) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    note['icon'] ?? '',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      note['text'] ?? '',
                      style: const TextStyle(
                        fontSize: 12,
                        color: kCharcoal,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  // ==================== MENU CARD ====================
  Widget _buildMenuCard(Map facility) {
    final menu = facility['menu'] as Map<String, List<Map<String, dynamic>>>?;
    if (menu == null || menu.isEmpty) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Menu',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: kCharcoal,
            ),
          ),
          const SizedBox(height: 16),
          ...menu.entries.map((category) {
            if (category.value.isEmpty) return const SizedBox.shrink();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.key,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: kGray,
                  ),
                ),
                const SizedBox(height: 8),
                ...category.value.map((item) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            item['name'] as String,
                            style: const TextStyle(
                              fontSize: 13,
                              color: kCharcoal,
                            ),
                          ),
                        ),
                        Text(
                          'Rs. ${item['price'].toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: kCharcoal,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                const SizedBox(height: 16),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }

}

