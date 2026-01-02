import 'package:flutter/material.dart';
import '../core/widgets/bottom_nav_bar.dart';
import 'roomsearchP.dart';
import 'spawellP.dart';
import 'allActivitiesP.dart';

class BookingDetailPage extends StatelessWidget {
  final String bookingId;

  const BookingDetailPage({
    super.key,
    required this.bookingId,
  });

  static const Color kGold = Color(0xFFC9A633);
  static const Color kBg = Color(0xFFF9F8F3);
  static const Color kCharcoal = Color(0xFF2C3E3F);
  static const Color kGray = Color(0xFF7A8A8D);

  // Mock booking data
  static final Map<String, Map<String, dynamic>> bookingData = {
    'UPV-12345': {
      'id': 'UPV-12345',
      'type': 'room',
      'status': 'confirmed',
      'referenceNumber': 'UPV-12345',
      'bookingDate': DateTime(2026, 1, 10),
      'serviceName': 'Beach Bliss',
      'serviceImage': 'assets/images/beach.png', // Room image
      'checkIn': DateTime(2026, 1, 15),
      'checkOut': DateTime(2026, 1, 17),
      'nights': 2,
      'guests': 2,
      'location': 'Uppuveli, Trincomalee',
      'guestName': 'John Doe',
      'guestEmail': 'john.doe@example.com',
      'guestPhone': '+94 77 123 4567',
      'basePrice': 132000.0,
      'serviceFee': 6600.0,
      'tax': 6930.0,
      'totalPaid': 145530.0,
      'specialRequests': 'Late check-in requested',
    },
    'UPV-12346': {
      'id': 'UPV-12346',
      'type': 'spa',
      'status': 'confirmed',
      'referenceNumber': 'UPV-12346',
      'bookingDate': DateTime(2026, 1, 12),
      'serviceName': 'Signature Ayurvedic Massage',
      'serviceImage': 'assets/images/Facilities/threndalBlissSpa.jpg',
      'date': DateTime(2026, 1, 18),
      'time': '3:00 PM',
      'duration': '60 min',
      'location': 'Thendral Bliss Spa',
      'guestName': 'John Doe',
      'guestEmail': 'john.doe@example.com',
      'guestPhone': '+94 77 123 4567',
      'basePrice': 8500.0,
      'serviceFee': 425.0,
      'tax': 446.25,
      'totalPaid': 9371.25,
      'specialRequests': 'Prefer female therapist',
    },
    'UPV-12347': {
      'id': 'UPV-12347',
      'type': 'activity',
      'status': 'pending',
      'referenceNumber': 'UPV-12347',
      'bookingDate': DateTime(2026, 1, 14),
      'serviceName': 'Snorkeling at Pigeon Island',
      'serviceImage': 'assets/images/beach.png', // Activity image
      'date': DateTime(2026, 1, 20),
      'time': '10:00 AM',
      'duration': '2 hours',
      'guests': 2,
      'location': 'Pigeon Island National Park',
      'guestName': 'John Doe',
      'guestEmail': 'john.doe@example.com',
      'guestPhone': '+94 77 123 4567',
      'basePrice': 7000.0,
      'serviceFee': 350.0,
      'tax': 367.5,
      'totalPaid': 7717.5,
      'specialRequests': 'Need snorkeling equipment',
    },
    'UPV-12340': {
      'id': 'UPV-12340',
      'type': 'room',
      'status': 'completed',
      'referenceNumber': 'UPV-12340',
      'bookingDate': DateTime(2025, 12, 15),
      'serviceName': 'Breeze Bliss',
      'serviceImage': 'assets/images/breeze.png',
      'checkIn': DateTime(2025, 12, 20),
      'checkOut': DateTime(2025, 12, 22),
      'nights': 2,
      'guests': 3,
      'location': 'Uppuveli, Trincomalee',
      'guestName': 'John Doe',
      'guestEmail': 'john.doe@example.com',
      'guestPhone': '+94 77 123 4567',
      'basePrice': 120000.0,
      'serviceFee': 6000.0,
      'tax': 6300.0,
      'totalPaid': 132300.0,
      'specialRequests': null,
    },
    'UPV-12338': {
      'id': 'UPV-12338',
      'type': 'activity',
      'status': 'cancelled',
      'referenceNumber': 'UPV-12338',
      'bookingDate': DateTime(2025, 12, 10),
      'serviceName': 'Cultural Tour – Koneswaram Temple',
      'serviceImage': 'assets/images/garden.png',
      'date': DateTime(2025, 12, 15),
      'time': '9:00 AM',
      'duration': '3 hours',
      'guests': 1,
      'location': 'Koneswaram Temple',
      'guestName': 'John Doe',
      'guestEmail': 'john.doe@example.com',
      'guestPhone': '+94 77 123 4567',
      'basePrice': 5000.0,
      'serviceFee': 250.0,
      'tax': 262.5,
      'totalPaid': 5512.5,
      'specialRequests': null,
    },
  };

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

  @override
  Widget build(BuildContext context) {
    final booking = bookingData[bookingId] ?? bookingData['UPV-12345']!;
    final statusConfig = _getStatusConfig(booking['status'] as String);

    return Scaffold(
      backgroundColor: kBg,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Booking Details',
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
            // Booking Status Card
            _buildStatusCard(booking, statusConfig),
            const SizedBox(height: 12),

            // Service Details Card
            _buildServiceDetailsCard(booking),
            const SizedBox(height: 12),

            // Guest Information Card
            _buildGuestInfoCard(booking),
            const SizedBox(height: 12),

            // Price Breakdown Card
            _buildPriceBreakdownCard(booking),
            const SizedBox(height: 12),

            // Action Buttons
            _buildActionButtons(context, booking),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(activeIndex: 3), // Profile is active
    );
  }

  // ==================== STATUS CARD ====================
  Widget _buildStatusCard(Map<String, dynamic> booking, Map<String, dynamic> statusConfig) {
    final referenceNumber = booking['referenceNumber'] as String? ?? 'N/A';
    final bookingDate = booking['bookingDate'] as DateTime? ?? DateTime.now();

    return Container(
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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: statusConfig['color'] as Color,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      statusConfig['icon'] as IconData,
                      size: 14,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      statusConfig['label'] as String,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'Ref: $referenceNumber',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: kCharcoal,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.calendar_today, size: 16, color: kGray),
              const SizedBox(width: 6),
              Text(
                'Booked on ${_formatDate(bookingDate)}',
                style: const TextStyle(fontSize: 13, color: kGray),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ==================== SERVICE DETAILS CARD ====================
  Widget _buildServiceDetailsCard(Map<String, dynamic> booking) {
    final serviceName = booking['serviceName'] as String? ?? 'Service';
    final serviceImage = booking['serviceImage'] as String? ?? 'assets/images/beach.png';
    final bookingType = booking['type'] as String? ?? 'room';

    return Container(
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
            'Service Details',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: kCharcoal,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  serviceImage,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 80,
                      height: 80,
                      color: Colors.grey[300],
                      child: const Icon(Icons.image, color: Colors.grey),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      serviceName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: kCharcoal,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (bookingType == 'room') ...[
                      Row(
                        children: [
                          const Icon(Icons.calendar_today, size: 14, color: kGray),
                          const SizedBox(width: 4),
                          Text(
                            '${_formatDate(booking['checkIn'] as DateTime)} - ${_formatDate(booking['checkOut'] as DateTime)}',
                            style: const TextStyle(fontSize: 12, color: kGray),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${booking['nights']} night${(booking['nights'] as int? ?? 1) > 1 ? 's' : ''} • ${booking['guests']} guest${(booking['guests'] as int? ?? 1) > 1 ? 's' : ''}',
                        style: const TextStyle(fontSize: 12, color: kGray),
                      ),
                    ] else if (bookingType == 'spa') ...[
                      Row(
                        children: [
                          const Icon(Icons.calendar_today, size: 14, color: kGray),
                          const SizedBox(width: 4),
                          Text(
                            _formatDate(booking['date'] as DateTime? ?? DateTime.now()),
                            style: const TextStyle(fontSize: 12, color: kGray),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.access_time, size: 14, color: kGray),
                          const SizedBox(width: 4),
                          Text(
                            '${booking['time']} • ${booking['duration']}',
                            style: const TextStyle(fontSize: 12, color: kGray),
                          ),
                        ],
                      ),
                    ] else if (bookingType == 'activity') ...[
                      Row(
                        children: [
                          const Icon(Icons.calendar_today, size: 14, color: kGray),
                          const SizedBox(width: 4),
                          Text(
                            _formatDate(booking['date'] as DateTime? ?? DateTime.now()),
                            style: const TextStyle(fontSize: 12, color: kGray),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.access_time, size: 14, color: kGray),
                          const SizedBox(width: 4),
                          Text(
                            '${booking['time']} • ${booking['duration']} • ${booking['guests']} guest${(booking['guests'] as int? ?? 1) > 1 ? 's' : ''}',
                            style: const TextStyle(fontSize: 12, color: kGray),
                          ),
                        ],
                      ),
                    ],
                    if (booking['location'] != null) ...[
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.location_on, size: 14, color: kGray),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              booking['location'] as String,
                              style: const TextStyle(fontSize: 12, color: kGray),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ==================== GUEST INFORMATION CARD ====================
  Widget _buildGuestInfoCard(Map<String, dynamic> booking) {
    final guestName = booking['guestName'] as String? ?? 'N/A';
    final guestEmail = booking['guestEmail'] as String? ?? 'N/A';
    final guestPhone = booking['guestPhone'] as String? ?? 'N/A';
    final specialRequests = booking['specialRequests'] as String?;

    return Container(
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
            'Guest Information',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: kCharcoal,
            ),
          ),
          const SizedBox(height: 12),
          _buildInfoRow(Icons.person, 'Name', guestName),
          const SizedBox(height: 8),
          _buildInfoRow(Icons.email, 'Email', guestEmail),
          const SizedBox(height: 8),
          _buildInfoRow(Icons.phone, 'Phone', guestPhone),
          if (specialRequests != null && specialRequests.isNotEmpty) ...[
            const SizedBox(height: 12),
            const Divider(color: Color(0xFFE0E0E0)),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.note, size: 16, color: kGray),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Special Requests',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: kGray,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        specialRequests,
                        style: const TextStyle(fontSize: 13, color: kCharcoal),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 16, color: kGray),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: const TextStyle(fontSize: 12, color: kGray),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: kCharcoal),
          ),
        ),
      ],
    );
  }

  // ==================== PRICE BREAKDOWN CARD ====================
  Widget _buildPriceBreakdownCard(Map<String, dynamic> booking) {
    final basePrice = (booking['basePrice'] as num?)?.toDouble() ?? 0.0;
    final serviceFee = (booking['serviceFee'] as num?)?.toDouble() ?? 0.0;
    final tax = (booking['tax'] as num?)?.toDouble() ?? 0.0;
    final totalPaid = (booking['totalPaid'] as num?)?.toDouble() ?? 0.0;

    return Container(
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
            'Price Breakdown',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: kCharcoal,
            ),
          ),
          const SizedBox(height: 12),
          _buildPriceRow('Base Price', basePrice),
          const SizedBox(height: 8),
          _buildPriceRow('Service Fee', serviceFee),
          const SizedBox(height: 8),
          _buildPriceRow('Tax', tax),
          const SizedBox(height: 12),
          const Divider(color: Color(0xFFE0E0E0)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total Paid',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: kCharcoal,
                ),
              ),
              Text(
                'LKR ${totalPaid.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 18,
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

  Widget _buildPriceRow(String label, double amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 13, color: kGray),
        ),
        Text(
          'LKR ${amount.toStringAsFixed(0)}',
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: kCharcoal),
        ),
      ],
    );
  }

  // ==================== ACTION BUTTONS ====================
  Widget _buildActionButtons(BuildContext context, Map<String, dynamic> booking) {
    final status = booking['status'] as String? ?? 'confirmed';
    final bookingType = booking['type'] as String? ?? 'room';

    if (status == 'upcoming' || status == 'confirmed' || status == 'pending') {
      return Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                debugPrint('Modify booking tapped');
                // TODO: Navigate to booking edit page
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Modify booking feature coming soon!'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: kGold),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text(
                'Modify Booking',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: kGold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                _showCancelDialog(context, booking);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text(
                'Cancel Booking',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      );
    } else if (status == 'completed') {
      return Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                _navigateToBookAgain(context, booking, bookingType);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kGold,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text(
                'Book Again',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                debugPrint('Leave review tapped');
                // TODO: Navigate to review page
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Review feature coming soon!'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: kGold),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text(
                'Leave Review',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: kGold,
                ),
              ),
            ),
          ),
        ],
      );
    } else if (status == 'cancelled') {
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            _navigateToBookAgain(context, booking, bookingType);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: kGold,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
          child: const Text(
            'Book Again',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }

  void _showCancelDialog(BuildContext context, Map<String, dynamic> booking) {
    final serviceName = booking['serviceName'] as String? ?? 'booking';
    final referenceNumber = booking['referenceNumber'] as String? ?? 'N/A';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Booking?'),
        content: Text(
          'Are you sure you want to cancel "${serviceName}"?\n\nRef: $referenceNumber\n\nThis action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Update booking status in backend
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Booking cancelled successfully'),
                  backgroundColor: Colors.green,
                ),
              );
              // Navigate back to bookings page
              Navigator.pop(context);
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

  void _navigateToBookAgain(BuildContext context, Map<String, dynamic> booking, String bookingType) {
    if (bookingType == 'room') {
      // Navigate to room search
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const RoomSearchPage(),
        ),
      );
    } else if (bookingType == 'spa') {
      // Navigate to spa & wellness page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SpaWellnessPage(),
        ),
      );
    } else if (bookingType == 'activity') {
      // Navigate to all activities page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AllActivitiesPage(),
        ),
      );
    }
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}


