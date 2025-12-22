import 'package:flutter/material.dart';

/// Social Confirmation Page (Almost there!)
/// - Shows user info (name + email + avatar)
/// - Shows provider (Google / Apple)
/// - Continue -> navigate to next page (Home)
/// - Use different account -> pop back (or go to login)
///
/// NOTE: The email/name shown here can be real (from Firebase user)
/// but for now you can pass example strings.

class SocialConfirmPage extends StatelessWidget {
  const SocialConfirmPage({
    super.key,
    required this.displayName,
    required this.email,
    required this.providerLabel, // e.g. "Signing in with Google"
    required this.onContinue,
    required this.onUseDifferentAccount,
    this.avatarText = "JD",
    this.providerIconAsset = 'assets/icons/google.png',
  });

  final String displayName;
  final String email;
  final String providerLabel;
  final String avatarText;
  final String providerIconAsset;

  final VoidCallback onContinue;
  final VoidCallback onUseDifferentAccount;

  static const Color kGold = Color(0xFFC9A633);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F8F3),
      body: SafeArea(
        child: Column(
          children: [
            // Top gold bar with title
            Container(
              height: 52,
              width: double.infinity,
              color: kGold,
              alignment: Alignment.center,
              child: const Text(
                'Screen 3: Social\nLogin',
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
                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 6),

                    const Text(
                      'Almost\nthere!',
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
                      'Confirm your account details',
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),

                    const SizedBox(height: 26),

                    _buildCard(),

                    const SizedBox(height: 26),

                    // Continue
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kGold,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: onContinue,
                        child: const Text(
                          'Continue',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Use different account
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: const BorderSide(color: kGold, width: 1.2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: onUseDifferentAccount,
                        child: const Text(
                          'Use different account',
                          style: TextStyle(
                            color: kGold,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
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

  Widget _buildCard() {
    return Container(
      padding: const EdgeInsets.all(18),
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
          // Profile row
          Row(
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: const Color(0xFF2E6B5F),
                child: Text(
                  avatarText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      displayName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      email,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Provider row (Google / Apple)
          Container(
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF6F6F6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Image.asset(providerIconAsset, height: 18, width: 18),
                const SizedBox(width: 10),
                Text(
                  providerLabel,
                  style: const TextStyle(fontSize: 13),
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          const Text(
            'This will allow Uppuveli Beach to\naccess:',
            style: TextStyle(fontSize: 12.5, color: Colors.black87, height: 1.3),
          ),

          const SizedBox(height: 10),

          _checkItem('Your name'),
          _checkItem('Email address'),
          _checkItem('Profile picture'),

          const SizedBox(height: 14),

          // Privacy note box
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF2F2F2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'We will never post anything without your\npermission. Your data is protected according\nto our privacy policy.',
              style: TextStyle(fontSize: 11.5, color: Colors.black54, height: 1.25),
            ),
          ),
        ],
      ),
    );
  }

  Widget _checkItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            height: 18,
            width: 18,
            decoration: const BoxDecoration(
              color: Color(0xFF2FB26C),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check, size: 12, color: Colors.white),
          ),
          const SizedBox(width: 10),
          Text(text, style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }
}
