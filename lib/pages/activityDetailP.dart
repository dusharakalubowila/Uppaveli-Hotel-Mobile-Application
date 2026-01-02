import 'package:flutter/material.dart';
import 'activityBookingP.dart';

class ActivityDetailPage extends StatelessWidget {
  final String activityId;

  const ActivityDetailPage({
    super.key,
    required this.activityId,
  });

  static const Color kGold = Color(0xFFC9A633);
  static const Color kBg = Color(0xFFF9F8F3);
  static const Color kCharcoal = Color(0xFF2C3E3F);
  static const Color kGray = Color(0xFF7A8A8D);

  // Mock activity data
  static final Map<String, Map<String, dynamic>> activityData = {
    'snorkeling': {
      'id': 'act-001',
      'name': 'Snorkeling at Pigeon Island',
      'category': 'Snorkeling',
      'categoryColor': const Color(0xFF00BCD4), // Teal/cyan
      'rating': 4.8,
      'reviews': 125,
      'duration': '2 hours',
      'difficulty': 'Beginner',
      'difficultyColor': const Color(0xFF52B788), // Green
      'price': 3500,
      'priceUnit': 'per person',
      'imageUrl': 'assets/images/Popular/snokeling.jpg',
      'description':
          'Discover the underwater paradise of Pigeon Island National Park, just a short boat ride from Uppuveli Beach. This pristine marine sanctuary is home to vibrant coral reefs, colorful tropical fish, and even sea turtles.\n\nOur experienced guides will take you to the best snorkeling spots, where crystal-clear waters offer visibility up to 20 meters. Whether you\'re a beginner or experienced snorkeler, you\'ll be amazed by the diversity of marine life.\n\nThe tour includes all necessary equipment, safety briefing, and guidance throughout your underwater adventure. We also provide underwater photography services to capture your memorable moments.',
      'included': [
        'Professional snorkeling guide',
        'All equipment (mask, fins, snorkel, life jacket)',
        'Boat transfer to Pigeon Island',
        'Underwater photos & videos',
        'Drinking water & light refreshments',
        'Safety briefing & instruction',
      ],
      'toBring': [
        'Swimwear (wear under clothing)',
        'Sunscreen (reef-safe)',
        'Towel',
        'Waterproof phone case (optional)',
        'Change of clothes',
      ],
      'availableTimes': ['8:00 AM', '10:00 AM', '2:00 PM', '4:00 PM'],
      'gallery': [
        'assets/images/Popular/snokeling.jpg',
        'assets/images/Popular/whale.png',
        'assets/images/Popular/cultural.png',
      ],
    },
    'cultural-tour': {
      'id': 'act-002',
      'name': 'Cultural Tour – Koneswaram Temple',
      'category': 'Cultural Tour',
      'categoryColor': const Color(0xFFE76F51), // Orange
      'rating': 4.9,
      'reviews': 87,
      'duration': '3 hours',
      'difficulty': 'Easy',
      'difficultyColor': const Color(0xFF52B788),
      'price': 2500,
      'priceUnit': 'per person',
      'imageUrl': 'assets/images/Popular/cultural.png',
      'description':
          'Experience the rich cultural heritage of Trincomalee with a guided tour of the ancient Koneswaram Temple, one of Sri Lanka\'s most sacred Hindu shrines perched dramatically on Swami Rock.\n\nBuilt over 2,000 years ago, this architectural marvel offers breathtaking views of the Indian Ocean and Trincomalee Harbor. Learn about the temple\'s fascinating history, destroyed by Portuguese colonizers and rebuilt in 1952.\n\nYour knowledgeable guide will explain the religious significance, architectural details, and local legends associated with this holy site. The tour includes visiting the sacred springs, the main shrine, and exploring the temple complex.',
      'included': [
        'Professional cultural guide',
        'Temple entrance fees',
        'Transport to/from temple',
        'Bottled water',
        'Traditional scarf for temple entry',
      ],
      'toBring': [
        'Modest clothing (shoulders & knees covered)',
        'Hat or cap for sun protection',
        'Camera (photography allowed in most areas)',
        'Comfortable walking shoes (removed at temple entrance)',
      ],
      'availableTimes': ['7:00 AM', '9:00 AM', '3:00 PM', '5:00 PM'],
      'gallery': [
        'assets/images/Popular/cultural.png',
        'assets/images/Popular/snokeling.jpg',
      ],
    },
    'whale-watching': {
      'id': 'act-003',
      'name': 'Whale Watching',
      'category': 'Adventure',
      'categoryColor': const Color(0xFF1B5E6B), // Teal
      'rating': 4.7,
      'reviews': 203,
      'duration': '4 hours',
      'difficulty': 'Moderate',
      'difficultyColor': const Color(0xFFF4A261), // Orange
      'price': 8000,
      'priceUnit': 'per person',
      'imageUrl': 'assets/images/Popular/whale.png',
      'description':
          'Embark on an unforgettable ocean adventure to witness the majestic blue whales and playful dolphins in their natural habitat off the coast of Trincomalee.\n\nTrincomalee is one of the best places in the world to see blue whales, the largest animals on Earth. The season (March-August) offers high chances of sightings. You may also encounter sperm whales, spinner dolphins, and various seabirds.\n\nOur experienced crew knows the best spots and ensures a safe, comfortable journey. The boat is equipped with life jackets, first aid, and shaded seating. Marine biologists often accompany tours to provide fascinating insights about whale behavior.',
      'included': [
        'Expert skipper & crew',
        'Life jackets & safety equipment',
        'Marine biologist guide (when available)',
        'Breakfast & refreshments on board',
        'Binoculars for whale spotting',
        'Photo opportunities',
      ],
      'toBring': [
        'Sunglasses & hat',
        'Sunscreen',
        'Light jacket (it can be cool at sea)',
        'Camera with zoom lens',
        'Motion sickness medication (if prone to seasickness)',
      ],
      'availableTimes': ['6:00 AM', '6:30 AM'],
      'gallery': [
        'assets/images/Popular/whale.png',
        'assets/images/Popular/snokeling.jpg',
      ],
    },
    'sunset-bbq': {
      'id': 'act-004',
      'name': 'Sunset Beach BBQ',
      'category': 'Dining',
      'categoryColor': const Color(0xFFC9A633), // Gold
      'rating': 4.9,
      'reviews': 156,
      'duration': '2.5 hours',
      'difficulty': 'Easy',
      'difficultyColor': const Color(0xFF52B788),
      'price': 5500,
      'priceUnit': 'per person',
      'imageUrl': 'assets/images/Popular/sunsetBeach.png',
      'description':
          'Enjoy a magical evening on Uppuveli Beach with our exclusive Sunset BBQ experience. Watch the sun dip below the horizon while savoring freshly grilled seafood and Sri Lankan specialties.\n\nOur beachfront setup features comfortable seating, ambient lighting, and live acoustic music. The menu includes grilled fish, prawns, chicken, vegetarian options, and traditional sides like coconut roti and dhal curry.\n\nThis intimate dining experience is perfect for couples, families, or small groups looking for a memorable evening by the ocean.',
      'included': [
        'Welcome drink (fruit punch or beer)',
        'BBQ buffet with seafood & meats',
        'Vegetarian options available',
        'Traditional Sri Lankan sides',
        'Dessert & coffee/tea',
        'Live acoustic music',
        'Beach bonfire',
      ],
      'toBring': [
        'Casual beach attire',
        'Light jacket (optional)',
        'Camera for sunset photos',
      ],
      'availableTimes': ['5:30 PM', '6:00 PM'],
      'gallery': [
        'assets/images/Popular/sunsetBeach.png',
        'assets/images/Popular/snokeling.jpg',
      ],
    },
  };

  @override
  Widget build(BuildContext context) {
    final activity = activityData[activityId] ?? activityData['snorkeling']!;
    final activityName = activity['name'] as String? ?? 'Activity';

    return Scaffold(
      backgroundColor: kBg,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          activityName,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Colors.black),
            onPressed: () {
              debugPrint('Share activity: ${activity['name']}');
              // TODO: Implement share functionality
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 90), // Space for bottom bar
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hero Image with Category Badge
                _buildHeroImage(activity),
                const SizedBox(height: 16),

                // Key Info Card
                _buildKeyInfoCard(activity),
                const SizedBox(height: 12),

                // Description Card
                _buildDescriptionCard(activity),
                const SizedBox(height: 12),

                // What's Included Card
                _buildIncludedCard(activity),
                const SizedBox(height: 12),

                // What to Bring Card
                _buildToBringCard(activity),
                const SizedBox(height: 12),

                // Timing & Availability Card
                _buildTimingCard(activity),
                const SizedBox(height: 12),

                // Gallery Section
                if (activity['gallery'] != null) _buildGallery(activity),

                const SizedBox(height: 24),
              ],
            ),
          ),

          // Sticky Bottom Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildBottomBar(context, activity),
          ),
        ],
      ),
    );
  }

  // ==================== HERO IMAGE ====================
  Widget _buildHeroImage(Map activity) {
    final imageUrl = activity['imageUrl'] as String? ?? 'assets/images/beach.png';
    final categoryColor = activity['categoryColor'] as Color? ?? kGold;
    final category = activity['category'] as String? ?? 'Activity';

    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
          child: Image.asset(
            imageUrl,
            width: double.infinity,
            height: 250,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: double.infinity,
                height: 250,
                color: Colors.grey[300],
                child: const Icon(Icons.image, size: 50, color: Colors.grey),
              );
            },
          ),
        ),
        // Category Badge
        Positioned(
          top: 16,
          left: 16,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: categoryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              category,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ==================== KEY INFO CARD ====================
  Widget _buildKeyInfoCard(Map activity) {
    final name = activity['name'] as String? ?? 'Activity';
    final rating = activity['rating'] as num? ?? 0.0;
    final reviews = activity['reviews'] as int? ?? 0;
    final duration = activity['duration'] as String? ?? 'N/A';
    final difficulty = activity['difficulty'] as String? ?? 'Easy';
    final difficultyColor = activity['difficultyColor'] as Color? ?? const Color(0xFF52B788);
    final price = activity['price'] as num? ?? 0;
    final priceUnit = activity['priceUnit'] as String? ?? 'per person';

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: kCharcoal,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                '⭐ $rating',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: kCharcoal,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                '($reviews reviews)',
                style: const TextStyle(
                  fontSize: 12,
                  color: kGray,
                ),
              ),
              const Spacer(),
              Text(
                duration,
                style: const TextStyle(
                  fontSize: 13,
                  color: kGray,
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: difficultyColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  difficulty,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: difficultyColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'From LKR $price/$priceUnit',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: kGold,
            ),
          ),
        ],
      ),
    );
  }

  // ==================== DESCRIPTION CARD ====================
  Widget _buildDescriptionCard(Map activity) {
    final description = activity['description'] as String? ?? 'No description available.';
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        description,
        style: const TextStyle(
          fontSize: 13,
          color: kGray,
          height: 1.6,
        ),
      ),
    );
  }

  // ==================== WHAT'S INCLUDED CARD ====================
  Widget _buildIncludedCard(Map activity) {
    final included = (activity['included'] as List<dynamic>?)?.cast<String>() ?? <String>[];
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'What\'s Included',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: kCharcoal,
            ),
          ),
          const SizedBox(height: 12),
          ...included.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: Color(0xFF52B788),
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 13,
                          color: kCharcoal,
                        ),
                      ),
                    ),
                  ],
                ),
              )).toList(),
        ],
      ),
    );
  }

  // ==================== WHAT TO BRING CARD ====================
  Widget _buildToBringCard(Map activity) {
    final toBring = (activity['toBring'] as List<dynamic>?)?.cast<String>() ?? <String>[];
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'What to Bring',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: kCharcoal,
            ),
          ),
          const SizedBox(height: 12),
          ...toBring.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '- ',
                      style: TextStyle(
                        fontSize: 18,
                        color: kGray,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 13,
                          color: kCharcoal,
                        ),
                      ),
                    ),
                  ],
                ),
              )).toList(),
        ],
      ),
    );
  }

  // ==================== TIMING & AVAILABILITY CARD ====================
  Widget _buildTimingCard(Map activity) {
    final availableTimes = (activity['availableTimes'] as List<dynamic>?)?.cast<String>() ?? <String>[];
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Available Times',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: kCharcoal,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: availableTimes.map<Widget>((time) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: kGold),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    time,
                    style: const TextStyle(
                      fontSize: 13,
                      color: kCharcoal,
                    ),
                  ),
                )).toList(),
          ),
        ],
      ),
    );
  }

  // ==================== GALLERY SECTION ====================
  Widget _buildGallery(Map activity) {
    final gallery = (activity['gallery'] as List<dynamic>?)?.cast<String>() ?? <String>[];
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
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1.3,
            ),
            itemCount: gallery.length,
            itemBuilder: (context, index) => ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                gallery[index],
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==================== STICKY BOTTOM BAR ====================
  Widget _buildBottomBar(BuildContext context, Map activity) {
    final price = activity['price'] as num? ?? 0;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'From',
                  style: TextStyle(
                    fontSize: 11,
                    color: kGray,
                  ),
                ),
                Text(
                  'LKR $price',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: kGold,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ActivityBookingPage(activityId: activityId),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kGold,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Book Now',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

