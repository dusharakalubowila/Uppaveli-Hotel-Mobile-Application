import 'package:flutter/material.dart';
import 'bookingDetailP.dart';

class MyBookingsPage extends StatefulWidget {
  const MyBookingsPage({super.key});

  @override
  State<MyBookingsPage> createState() => _MyBookingsPageState();
}

class _MyBookingsPageState extends State<MyBookingsPage>
    with SingleTickerProviderStateMixin {
  static const Color kGold = Color(0xFFC9A633);
  static const Color kBg = Color(0xFFF9F8F3);
  static const Color kCharcoal = Color(0xFF2C3E3F);
  static const Color kGray = Color(0xFF7A8A8D);

  late TabController _tabController;

  // Mock booking data
  final List<Map<String, dynamic>> _allBookings = [
    {
      'id': 'bk-001',
      'type': 'room',
      'title': 'Beach Bliss',
      'date': 'Jan 15-17, 2026',
      'time': 'Check-in: 2:00 PM',
      'reference': 'UPV-12345',
      'status': 'confirmed',
      'price': 132000.0,
      'icon': Icons.hotel,
      'iconColor': kGold,
    },
    {
      'id': 'bk-002',
      'type': 'spa',
      'title': 'Signature Ayurvedic Massage',
      'date': 'Jan 18, 2026',
      'time': '3:00 PM',
      'reference': 'UPV-12346',
      'status': 'confirmed',
      'price': 8500.0,
      'icon': Icons.spa,
      'iconColor': const Color(0xFFE76F51),
    },
    {
      'id': 'bk-003',
      'type': 'activity',
      'title': 'Snorkeling at Pigeon Island',
      'date': 'Jan 20, 2026',
      'time': '10:00 AM',
      'reference': 'UPV-12347',
      'status': 'pending',
      'price': 7000.0,
      'icon': Icons.water,
      'iconColor': const Color(0xFF00BCD4),
    },
    {
      'id': 'bk-004',
      'type': 'room',
      'title': 'Breeze Bliss',
      'date': 'Dec 20-22, 2025',
      'time': 'Check-in: 2:00 PM',
      'reference': 'UPV-12340',
      'status': 'completed',
      'price': 120000.0,
      'icon': Icons.hotel,
      'iconColor': kGold,
    },
    {
      'id': 'bk-005',
      'type': 'spa',
      'title': 'Ocean Breeze Facial',
      'date': 'Dec 18, 2025',
      'time': '2:00 PM',
      'reference': 'UPV-12339',
      'status': 'completed',
      'price': 9500.0,
      'icon': Icons.spa,
      'iconColor': const Color(0xFFE76F51),
    },
    {
      'id': 'bk-006',
      'type': 'activity',
      'title': 'Cultural Tour – Koneswaram Temple',
      'date': 'Dec 15, 2025',
      'time': '9:00 AM',
      'reference': 'UPV-12338',
      'status': 'cancelled',
      'price': 5000.0,
      'icon': Icons.tour,
      'iconColor': const Color(0xFF00BCD4),
    },
  ];

  List<Map<String, dynamic>> get _upcomingBookings {
    return _allBookings.where((booking) {
      final status = booking['status'] as String;
      return status == 'confirmed' || status == 'pending';
    }).toList();
  }

  List<Map<String, dynamic>> get _pastBookings {
    return _allBookings.where((booking) {
      final status = booking['status'] as String;
      return status == 'completed';
    }).toList();
  }

  List<Map<String, dynamic>> get _cancelledBookings {
    return _allBookings.where((booking) {
      return booking['status'] == 'cancelled';
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  static Future<void> _refreshBookings() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
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
          'My Bookings',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
        ),
        backgroundColor: kGold,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: 'Upcoming'),
            Tab(text: 'Past'),
            Tab(text: 'Cancelled'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildBookingsList(_upcomingBookings, 'upcoming'),
          _buildBookingsList(_pastBookings, 'past'),
          _buildBookingsList(_cancelledBookings, 'cancelled'),
        ],
      ),
    );
  }

  Widget _buildBookingsList(List<Map<String, dynamic>> bookings, String tabType) {
    if (bookings.isEmpty) {
      return _buildEmptyState(tabType);
    }

    return RefreshIndicator(
      onRefresh: _refreshBookings,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: bookings.length,
        itemBuilder: (context, index) => _buildBookingCard(bookings[index], tabType),
      ),
    );
  }

  Widget _buildBookingCard(Map<String, dynamic> booking, String tabType) {
    final status = booking['status'] as String;
    final statusConfig = _getStatusConfig(status);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
          // Header Row
          Row(
            children: [
              // Icon
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: (booking['iconColor'] as Color).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  booking['icon'] as IconData,
                  color: booking['iconColor'] as Color,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              // Title and Type
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getBookingTypeLabel(booking['type'] as String),
                      style: const TextStyle(
                        fontSize: 11,
                        color: kGray,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      booking['title'] as String,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: kCharcoal,
                      ),
                    ),
                  ],
                ),
              ),
              // Status Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: statusConfig['color'] as Color,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      statusConfig['icon'] as IconData,
                      size: 12,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      statusConfig['label'] as String,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Date & Time
          Row(
            children: [
              const Icon(Icons.calendar_today, size: 16, color: kGray),
              const SizedBox(width: 6),
              Text(
                booking['date'] as String,
                style: const TextStyle(fontSize: 13, color: kCharcoal),
              ),
              const SizedBox(width: 16),
              const Icon(Icons.access_time, size: 16, color: kGray),
              const SizedBox(width: 6),
              Text(
                booking['time'] as String,
                style: const TextStyle(fontSize: 13, color: kCharcoal),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Reference Number
          Row(
            children: [
              const Text(
                'Ref: ',
                style: TextStyle(fontSize: 12, color: kGray),
              ),
              Text(
                booking['reference'] as String,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: kCharcoal,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(color: Color(0xFFE0E0E0)),
          const SizedBox(height: 12),
          // Price and Actions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Total Paid',
                    style: TextStyle(fontSize: 11, color: kGray),
                  ),
                  Text(
                    'LKR ${(booking['price'] as num).toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: kGold,
                    ),
                  ),
                ],
              ),
              // Action Buttons
              Row(
                children: [
                  OutlinedButton(
                    onPressed: () {
                      // Navigate to booking detail page using reference number
                      final referenceNumber = booking['reference'] as String? ?? 'UPV-12345';
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookingDetailPage(
                            bookingId: referenceNumber,
                          ),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: kGold),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                    child: const Text(
                      'View Details',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: kGold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (tabType == 'upcoming')
                    ElevatedButton(
                      onPressed: () {
                        _showCancelDialog(booking);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  else
                    ElevatedButton(
                      onPressed: () {
                        debugPrint('Book Again: ${booking['id']}');
                        // TODO: Navigate to booking page
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kGold,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                      child: const Text(
                        'Book Again',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(String tabType) {
    String message;
    String buttonText;
    VoidCallback? onButtonPressed;

    switch (tabType) {
      case 'upcoming':
        message = 'No upcoming bookings';
        buttonText = 'Start Booking';
        onButtonPressed = () {
          Navigator.pop(context);
          // Navigate to home or explore
        };
        break;
      case 'past':
        message = 'No past bookings';
        buttonText = 'View Upcoming';
        onButtonPressed = () {
          _tabController.animateTo(0);
        };
        break;
      case 'cancelled':
        message = 'No cancelled bookings';
        buttonText = 'Start Booking';
        onButtonPressed = () {
          Navigator.pop(context);
        };
        break;
      default:
        message = 'No bookings';
        buttonText = 'Start Booking';
        onButtonPressed = null;
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.calendar_today_outlined,
              size: 80,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 24),
            Text(
              message,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: kCharcoal,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Your bookings will appear here',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: kGray,
              ),
            ),
            if (onButtonPressed != null) ...[
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: onButtonPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: kGold,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  buttonText,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Map<String, dynamic> _getStatusConfig(String status) {
    switch (status) {
      case 'confirmed':
        return {
          'label': 'Confirmed',
          'color': const Color(0xFF52B788), // Green
          'icon': Icons.check_circle,
        };
      case 'pending':
        return {
          'label': 'Pending',
          'color': const Color(0xFFF4A261), // Orange
          'icon': Icons.pending,
        };
      case 'completed':
        return {
          'label': 'Completed',
          'color': const Color(0xFF52B788), // Green
          'icon': Icons.check_circle,
        };
      case 'cancelled':
        return {
          'label': 'Cancelled',
          'color': Colors.red,
          'icon': Icons.cancel,
        };
      default:
        return {
          'label': 'Unknown',
          'color': kGray,
          'icon': Icons.help_outline,
        };
    }
  }

  String _getBookingTypeLabel(String type) {
    switch (type) {
      case 'room':
        return 'Room Booking';
      case 'spa':
        return 'Spa Service';
      case 'activity':
        return 'Activity';
      default:
        return 'Booking';
    }
  }

  void _showCancelDialog(Map<String, dynamic> booking) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Booking?'),
        content: Text(
          'Are you sure you want to cancel "${booking['title']}"?\n\nRef: ${booking['reference']}',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                // Update booking status to cancelled
                final index = _allBookings.indexWhere((b) => b['id'] == booking['id']);
                if (index != -1) {
                  _allBookings[index]['status'] = 'cancelled';
                }
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Booking cancelled successfully'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text(
              'Yes, Cancel',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

