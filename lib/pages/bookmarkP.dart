import 'package:flutter/material.dart';
import 'homeP.dart';
import 'activityDetailP.dart';
import 'spaServiceDetailP.dart';
import 'roomsearchP.dart';
import '../core/widgets/bottom_nav_bar.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key});

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  static const Color kGold = Color(0xFFC9A633);
  static const Color kBg = Color(0xFFF9F8F3);
  static const Color kCharcoal = Color(0xFF2C3E3F);
  static const Color kGray = Color(0xFF7A8A8D);

  // Mock bookmarked items (in real app, fetch from Firestore or local storage)
  Map<String, List<Map<String, dynamic>>> bookmarkedItems = {
    'rooms': [
      {
        'id': 'room-001',
        'name': 'Beach Bliss',
        'viewType': 'Ocean View',
        'size': '490 sq ft',
        'price': 66000,
        'imageUrl': 'assets/images/beach.png',
        'bookmarkedAt': DateTime.now().subtract(const Duration(days: 2)),
      },
      {
        'id': 'room-002',
        'name': 'Breeze Bliss',
        'viewType': 'Garden & Ocean View',
        'size': '560 sq ft',
        'price': 60000,
        'imageUrl': 'assets/images/breeze.png',
        'bookmarkedAt': DateTime.now().subtract(const Duration(days: 5)),
      },
    ],
    'spa': [
      {
        'id': 'spa-001',
        'name': 'Signature Ayurvedic Massage',
        'category': 'Massages',
        'duration': 60,
        'rating': 4.9,
        'reviews': 28,
        'price': 25500,
        'imageUrl': 'assets/images/ayurvedic.png',
        'bookmarkedAt': DateTime.now().subtract(const Duration(days: 1)),
      },
    ],
    'dining': [
      {
        'id': 'rest-001',
        'name': 'Sunset Terrace',
        'cuisine': 'Sri Lankan & International',
        'hours': '7:00 AM - 10:00 PM',
        'priceRange': 'LKR 2000-5000',
        'imageUrl': 'assets/images/room.png',
        'bookmarkedAt': DateTime.now().subtract(const Duration(days: 3)),
      },
    ],
    'activities': [
      {
        'id': 'act-001',
        'name': 'Snorkeling Adventure',
        'duration': '2 hours',
        'difficulty': 'Beginner',
        'price': 3500,
        'imageUrl': 'assets/images/beach.png',
        'bookmarkedAt': DateTime.now().subtract(const Duration(days: 7)),
      },
    ],
  };

  bool get hasAnyBookmarks {
    return bookmarkedItems.values.any((list) => list.isNotEmpty);
  }

  void _removeBookmark(String category, String itemId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove Bookmark?'),
        content: const Text('Are you sure you want to remove this item from your bookmarks?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                bookmarkedItems[category]!.removeWhere((item) => item['id'] == itemId);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Removed from bookmarks'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: const Text('Remove', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _clearAllBookmarks() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Bookmarks?'),
        content: const Text('This will remove all your saved items.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                bookmarkedItems = {
                  'rooms': [],
                  'spa': [],
                  'dining': [],
                  'activities': [],
                };
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('All bookmarks cleared'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: const Text('Clear All', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      appBar: AppBar(
        title: const Text(
          'Bookmarks',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: kCharcoal,
          ),
        ),
        backgroundColor: kGold,
        elevation: 0,
        actions: [
          if (hasAnyBookmarks)
            TextButton(
              onPressed: _clearAllBookmarks,
              child: const Text(
                'Clear All',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
      body: hasAnyBookmarks
          ? SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Rooms Section
                  if (bookmarkedItems['rooms']!.isNotEmpty)
                    _buildSection(
                      context,
                      'Rooms',
                      bookmarkedItems['rooms']!,
                      'rooms',
                    ),

                  // Spa Section
                  if (bookmarkedItems['spa']!.isNotEmpty)
                    _buildSection(
                      context,
                      'Spa & Wellness',
                      bookmarkedItems['spa']!,
                      'spa',
                    ),

                  // Dining Section
                  if (bookmarkedItems['dining']!.isNotEmpty)
                    _buildSection(
                      context,
                      'Dining',
                      bookmarkedItems['dining']!,
                      'dining',
                    ),

                  // Activities Section
                  if (bookmarkedItems['activities']!.isNotEmpty)
                    _buildSection(
                      context,
                      'Activities',
                      bookmarkedItems['activities']!,
                      'activities',
                    ),

                  const SizedBox(height: 24),
                ],
              ),
            )
          : _buildEmptyState(context),
      bottomNavigationBar: const BottomNavBar(activeIndex: 2),
    );
  }

  // ==================== SECTION BUILDER ====================
  Widget _buildSection(
    BuildContext context,
    String title,
    List<Map<String, dynamic>> items,
    String category,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: kCharcoal,
            ),
          ),
        ),
        ...items.map((item) => _buildBookmarkCard(context, item, category)).toList(),
        const SizedBox(height: 16),
      ],
    );
  }

  // ==================== BOOKMARK CARD ====================
  Widget _buildBookmarkCard(
    BuildContext context,
    Map<String, dynamic> item,
    String category,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
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
      child: InkWell(
        onTap: () {
          // Navigate to detail page based on category
          if (category == 'rooms') {
            // Navigate to room search page where user can find and book the room
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const RoomSearchPage(),
              ),
            );
            // Show a message to help user find the bookmarked room
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Search for "${item['name']}" to view details'),
                duration: const Duration(seconds: 3),
              ),
            );
          } else if (category == 'spa') {
            // Map bookmark spa service IDs to spa service detail page IDs
            final serviceIdMap = {
              'spa-001': 'signature-ayurvedic',
              'spa-002': 'ocean-breeze-facial',
              'spa-003': 'coconut-body-scrub',
            };
            final serviceId = serviceIdMap[item['id']] ?? 'signature-ayurvedic';
            
            // Navigate to spa service detail page
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SpaServiceDetailPage(serviceId: serviceId),
              ),
            );
          } else if (category == 'dining') {
            // Dining detail page doesn't exist yet, show message
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Dining detail page coming soon!'),
                duration: Duration(seconds: 2),
              ),
            );
          } else if (category == 'activities') {
            // Map bookmark activity IDs to activity detail page IDs
            final activityIdMap = {
              'act-001': 'snorkeling',
              'act-002': 'cultural-tour',
              'act-003': 'whale-watching',
              'act-004': 'sunset-bbq',
            };
            final activityId = activityIdMap[item['id']] ?? 'snorkeling';
            
            // Navigate to activity detail page
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ActivityDetailPage(activityId: activityId),
              ),
            );
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  item['imageUrl'] as String,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['name'] as String,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: kCharcoal,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    // Category-specific info
                    if (category == 'rooms')
                      Text(
                        '${item['viewType']} | ${item['size']}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: kGray,
                        ),
                      )
                    else if (category == 'spa')
                      Row(
                        children: [
                          Text(
                            '${item['category']} | ${item['duration']} min',
                            style: const TextStyle(
                              fontSize: 12,
                              color: kGray,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Row(
                            children: [
                              const Icon(Icons.star, size: 12, color: kGold),
                              const SizedBox(width: 2),
                              Text(
                                '${item['rating']} (${item['reviews']} reviews)',
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: kGray,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    else if (category == 'dining')
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['cuisine'] as String,
                            style: const TextStyle(
                              fontSize: 12,
                              color: kGray,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.access_time, size: 11, color: kGray),
                              const SizedBox(width: 4),
                              Text(
                                item['hours'] as String,
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: kGray,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    else if (category == 'activities')
                      Text(
                        '${item['duration']} | ${item['difficulty']}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: kGray,
                        ),
                      ),
                    const SizedBox(height: 8),
                    // Price
                    Text(
                      category == 'rooms'
                          ? 'From LKR ${item['price']}/night'
                          : category == 'dining'
                              ? item['priceRange'] as String
                              : 'LKR ${item['price']}',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: kGold,
                      ),
                    ),
                  ],
                ),
              ),
              // Bookmark icon
              IconButton(
                icon: const Icon(Icons.favorite, color: Colors.red, size: 24),
                onPressed: () => _removeBookmark(category, item['id'] as String),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==================== EMPTY STATE ====================
  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.favorite_border,
              size: 80,
              color: Color(0xFFE0E0E0),
            ),
            const SizedBox(height: 24),
            const Text(
              'No Bookmarks Yet',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: kCharcoal,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Save your favorite rooms, spa services,\nand dining options here',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: kGray,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const HomePage(
                      displayName: 'User',
                      isGuest: false,
                      initialTabIndex: 1, // Navigate to Explore tab
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kGold,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Start Exploring',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}

