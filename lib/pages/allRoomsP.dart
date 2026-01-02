import 'package:flutter/material.dart';

class AllRoomsPage extends StatelessWidget {
  const AllRoomsPage({super.key});

  static const Color kGold = Color(0xFFC9A633);
  static const Color kBg = Color(0xFFF9F8F3);
  static const Color kCharcoal = Color(0xFF2C3E3F);
  static const Color kGray = Color(0xFF7A8A8D);

  // Mock room data
  static final List<Map<String, dynamic>> allRooms = [
    {
      'id': 'room-001',
      'name': 'Beach Bliss',
      'slug': 'beach-bliss',
      'price': 66000,
      'priceDisplay': 'From LKR 66,000/night',
      'rating': 4.8,
      'reviews': 124,
      'imageUrl': 'assets/images/beach.png',
      'size': '490 sq ft',
      'sizeSqm': 45,
      'bedType': '1 King Bed',
      'maxGuests': 2,
      'viewType': 'Ocean View',
      'features': ['Ocean View', 'Beach Access', 'Air Conditioning', 'Free WiFi', 'Mini Bar', 'Balcony'],
      'description': 'Experience ultimate beach luxury with stunning ocean views',
      'location': 'Uppuveli, Trincomalee',
    },
    {
      'id': 'room-002',
      'name': 'Breeze Bliss',
      'slug': 'breeze-bliss',
      'price': 60000,
      'priceDisplay': 'From LKR 60,000/night',
      'rating': 4.7,
      'reviews': 98,
      'imageUrl': 'assets/images/breeze.png',
      'size': '560 sq ft',
      'sizeSqm': 52,
      'bedType': '1 King Bed',
      'maxGuests': 3,
      'viewType': 'Garden & Ocean',
      'features': ['Garden View', 'Ocean View', 'Air Conditioning', 'Free WiFi', 'Mini Bar'],
      'description': 'Spacious rooms with garden and partial ocean views',
      'location': 'Main Building',
    },
    {
      'id': 'room-003',
      'name': 'Garden Bliss',
      'slug': 'garden-bliss',
      'price': 54000,
      'priceDisplay': 'From LKR 54,000/night',
      'rating': 4.6,
      'reviews': 87,
      'imageUrl': 'assets/images/garden.png',
      'size': '560 sq ft',
      'sizeSqm': 52,
      'bedType': '2 Twin Beds',
      'maxGuests': 3,
      'viewType': 'Garden View',
      'features': ['Garden View', 'Air Conditioning', 'Free WiFi', 'Safe', 'Work Desk'],
      'description': 'Relax surrounded by lush tropical gardens',
      'location': 'Main Building',
    },
    {
      'id': 'room-004',
      'name': 'Family Suite',
      'slug': 'family-suite',
      'price': 85000,
      'priceDisplay': 'From LKR 85,000/night',
      'rating': 4.9,
      'reviews': 56,
      'imageUrl': 'assets/images/room.png',
      'size': '850 sq ft',
      'sizeSqm': 79,
      'bedType': '1 King + 2 Singles',
      'maxGuests': 5,
      'viewType': 'Ocean View',
      'features': ['Ocean View', 'Separate Living Room', 'Kitchenette', 'Air Conditioning', 'Free WiFi', '2 Bathrooms'],
      'description': 'Perfect for families with separate living spaces',
      'location': 'Beachfront',
    },
  ];

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
          'Our Rooms',
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: kGold,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  const Text(
                    'Luxury meets comfort',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'at Uppuveli Beach by DSK',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 13,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Room Cards
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: allRooms.length,
              itemBuilder: (context, index) => _buildRoomCard(context, allRooms[index]),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildRoomCard(BuildContext context, Map<String, dynamic> room) {
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
                  room['imageUrl'] as String,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: double.infinity,
                      height: 200,
                      color: Colors.grey[300],
                      child: const Icon(Icons.image, size: 50, color: Colors.grey),
                    );
                  },
                ),
              ),
              // Gradient overlay for better text visibility
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
                        Colors.black.withOpacity(0.3),
                      ],
                    ),
                  ),
                ),
              ),
              // Price badge
              Positioned(
                bottom: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.95),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    room['priceDisplay'] as String,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: kCharcoal,
                    ),
                  ),
                ),
              ),
              // Bookmark icon
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.favorite_border,
                    color: kGold,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name and Rating
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        room['name'] as String,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: kCharcoal,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Row(
                      children: [
                        Text(
                          '⭐ ${room['rating']}',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: kCharcoal,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '(${room['reviews']})',
                          style: const TextStyle(
                            fontSize: 11,
                            color: kGray,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // Quick specs
                Row(
                  children: [
                    _buildSpec('📐', room['size'] as String),
                    const SizedBox(width: 12),
                    const Text('|', style: TextStyle(color: kGray)),
                    const SizedBox(width: 12),
                    _buildSpec('🛏️', room['bedType'] as String),
                    const SizedBox(width: 12),
                    const Text('|', style: TextStyle(color: kGray)),
                    const SizedBox(width: 12),
                    _buildSpec('👥', '${room['maxGuests']} guests'),
                  ],
                ),

                const SizedBox(height: 12),

                // Features (chips)
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: (room['features'] as List<dynamic>)
                      .take(4)
                      .map<Widget>((feature) => Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF0F0F0),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              feature as String,
                              style: const TextStyle(
                                fontSize: 10,
                                color: kCharcoal,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ))
                      .toList(),
                ),

                const SizedBox(height: 14),

                // View Details Button
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: OutlinedButton(
                    onPressed: () {
                      debugPrint('View Details tapped for: ${room['name']}');
                      // TODO: Navigate to room detail page
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => RoomDetailPage(roomId: room['id']),
                      //   ),
                      // );
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: kGold, width: 1.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'View Details',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: kGold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpec(String emoji, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(emoji, style: const TextStyle(fontSize: 14)),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(
            fontSize: 11,
            color: kGray,
          ),
        ),
      ],
    );
  }
}

