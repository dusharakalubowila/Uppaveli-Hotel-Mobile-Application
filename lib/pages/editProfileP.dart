import 'package:flutter/material.dart';
import 'changePasswordP.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  static const Color kGold = Color(0xFFC9A633);
  static const Color kBg = Color(0xFFF9F8F3);
  static const Color kCharcoal = Color(0xFF2C3E3F);
  static const Color kGray = Color(0xFF7A8A8D);

  // Form controllers
  final _firstNameController = TextEditingController(text: 'John');
  final _lastNameController = TextEditingController(text: 'Doe');
  final _emailController = TextEditingController(text: 'john.doe@example.com');
  final _phoneController = TextEditingController(text: '+94 77 123 4567');
  final _dateOfBirthController = TextEditingController(text: '1990-01-15');
  final _nationalityController = TextEditingController(text: 'Sri Lankan');
  final _languageController = TextEditingController(text: 'English');

  DateTime? _selectedDateOfBirth;
  bool _isEmailVerified = true;

  @override
  void initState() {
    super.initState();
    // Parse initial date of birth
    try {
      final parts = _dateOfBirthController.text.split('-');
      if (parts.length == 3) {
        _selectedDateOfBirth = DateTime(
          int.parse(parts[0]),
          int.parse(parts[1]),
          int.parse(parts[2]),
        );
      }
    } catch (e) {
      _selectedDateOfBirth = null;
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _dateOfBirthController.dispose();
    _nationalityController.dispose();
    _languageController.dispose();
    super.dispose();
  }

  Future<void> _selectDateOfBirth() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDateOfBirth ?? DateTime.now().subtract(const Duration(days: 365 * 25)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: kGold,
              onPrimary: Colors.white,
              onSurface: kCharcoal,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDateOfBirth) {
      setState(() {
        _selectedDateOfBirth = picked;
        _dateOfBirthController.text =
            '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
      });
    }
  }

  void _saveChanges() {
    // Validate form
    if (_firstNameController.text.trim().isEmpty) {
      _showError('Please enter your first name');
      return;
    }
    if (_lastNameController.text.trim().isEmpty) {
      _showError('Please enter your last name');
      return;
    }
    if (_phoneController.text.trim().isEmpty) {
      _showError('Please enter your phone number');
      return;
    }
    if (_dateOfBirthController.text.trim().isEmpty) {
      _showError('Please select your date of birth');
      return;
    }
    if (_nationalityController.text.trim().isEmpty) {
      _showError('Please enter your nationality');
      return;
    }

    // Save changes (in real app, update Firestore/user profile)
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile updated successfully!'),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.pop(context);
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
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
          'Edit Profile',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
        ),
        backgroundColor: kGold,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Photo Section
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[300],
                      border: Border.all(color: kGold, width: 3),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/beach.png',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.person, size: 60, color: Colors.grey);
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: kGold,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: const Icon(Icons.camera_alt, size: 20, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: TextButton(
                onPressed: () {
                  debugPrint('Change photo tapped');
                  // TODO: Implement image picker
                },
                child: const Text(
                  'Change Photo',
                  style: TextStyle(color: kGold, fontSize: 13, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Form Fields
            _buildSectionTitle('Personal Information'),
            const SizedBox(height: 12),
            _buildTextField(
              controller: _firstNameController,
              label: 'First Name',
              icon: Icons.person,
              hint: 'Enter your first name',
            ),
            const SizedBox(height: 12),
            _buildTextField(
              controller: _lastNameController,
              label: 'Last Name',
              icon: Icons.person_outline,
              hint: 'Enter your last name',
            ),
            const SizedBox(height: 12),
            _buildTextField(
              controller: _emailController,
              label: 'Email',
              icon: Icons.email,
              hint: 'Enter your email',
              readOnly: true,
              suffix: _isEmailVerified
                  ? const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.verified, size: 18, color: Colors.green),
                        SizedBox(width: 4),
                        Text(
                          'Verified',
                          style: TextStyle(fontSize: 11, color: Colors.green),
                        ),
                      ],
                    )
                  : null,
            ),
            const SizedBox(height: 12),
            _buildTextField(
              controller: _phoneController,
              label: 'Phone Number',
              icon: Icons.phone,
              hint: '+94 77 123 4567',
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 12),
            _buildDateField(),
            const SizedBox(height: 24),

            _buildSectionTitle('Additional Information'),
            const SizedBox(height: 12),
            _buildTextField(
              controller: _nationalityController,
              label: 'Nationality',
              icon: Icons.flag,
              hint: 'Enter your nationality',
            ),
            const SizedBox(height: 12),
            _buildTextField(
              controller: _languageController,
              label: 'Preferred Language',
              icon: Icons.language,
              hint: 'Select language',
              readOnly: true,
              onTap: () {
                _showLanguagePicker();
              },
            ),
            const SizedBox(height: 24),

            // Password Change Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: kGold.withOpacity(0.3)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.lock, size: 20, color: kGold),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Password',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: kCharcoal,
                            ),
                          ),
                          Text(
                            'Change your password',
                            style: TextStyle(fontSize: 12, color: kGray),
                          ),
                        ],
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChangePasswordPage(),
                        ),
                      );
                    },
                    child: const Text(
                      'Change',
                      style: TextStyle(color: kGold, fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveChanges,
                style: ElevatedButton.styleFrom(
                  backgroundColor: kGold,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Save Changes',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: kCharcoal,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String hint,
    bool readOnly = false,
    TextInputType? keyboardType,
    Widget? suffix,
    VoidCallback? onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kGold.withOpacity(0.2)),
      ),
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        keyboardType: keyboardType,
        onTap: onTap,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontSize: 13, color: kGray),
          hintText: hint,
          hintStyle: const TextStyle(fontSize: 13, color: kGray),
          prefixIcon: Icon(icon, size: 20, color: kGold),
          suffixIcon: suffix,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
        style: const TextStyle(fontSize: 14, color: kCharcoal),
      ),
    );
  }

  Widget _buildDateField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kGold.withOpacity(0.2)),
      ),
      child: InkWell(
        onTap: _selectDateOfBirth,
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: 'Date of Birth',
            labelStyle: const TextStyle(fontSize: 13, color: kGray),
            prefixIcon: const Icon(Icons.calendar_today, size: 20, color: kGold),
            suffixIcon: const Icon(Icons.arrow_drop_down, color: kGray),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
          child: Text(
            _dateOfBirthController.text.isEmpty
                ? 'Select date of birth'
                : _formatDate(_selectedDateOfBirth ?? DateTime.now()),
            style: TextStyle(
              fontSize: 14,
              color: _dateOfBirthController.text.isEmpty ? kGray : kCharcoal,
            ),
          ),
        ),
      ),
    );
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
    return '${months[date.month - 1]} ${date.day.toString().padLeft(2, '0')}, ${date.year}';
  }

  void _showLanguagePicker() {
    final languages = ['English', 'Sinhala', 'Tamil', 'French', 'German', 'Spanish'];
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Select Language',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: kCharcoal),
            ),
            const SizedBox(height: 16),
            ...languages.map((lang) => ListTile(
                  title: Text(lang),
                  onTap: () {
                    setState(() {
                      _languageController.text = lang;
                    });
                    Navigator.pop(context);
                  },
                )),
          ],
        ),
      ),
    );
  }
}

