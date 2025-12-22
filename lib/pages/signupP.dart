import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  static const Color kGold = Color(0xFFC9A633);

  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  bool _acceptTerms = false;
  bool _optInOffers = false;

  String _countryCode = '+1';

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _email.dispose();
    _phone.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F8F3),
      body: SafeArea(
        child: Column(
          children: [
            // Top gold bar
            Container(
              height: 48,
              width: double.infinity,
              color: kGold,
              alignment: Alignment.center,
              child: const Text(
                'Sign\nUp',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  height: 1.1,
                ),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
                child: Column(
                  children: [
                    const SizedBox(height: 6),

                    // Title area
                    const Text(
                      'Create\nAccount',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: kGold,
                        height: 1.15,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Join Uppuveli Beach Resort',
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),

                    const SizedBox(height: 24),

                    // Form Card
                    _buildCardForm(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardForm() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // First + Last name row
          Row(
            children: [
              Expanded(
                child: _labeledField(
                  label: 'First Name',
                  child: TextField(
                    controller: _firstName,
                    decoration: _inputDecoration('John'),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _labeledField(
                  label: 'Last Name',
                  child: TextField(
                    controller: _lastName,
                    decoration: _inputDecoration('Doe'),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Email
          _labeledField(
            label: 'Email',
            child: TextField(
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              decoration: _inputDecoration('your@email.com'),
            ),
          ),

          const SizedBox(height: 14),

          // Phone (code + number)
          const Text('Phone', style: TextStyle(fontSize: 13)),
          const SizedBox(height: 6),
          Row(
            children: [
              Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF6F6F6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _countryCode,
                    items: const [
                      DropdownMenuItem(value: '+1', child: Text('🇺🇸  +1')),
                      DropdownMenuItem(value: '+94', child: Text('🇱🇰  +94')),
                      DropdownMenuItem(value: '+91', child: Text('🇮🇳  +91')),
                      DropdownMenuItem(value: '+44', child: Text('🇬🇧  +44')),
                    ],
                    onChanged: (v) {
                      if (v == null) return;
                      setState(() => _countryCode = v);
                    },
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: TextField(
                    controller: _phone,
                    keyboardType: TextInputType.phone,
                    decoration: _inputDecoration('(555) 000-0000'),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Password
          _labeledField(
            label: 'Password',
            child: TextField(
              controller: _password,
              obscureText: _obscurePassword,
              decoration: _inputDecoration('••••••••').copyWith(
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    size: 20,
                  ),
                  onPressed: () {
                    setState(() => _obscurePassword = !_obscurePassword);
                  },
                ),
              ),
            ),
          ),

          const SizedBox(height: 14),

          // Confirm Password
          _labeledField(
            label: 'Confirm Password',
            child: TextField(
              controller: _confirmPassword,
              obscureText: _obscureConfirm,
              decoration: _inputDecoration('••••••••').copyWith(
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureConfirm ? Icons.visibility_off : Icons.visibility,
                    size: 20,
                  ),
                  onPressed: () {
                    setState(() => _obscureConfirm = !_obscureConfirm);
                  },
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Terms checkbox
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Checkbox(
                value: _acceptTerms,
                activeColor: kGold,
                onChanged: (v) => setState(() => _acceptTerms = v ?? false),
              ),
              const Text('I accept the '),
              GestureDetector(
                onTap: _onTermsTap,
                child: const Text(
                  'terms & conditions',
                  style: TextStyle(color: kGold, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),

          // Offers checkbox
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Checkbox(
                value: _optInOffers,
                activeColor: kGold,
                onChanged: (v) => setState(() => _optInOffers = v ?? false),
              ),
              const Expanded(
                child: Text(
                  'Opt-in for exclusive promotions and\noffers',
                  style: TextStyle(height: 1.2),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Create account button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kGold,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              onPressed: _onCreateAccount,
              child: const Text(
                'Create Account',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _labeledField({required String label, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 13)),
        const SizedBox(height: 6),
        SizedBox(height: 50, child: child),
      ],
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: const Color(0xFFF6F6F6),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Actions (Firebase will be added later)
  // ---------------------------------------------------------------------------

  void _onTermsTap() {
    // TODO: open terms page or web link
  }

  void _onCreateAccount() {
    // TODO: Firebase create user (email/password) + save user profile in Firestore
    // You can also validate: accept terms, password match, etc.
  }
}
