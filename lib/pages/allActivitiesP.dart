import 'package:flutter/material.dart';
import 'activityDetailP.dart';

class AllActivitiesPage extends StatefulWidget {
  const AllActivitiesPage({super.key});

  @override
  State<AllActivitiesPage> createState() => _AllActivitiesPageState();
}

class _AllActivitiesPageState extends State<AllActivitiesPage> {
  static const Color kGold = Color(0xFFC9A633);
  static const Color kBg = Color(0xFFF9F8F3);
  static const Color kCharcoal = Color(0xFF2C3E3F);
  static const Color kGray = Color(0xFF7A8A8D);

  String selectedCategory = 'All';

  // Mock activity data
  static final List<Map<String, dynamic>> allActivities = [
    {
      'id': 'snorkeling',
      'name': 'Snorkeling at Pigeon Island',
      'category': 'Snorkeling',
      'categoryColor': const Color(0xFF00BCD4),
      'rating': 4.8,
      'reviews': 125,
      'duration': '2 hours',
      'difficulty': 'Beginner',
      'price': 3500,
      'priceUnit': 'per person',
      'imageUrl': 'assets/images/beach.png',
      'description': 'Explore vibrant coral reefs at Pigeon Island National Park',
    },
    {
      'id': 'cultural-tour',
      'name': 'Cultural Tour – Koneswaram Temple',
      'category': 'Cultural Tour',
      'categoryColor': const Color(0xFFE76F51),
      'rating': 4.9,
      'reviews': 87,
      'duration': '3 hours',
      'difficulty': 'Easy',
      'price': 2500,
      'priceUnit': 'per person',
      'imageUrl': 'assets/images/room.png',
      'description': 'Visit the ancient Koneswaram Temple on Swami Rock',
    },
    {
      'id': 'whale-watching',
      'name': 'Whale Watching',
      'category': 'Adventure',
      'categoryColor': const Color(0xFF1B5E6B),
      'rating': 4.7,
      'reviews': 203,
      'duration': '4 hours',
      'difficulty': 'Moderate',
      'price': 8000,
      'priceUnit': 'per person',
      'imageUrl': 'assets/images/garden.png',
      'description': 'Witness majestic blue whales in their natural habitat',
    },
    {
      'id': 'sunset-bbq',
      'name': 'Sunset Beach BBQ',
      'category': 'Dining',
      'categoryColor': const Color(0xFFC9A633),
      'rating': 4.9,
      'reviews': 156,
      'duration': '2.5 hours',
      'difficulty': 'Easy',
      'price': 5500,
      'priceUnit': 'per person',
      'imageUrl': 'assets/images/breeze.png',
      'description': 'Enjoy grilled seafood and Sri Lankan specialties on the beach',
    },
    {
      'id': 'kayaking',
      'name': 'Kayaking Adventure',
      'category': 'Adventure',
      'categoryColor': const Color(0xFF1B5E6B),
      'rating': 4.6,
      'reviews': 92,
      'duration': '2 hours',
      'difficulty': 'Moderate',
      'price': 4000,
      'priceUnit': 'per person',
      'imageUrl': 'assets/images/beach.png',
      'description': 'Paddle through calm coastal waters and mangroves',
    },
    {
      'id': 'fort-tour',
      'name': 'Trincomalee Fort Tour',
      'category': 'Cultural Tour',
      'categoryColor': const Color(0xFFE76F51),
      'rating': 4.5,
      'reviews': 64,
      'duration': '2 hours',
      'difficulty': 'Easy',
      'price': 2000,
      'priceUnit': 'per person',
      'imageUrl': 'assets/images/breeze.png',
      'description': 'Explore the historic Dutch and Portuguese fortifications',
    },
  ];

  List<Map<String, dynamic>> get filteredActivities {
    if (selectedCategory == 'All') {
      return allActivities;
    }
    return allActivities.where((act) => act['category'] == selectedCategory).toList();
  }

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
          'Popular Experiences',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: kGold,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.white),
            onPressed: () {
              debugPrint('Filter tapped');
              // TODO: Open filter modal
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Category Filter (Sticky)
          Container(
            height: 50,
            color: Colors.white,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              children: [
                _buildCategoryChip('All'),
                _buildCategoryChip('Snorkeling'),
                _buildCategoryChip('Cultural Tour'),
                _buildCategoryChip('Adventure'),
                _buildCategoryChip('Dining'),
              ],
            ),
          ),

          // Activity Cards
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredActivities.length,
              itemBuilder: (context, index) => _buildActivityCard(context, filteredActivities[index]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String category) {
    final isSelected = selectedCategory == category;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = category;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? kGold : const Color(0xFFF0F0F0),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          category,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : kCharcoal,
          ),
        ),
      ),
    );
  }

  Widget _buildActivityCard(BuildContext context, Map<String, dynamic> activity) {
    final categoryColor = activity['categoryColor'] as Color? ?? kGold;
    final category = activity['category'] as String? ?? 'Activity';
    final name = activity['name'] as String? ?? 'Activity';
    final rating = activity['rating'] as num? ?? 0.0;
    final reviews = activity['reviews'] as int? ?? 0;
    final duration = activity['duration'] as String? ?? 'N/A';
    final difficulty = activity['difficulty'] as String? ?? 'Easy';
    final price = activity['price'] as num? ?? 0;
    final priceUnit = activity['priceUnit'] as String? ?? 'per person';
    final imageUrl = activity['imageUrl'] as String? ?? 'assets/images/beach.png';
    final activityId = activity['id'] as String? ?? 'snorkeling';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ActivityDetailPage(activityId: activityId),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with badges
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: Image.asset(
                    imageUrl,
                    width: double.infinity,
                    height: 180,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: double.infinity,
                        height: 180,
                        color: Colors.grey[300],
                        child: const Icon(Icons.image, size: 50, color: Colors.grey),
                      );
                    },
                  ),
                ),
                // Dark gradient overlay
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.4),
                        ],
                      ),
                    ),
                  ),
                ),
                // Category badge
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: categoryColor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      category,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                // Duration badge
                Positioned(
                  bottom: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.access_time, color: Colors.white, size: 14),
                        const SizedBox(width: 4),
                        Text(
                          duration,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Activity name
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: kCharcoal,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 6),

                  // Meta info
                  Row(
                    children: [
                      Text(
                        '⭐ $rating',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: kCharcoal,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '($reviews)',
                        style: const TextStyle(
                          fontSize: 11,
                          color: kGray,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text('|', style: TextStyle(color: kGray)),
                      const SizedBox(width: 8),
                      Text(
                        difficulty,
                        style: const TextStyle(
                          fontSize: 12,
                          color: kGray,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Price
                  Text(
                    'From LKR $price/$priceUnit',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: kGold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

