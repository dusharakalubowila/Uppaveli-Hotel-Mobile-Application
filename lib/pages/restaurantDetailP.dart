import 'package:flutter/material.dart';
import '../core/widgets/bottom_nav_bar.dart';

class RestaurantDetailPage extends StatelessWidget {
  final String restaurantId;

  const RestaurantDetailPage({
    super.key,
    required this.restaurantId,
  });

  static const Color kGold = Color(0xFFC9A633);
  static const Color kBg = Color(0xFFF9F8F3);
  static const Color kCharcoal = Color(0xFF2C3E3F);
  static const Color kGray = Color(0xFF7A8A8D);

  // Mock restaurant data
  static final Map<String, Map<String, dynamic>> restaurantData = {
    'sunset-terrace': {
      'id': 'sunset-terrace',
      'name': 'Sunset Terrace',
      'cuisine': 'Sri Lankan & International',
      'hours': '7:00 AM - 10:00 PM ( Everyday )',
      'priceRange': 'LKR 2,000 - 5,000',
      'imageUrl': 'assets/images/beach.png',
      'description':
          'Enjoy authentic Sri Lankan cuisine with international favorites at Sunset Terrace, our signature restaurant overlooking the Indian Ocean. Experience the perfect blend of traditional flavors and contemporary dining in a relaxed, elegant atmosphere.\n\nOur talented chefs prepare dishes using the freshest local ingredients, from freshly caught seafood to organic vegetables and aromatic spices. Whether you\'re craving a traditional rice and curry, a perfectly grilled steak, or a light Mediterranean salad, our diverse menu has something for every palate.\n\nThe restaurant features both indoor and outdoor seating, with the outdoor terrace offering breathtaking sunset views. Live music performances on Friday evenings create a vibrant, festive atmosphere perfect for a memorable dining experience.',
      'features': [
        'Ocean View',
        'Live Music Fridays',
        'Outdoor Seating',
        'Kids Menu Available',
        'Vegetarian Options',
        'Private Dining Area',
      ],
      'menuHighlights': <String, List<String>>{
        'Appetizers': [
          'Prawn Tempura with Sweet Chili Sauce',
          'Spring Rolls with Dipping Sauce',
          'Deviled Chicken',
          'Coconut Soup',
        ],
        'Mains': [
          'Grilled Seafood Platter',
          'Traditional Chicken Curry with Rice',
          'Pasta Alfredo',
          'Beef Steak with Peppercorn Sauce',
          'Vegetable Kottu Roti',
        ],
        'Desserts': [
          'Watalappan (Traditional Sri Lankan Pudding)',
          'Chocolate Lava Cake',
          'Fresh Fruit Platter',
          'Ice Cream Selection',
        ],
        'Drinks': [
          'Fresh Fruit Juices',
          'Cocktails & Mocktails',
          'Wine Selection',
          'Local & Imported Beers',
        ],
      },
      'gallery': [
        'assets/images/beach.png',
        'assets/images/breeze.png',
        'assets/images/garden.png',
        'assets/images/room.png',
      ],
    },
    'beach-grill': {
      'id': 'beach-grill',
      'name': 'Beach Grill',
      'cuisine': 'Seafood & BBQ',
      'hours': '12:00 PM - 11:00 PM ( Everyday )',
      'priceRange': 'LKR 3,000 - 8,000',
      'imageUrl': 'assets/images/breeze.png',
      'description':
          'Experience the ultimate beachside dining at Beach Grill, where the ocean meets the grill. Our open-air restaurant specializes in fresh seafood and premium BBQ, cooked to perfection over our custom-built grill.\n\nWatch our skilled chefs prepare your meal right before your eyes, using traditional grilling techniques enhanced with local spices and marinades. From whole grilled fish to succulent prawns, tender calamari to perfectly charred steaks, every dish is a celebration of flavor.\n\nThe casual, laid-back atmosphere makes it perfect for families, couples, or groups of friends. Dine with your feet in the sand or at our covered tables, all while enjoying the sound of waves and the cool ocean breeze.',
      'features': [
        'Beachfront Location',
        'Live Grill Station',
        'Fresh Daily Catch',
        'BBQ Specialties',
        'Outdoor Dining',
        'Sunset Views',
      ],
      'menuHighlights': <String, List<String>>{
        'Seafood': [
          'Whole Grilled Red Snapper',
          'Prawn Skewers',
          'Grilled Calamari',
          'Lobster Thermidor',
        ],
        'BBQ': [
          'Beef Ribs',
          'Chicken Wings',
          'Lamb Chops',
          'Grilled Vegetables',
        ],
        'Sides': [
          'Garlic Bread',
          'Coleslaw',
          'Grilled Corn',
          'French Fries',
        ],
        'Drinks': [
          'Tropical Cocktails',
          'Fresh Coconut Water',
          'Beer Selection',
          'Wine by the Glass',
        ],
      },
      'gallery': [
        'assets/images/breeze.png',
        'assets/images/beach.png',
        'assets/images/garden.png',
      ],
    },
  };

  @override
  Widget build(BuildContext context) {
    final restaurant = restaurantData[restaurantId] ?? restaurantData['sunset-terrace']!;

    return Scaffold(
      backgroundColor: kBg,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          restaurant['name'] as String,
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
            _buildHeroImage(restaurant),
            const SizedBox(height: 16),

            // Restaurant Info Card
            _buildInfoCard(restaurant),
            const SizedBox(height: 12),

            // Description Section
            _buildDescriptionCard(restaurant),
            const SizedBox(height: 12),

            // Special Features Card
            _buildFeaturesCard(restaurant),
            const SizedBox(height: 12),

            // Menu Highlights Card
            _buildMenuHighlightsCard(restaurant),
            const SizedBox(height: 12),

            // Gallery Section
            if (restaurant['gallery'] != null) _buildGallerySection(restaurant),

            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(activeIndex: 1), // Explore is active
    );
  }

  // ==================== HERO IMAGE ====================
  Widget _buildHeroImage(Map<String, dynamic> restaurant) {
    final imageUrl = restaurant['imageUrl'] as String? ?? 'assets/images/beach.png';
    final hours = restaurant['hours'] as String? ?? 'N/A';

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
        // Operating Hours Badge - Similar to Facility Detail page
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
                  hours,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                // Restaurant icon
                const Icon(
                  Icons.restaurant,
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

  // ==================== INFO CARD ====================
  Widget _buildInfoCard(Map<String, dynamic> restaurant) {
    final name = restaurant['name'] as String? ?? 'Restaurant';
    final cuisine = restaurant['cuisine'] as String? ?? 'International';
    final priceRange = restaurant['priceRange'] as String? ?? 'LKR 2,000 - 5,000';

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
              const Icon(Icons.restaurant_menu, size: 16, color: kGray),
              const SizedBox(width: 6),
              Text(
                cuisine,
                style: const TextStyle(
                  fontSize: 13,
                  color: kGray,
                ),
              ),
              const Spacer(),
              Text(
                priceRange,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: kGold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ==================== DESCRIPTION CARD ====================
  Widget _buildDescriptionCard(Map<String, dynamic> restaurant) {
    final description = restaurant['description'] as String? ?? 'No description available.';
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
        description,
        style: const TextStyle(
          fontSize: 13,
          color: kGray,
          height: 1.6,
        ),
      ),
    );
  }

  // ==================== FEATURES CARD ====================
  Widget _buildFeaturesCard(Map<String, dynamic> restaurant) {
    final features = (restaurant['features'] as List<dynamic>?)?.cast<String>() ?? <String>[];
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
            'Special Features',
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
            children: features.map<Widget>((feature) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: kGold.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: kGold.withOpacity(0.3)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.check_circle, size: 14, color: kGold),
                      const SizedBox(width: 6),
                      Text(
                        feature,
                        style: const TextStyle(
                          fontSize: 12,
                          color: kCharcoal,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                )).toList(),
          ),
        ],
      ),
    );
  }

  // ==================== MENU HIGHLIGHTS CARD ====================
  Widget _buildMenuHighlightsCard(Map<String, dynamic> restaurant) {
    final menuHighlights = restaurant['menuHighlights'] as Map<String, dynamic>? ?? {};
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Menu Highlights',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: kCharcoal,
                ),
              ),
              TextButton(
                onPressed: () {
                  debugPrint('View Full Menu tapped');
                  // TODO: Navigate to full menu page
                },
                child: const Text(
                  'View Full Menu →',
                  style: TextStyle(
                    fontSize: 12,
                    color: kGold,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...menuHighlights.entries.map((category) => Column(
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
                  ...(category.value as List<dynamic>).map<Widget>((item) => Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.restaurant,
                              size: 14,
                              color: kGold,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                item as String,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: kCharcoal,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )).toList(),
                  const SizedBox(height: 16),
                ],
              )).toList(),
        ],
      ),
    );
  }

  // ==================== GALLERY SECTION ====================
  Widget _buildGallerySection(Map<String, dynamic> restaurant) {
    final gallery = (restaurant['gallery'] as List<dynamic>?)?.cast<String>() ?? <String>[];
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
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.image, color: Colors.grey),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}


