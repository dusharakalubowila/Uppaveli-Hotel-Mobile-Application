import 'package:flutter/material.dart';
import 'spawellP.dart';
import 'facilityDetailP.dart';
import 'spaServiceDetailP.dart';
import 'restaurantDetailP.dart';
import 'roomServiceP.dart';
import '../core/widgets/bottom_nav_bar.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  static const Color kGold = Color(0xFFC9A633);
  static const Color kBg = Color(0xFFF9F8F3);
  static const Color kCharcoal = Color(0xFF2C3E3F);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      appBar: AppBar(
        title: const Text(
          'Explore',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: kCharcoal,
          ),
        ),
        backgroundColor: kGold,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: kCharcoal),
            onPressed: () {
              // TODO: Implement search
              debugPrint('Search tapped');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            _buildFacilitiesSection(context),
            const SizedBox(height: 24),
            _buildSpaSection(context),
            const SizedBox(height: 24),
            _buildDiningSection(context),
            const SizedBox(height: 24),
            _buildActivitiesSection(context),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(activeIndex: 1),
    );
  }

  // ==================== SECTION HEADER ====================
  Widget _sectionHeader({
    required String title,
    required VoidCallback onViewAll,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: kCharcoal,
            ),
          ),
          TextButton(
            onPressed: onViewAll,
            child: const Text(
              'View All →',
              style: TextStyle(
                fontSize: 12,
                color: kGold,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==================== RESORT FACILITIES SECTION ====================
  Widget _buildFacilitiesSection(BuildContext context) {
    final facilities = [
      {
        'id': 'fac-001',
        'name': 'Beach Front Swimming Pool',
        'hours': '7 AM - 9 PM (Everyday)',
        'imageUrl': 'assets/images/beach.png', // Using local asset
        'icon': '🏊',
      },
      {
        'id': 'fac-002',
        'name': 'GYM',
        'hours': '24 hrs (Everyday)',
        'imageUrl': 'assets/images/room.png',
        'icon': '💪',
      },
      {
        'id': 'fac-003',
        'name': 'Beach Club',
        'hours': '2 PM - 5 PM (Everyday)',
        'imageUrl': 'assets/images/breeze.png',
        'icon': '🍹',
      },
      {
        'id': 'fac-004',
        'name': 'Kids Club',
        'hours': '9 AM - 6 PM (Everyday)',
        'imageUrl': 'assets/images/garden.png',
        'icon': '🎨',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(
          title: 'Resort Facilities',
          onViewAll: () {
            debugPrint('View All Facilities');
            // TODO: Navigate to facilities list page
          },
        ),
        SizedBox(
          height: 140,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: facilities.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final facility = facilities[index];
              return _FacilityCard(facility: facility);
            },
          ),
        ),
      ],
    );
  }

  // ==================== SPA & WELLNESS SECTION ====================
  Widget _buildSpaSection(BuildContext context) {
    final spaServices = [
      {
        'id': 'spa-001',
        'name': 'Signature Ayurvedic Massage',
        'category': 'Massages',
        'duration': 60,
        'frequency': '4-5 times weekly',
        'rating': 4.9,
        'imageUrl': 'assets/images/ayurvedic.png',
      },
      {
        'id': 'spa-002',
        'name': 'Thendral Bliss Spa',
        'category': 'Wellness Packages',
        'duration': 120,
        'frequency': 'Daily',
        'rating': 4.8,
        'imageUrl': 'assets/images/wellness.png',
      },
      {
        'id': 'spa-003',
        'name': 'Deep Tissue Massage',
        'category': 'Massages',
        'duration': 90,
        'frequency': 'Daily',
        'rating': 4.7,
        'imageUrl': 'assets/images/massage.png',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(
          title: 'Spa & Wellness',
          onViewAll: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SpaWellnessPage()),
            );
          },
        ),
        SizedBox(
          height: 210,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: spaServices.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final service = spaServices[index];
              return _SpaServiceCard(service: service);
            },
          ),
        ),
      ],
    );
  }

  // ==================== DINING SECTION ====================
  Widget _buildDiningSection(BuildContext context) {
    final dining = [
      {
        'id': 'din-001',
        'name': 'Sunset Terrace',
        'cuisine': 'Sri Lankan & International',
        'hours': '7:00 AM - 10:00 PM',
        'imageUrl': 'assets/images/room.png',
      },
      {
        'id': 'din-002',
        'name': 'Beach Grill',
        'cuisine': 'Seafood & BBQ',
        'hours': '12:00 PM - 11:00 PM',
        'imageUrl': 'assets/images/beach.png',
      },
      {
        'id': 'room-service',
        'name': 'Order Room Service',
        'special': true,
        'description': 'Enjoy meals in your room',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(
          title: 'Dining',
          onViewAll: () {
            debugPrint('View All Dining');
            // TODO: Navigate to dining list page
          },
        ),
        SizedBox(
          height: 180,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: dining.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final restaurant = dining[index];
              return _DiningCard(restaurant: restaurant);
            },
          ),
        ),
      ],
    );
  }

  // ==================== ACTIVITIES SECTION ====================
  Widget _buildActivitiesSection(BuildContext context) {
    final activities = [
      {
        'id': 'act-001',
        'name': 'Snorkeling Adventure',
        'duration': '2 hours',
        'price': 3500,
        'imageUrl': 'assets/images/beach.png',
      },
      {
        'id': 'act-002',
        'name': 'Whale Watching Tour',
        'duration': '4 hours',
        'price': 8000,
        'imageUrl': 'assets/images/breeze.png',
      },
      {
        'id': 'act-003',
        'name': 'Yoga on the Beach',
        'duration': '1 hour',
        'price': 1500,
        'imageUrl': 'assets/images/garden.png',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(
          title: 'Activities',
          onViewAll: () {
            debugPrint('View All Activities');
            // TODO: Navigate to activities list page
          },
        ),
        SizedBox(
          height: 180,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: activities.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final activity = activities[index];
              return _ActivityCard(activity: activity);
            },
          ),
        ),
      ],
    );
  }
}

// ==================== FACILITY CARD ====================
class _FacilityCard extends StatelessWidget {
  const _FacilityCard({required this.facility});

  final Map<String, dynamic> facility;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => FacilityDetailPage(facilityId: facility['id'] as String),
          ),
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 200,
        height: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Image background
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                facility['imageUrl'] as String,
                fit: BoxFit.cover,
              ),
            ),
            // Dark overlay gradient
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
            // Hours badge (top-right)
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  facility['hours'] as String,
                  style: const TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            // Facility name (bottom-left)
            Positioned(
              left: 12,
              bottom: 12,
              right: 12,
              child: Text(
                facility['name'] as String,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== SPA SERVICE CARD ====================
class _SpaServiceCard extends StatelessWidget {
  const _SpaServiceCard({required this.service});

  final Map<String, dynamic> service;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Map explore page service IDs to spa service detail page IDs
        final serviceIdMap = {
          'spa-001': 'signature-ayurvedic',
          'spa-002': 'ocean-breeze-facial',
          'spa-003': 'coconut-body-scrub',
        };
        final serviceId = serviceIdMap[service['id']] ?? 'signature-ayurvedic';
        
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SpaServiceDetailPage(serviceId: serviceId),
          ),
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 160,
        height: 210,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image with category badge
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child: SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: Image.asset(
                      service['imageUrl'] as String,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Category badge (top-left)
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: ExplorePage.kGold,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      service['category'] as String,
                      style: const TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Content - Use Expanded to prevent overflow
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      service['name'] as String,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${service['duration']} min | ${service['frequency']}',
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.black54,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        const Icon(Icons.star, size: 12, color: ExplorePage.kGold),
                        const SizedBox(width: 3),
                        Text(
                          service['rating'].toString(),
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== DINING CARD ====================
class _DiningCard extends StatelessWidget {
  const _DiningCard({required this.restaurant});

  final Map<String, dynamic> restaurant;

  @override
  Widget build(BuildContext context) {
    final isSpecial = restaurant['special'] == true;

    if (isSpecial) {
      // Special Room Service card with gradient
      return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const RoomServicePage(),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 180,
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF185E6C), // Teal
              ExplorePage.kGold,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.room_service, size: 40, color: Colors.white),
                const SizedBox(height: 12),
                Text(
                  restaurant['name'] as String,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
                Text(
                  restaurant['description'] as String,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.white70,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Regular restaurant card
    return InkWell(
      onTap: () {
        // Map restaurant IDs to restaurant detail page IDs
        final restaurantIdMap = {
          'din-001': 'sunset-terrace',
          'din-002': 'beach-grill',
        };
        final detailId = restaurantIdMap[restaurant['id']] ?? 'sunset-terrace';
        
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RestaurantDetailPage(restaurantId: detailId),
          ),
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 180,
        height: 180,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: SizedBox(
                height: 100,
                width: double.infinity,
                child: Image.asset(
                  restaurant['imageUrl'] as String,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Content - Use Expanded to prevent overflow
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Cuisine tag
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: ExplorePage.kGold.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        restaurant['cuisine'] as String,
                        style: const TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                          color: ExplorePage.kGold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      restaurant['name'] as String,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        const Icon(Icons.access_time, size: 11, color: Colors.black54),
                        const SizedBox(width: 3),
                        Flexible(
                          child: Text(
                            restaurant['hours'] as String,
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.black54,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== ACTIVITY CARD ====================
class _ActivityCard extends StatelessWidget {
  const _ActivityCard({required this.activity});

  final Map<String, dynamic> activity;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        debugPrint('Activity tapped: ${activity['id']}');
        // TODO: Navigate to activity detail page
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 180,
        height: 180,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: SizedBox(
                height: 100,
                width: double.infinity,
                child: Image.asset(
                  activity['imageUrl'] as String,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Content - Use Expanded to prevent overflow
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      activity['name'] as String,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        const Icon(Icons.schedule, size: 11, color: Colors.black54),
                        const SizedBox(width: 3),
                        Text(
                          activity['duration'] as String,
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.black54,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Rs. ${activity['price']}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: ExplorePage.kGold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
