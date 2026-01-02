import 'package:flutter/material.dart';
import 'activityDetailP.dart';

class ActivityBookingPage extends StatefulWidget {
  final String activityId;

  const ActivityBookingPage({
    super.key,
    required this.activityId,
  });

  @override
  State<ActivityBookingPage> createState() => _ActivityBookingPageState();
}

class _ActivityBookingPageState extends State<ActivityBookingPage> {
  static const Color kGold = Color(0xFFC9A633);
  static const Color kBg = Color(0xFFF9F8F3);
  static const Color kCharcoal = Color(0xFF2C3E3F);
  static const Color kGray = Color(0xFF7A8A8D);

  DateTime? selectedDate;
  String? selectedTime;
  int numberOfGuests = 1;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final specialRequestsController = TextEditingController();

  late Map<String, dynamic> activityData;
  late List<String> availableTimes;

  @override
  void initState() {
    super.initState();
    // Load activity data from ActivityDetailPage
    activityData = ActivityDetailPage.activityData[widget.activityId] ??
        ActivityDetailPage.activityData['snorkeling']!;
    availableTimes = (activityData['availableTimes'] as List<dynamic>?)
            ?.cast<String>() ??
        <String>[];
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    specialRequestsController.dispose();
    super.dispose();
  }

  double get activityPrice => (activityData['price'] as num?)?.toDouble() ?? 0.0;
  double get subtotal => activityPrice * numberOfGuests;
  double get serviceFee => subtotal * 0.05; // 5% service fee
  double get tax => (subtotal + serviceFee) * 0.05; // 5% tax
  double get totalAmount => subtotal + serviceFee + tax;

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
          'Book Activity',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: kGold,
        elevation: 0,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 90),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                _buildActivitySummary(),
                const SizedBox(height: 16),
                _buildSectionHeader('Select Date'),
                _buildDatePicker(),
                const SizedBox(height: 16),
                _buildSectionHeader('Select Time'),
                _buildTimeSlots(),
                const SizedBox(height: 16),
                _buildGuestCounter(),
                const SizedBox(height: 16),
                _buildSectionHeader('Special Requests', subtitle: 'Optional'),
                _buildSpecialRequests(),
                const SizedBox(height: 16),
                _buildSectionHeader('Contact Information'),
                _buildContactForm(),
                const SizedBox(height: 16),
                _buildPriceBreakdown(),
                const SizedBox(height: 24),
              ],
            ),
          ),
          _buildBottomBar(),
        ],
      ),
    );
  }

  // ==================== ACTIVITY SUMMARY ====================
  Widget _buildActivitySummary() {
    final name = activityData['name'] as String? ?? 'Activity';
    final duration = activityData['duration'] as String? ?? 'N/A';
    final difficulty = activityData['difficulty'] as String? ?? 'Easy';
    final price = activityData['price'] as num? ?? 0;
    final priceUnit = activityData['priceUnit'] as String? ?? 'per person';
    final imageUrl = activityData['imageUrl'] as String? ?? 'assets/images/beach.png';

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
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
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              imageUrl,
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
                  name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: kCharcoal,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '$duration | $difficulty',
                  style: const TextStyle(
                    fontSize: 12,
                    color: kGray,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'LKR $price/$priceUnit',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: kGold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==================== SECTION HEADER ====================
  Widget _buildSectionHeader(String title, {String? subtitle}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: kCharcoal,
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(width: 8),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: kGray,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  // ==================== DATE PICKER ====================
  Widget _buildDatePicker() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: InkWell(
        onTap: () async {
          final date = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 90)),
            builder: (context, child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: const ColorScheme.light(
                    primary: kGold,
                    onPrimary: Colors.white,
                    onSurface: kCharcoal,
                  ),
                ),
                child: child!,
              );
            },
          );
          if (date != null) {
            setState(() {
              selectedDate = date;
            });
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedDate == null
                  ? 'Choose your preferred date'
                  : _formatDate(selectedDate!),
              style: TextStyle(
                fontSize: 14,
                color: selectedDate == null ? kGray : kCharcoal,
              ),
            ),
            const Icon(Icons.calendar_today, color: kGold, size: 20),
          ],
        ),
      ),
    );
  }

  // ==================== TIME SLOTS ====================
  Widget _buildTimeSlots() {
    if (availableTimes.isEmpty) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE0E0E0)),
        ),
        child: const Text(
          'No available time slots',
          style: TextStyle(fontSize: 13, color: kGray),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: availableTimes.map((time) {
          final isSelected = selectedTime == time;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedTime = time;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? kGold : Colors.white,
                border: Border.all(
                  color: isSelected ? kGold : const Color(0xFFE0E0E0),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                time,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : kCharcoal,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // ==================== GUEST COUNTER ====================
  Widget _buildGuestCounter() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Number of Guests',
            style: TextStyle(
              fontSize: 14,
              color: kCharcoal,
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.remove_circle_outline,
                  color: numberOfGuests > 1 ? kGold : Colors.grey[300],
                ),
                onPressed: numberOfGuests > 1
                    ? () {
                        setState(() {
                          numberOfGuests--;
                        });
                      }
                    : null,
              ),
              Container(
                width: 40,
                alignment: Alignment.center,
                child: Text(
                  '$numberOfGuests',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: kCharcoal,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.add_circle_outline,
                  color: numberOfGuests < 10 ? kGold : Colors.grey[300],
                ),
                onPressed: numberOfGuests < 10
                    ? () {
                        setState(() {
                          numberOfGuests++;
                        });
                      }
                    : null,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ==================== SPECIAL REQUESTS ====================
  Widget _buildSpecialRequests() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: TextField(
        controller: specialRequestsController,
        maxLines: 3,
        maxLength: 300,
        decoration: InputDecoration(
          hintText:
              'Any dietary restrictions, preferences, or special requirements...',
          hintStyle: const TextStyle(fontSize: 13, color: kGray),
          border: InputBorder.none,
          counterStyle: const TextStyle(fontSize: 11, color: kGray),
        ),
        style: const TextStyle(fontSize: 13, color: kCharcoal),
      ),
    );
  }

  // ==================== CONTACT FORM ====================
  Widget _buildContactForm() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          _buildTextField(
            controller: nameController,
            label: 'Full Name',
            icon: Icons.person,
            hint: 'John Doe',
          ),
          const SizedBox(height: 12),
          _buildTextField(
            controller: emailController,
            label: 'Email',
            icon: Icons.email,
            hint: 'john.doe@example.com',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 12),
          _buildTextField(
            controller: phoneController,
            label: 'Phone Number',
            icon: Icons.phone,
            hint: '+94 77 123 4567',
            keyboardType: TextInputType.phone,
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String hint,
    TextInputType? keyboardType,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          icon: Icon(icon, color: kGray, size: 20),
          labelText: label,
          labelStyle: const TextStyle(fontSize: 13, color: kGray),
          hintText: hint,
          hintStyle: const TextStyle(fontSize: 13, color: Color(0xFFCCCCCC)),
          border: InputBorder.none,
        ),
        style: const TextStyle(fontSize: 14, color: kCharcoal),
      ),
    );
  }

  // ==================== PRICE BREAKDOWN ====================
  Widget _buildPriceBreakdown() {
    return Container(
      margin: const EdgeInsets.all(16),
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
            'Price Breakdown',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: kCharcoal,
            ),
          ),
          const SizedBox(height: 16),
          _buildPriceRow(
              'Activity ($numberOfGuests ${numberOfGuests == 1 ? 'guest' : 'guests'})',
              subtotal),
          const SizedBox(height: 8),
          _buildPriceRow('Service Fee', serviceFee),
          const SizedBox(height: 8),
          _buildPriceRow('Tax (5%)', tax),
          const SizedBox(height: 12),
          const Divider(color: Color(0xFFE0E0E0)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total Amount',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: kGold,
                ),
              ),
              Text(
                'LKR ${totalAmount.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: kCharcoal,
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
          style: const TextStyle(fontSize: 13, color: kCharcoal),
        ),
      ],
    );
  }

  // ==================== BOTTOM BAR ====================
  Widget _buildBottomBar() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
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
                    'Total',
                    style: TextStyle(fontSize: 11, color: kGray),
                  ),
                  Text(
                    'LKR ${totalAmount.toStringAsFixed(0)}',
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
                  onPressed: _proceedToPayment,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kGold,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Proceed to Payment',
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
      ),
    );
  }

  // ==================== VALIDATION & NAVIGATION ====================
  void _proceedToPayment() {
    if (selectedDate == null) {
      _showError('Please select a date');
      return;
    }
    if (selectedTime == null) {
      _showError('Please select a time slot');
      return;
    }
    if (nameController.text.trim().isEmpty) {
      _showError('Please enter your name');
      return;
    }
    if (!_isValidEmail(emailController.text.trim())) {
      _showError('Please enter a valid email address');
      return;
    }
    if (phoneController.text.trim().isEmpty) {
      _showError('Please enter your phone number');
      return;
    }

    // TODO: Navigate to payment page
    debugPrint('Proceeding to payment for activity: ${activityData['name']}');
    _showSuccess('Booking details saved. Payment page coming soon!');
    
    // Uncomment when payment page is ready:
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => PaymentPage(
    //       bookingType: 'activity',
    //       bookingData: {
    //         'activityId': widget.activityId,
    //         'activityName': activityData['name'],
    //         'date': selectedDate,
    //         'time': selectedTime,
    //         'guests': numberOfGuests,
    //         'specialRequests': specialRequestsController.text,
    //         'contactName': nameController.text,
    //         'contactEmail': emailController.text,
    //         'contactPhone': phoneController.text,
    //         'totalAmount': totalAmount,
    //       },
    //     ),
    //   ),
    // );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  String _formatDate(DateTime date) {
    const weekdays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];
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

    final weekday = weekdays[date.weekday - 1];
    final month = months[date.month - 1];
    final day = date.day;
    final year = date.year;

    return '$weekday, $month $day, $year';
  }
}

