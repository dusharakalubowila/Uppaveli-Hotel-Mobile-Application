import 'package:flutter/material.dart';
// ✅ TEMPORARILY DISABLED: Auth imports removed for UI development
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../core/providers/auth_provider.dart';

import 'signupP.dart';
import 'homeP.dart';

// ✅ TEMPORARILY CHANGED: Back to StatefulWidget (no auth needed)
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

// ✅ TEMPORARILY CHANGED: Back to State (no auth needed)
class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _rememberMe = false;
  // ✅ REMOVED: _loadingSocial - now using authProvider.isLoading

  static const Color kGold = Color(0xFFC9A633);

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ✅ TEMPORARILY DISABLED: Auth logic disabled for UI development
    // ref.listen<AuthState>(authProvider, (previous, next) {
    //   // Handle errors
    //   if (next.error != null && previous?.error != next.error) {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(content: Text(next.error!)),
    //     );
    //   }

    //   // Handle successful authentication - navigate to home
    //   if (next.isAuthenticated && next.user != null && previous?.isAuthenticated != true) {
    //     Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(
    //         builder: (_) => HomePage(
    //           displayName: next.displayName,
    //           isGuest: false,
    //           initialTabIndex: 0,
    //         ),
    //       ),
    //     );
    //   }
    // });

    // ✅ TEMPORARILY DISABLED: No auth state watching
    // final authState = ref.watch(authProvider);

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
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),

                    const Text(
                      'Welcome\nBack',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: kGold,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Sign in to your account',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),

                    const SizedBox(height: 32),

                    _buildLoginCard(),

                    const SizedBox(height: 24),

                    _buildSocialLogin(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ✅ TEMPORARILY DISABLED: No auth state needed
  Widget _buildLoginCard() {
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
          const Text('Email', style: TextStyle(fontSize: 13)),
          const SizedBox(height: 6),
          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: _inputDecoration('your@email.com'),
          ),

          const SizedBox(height: 16),

          const Text('Password', style: TextStyle(fontSize: 13)),
          const SizedBox(height: 6),
          TextField(
            controller: _passwordController,
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

          const SizedBox(height: 10),

          Row(
            children: [
              Checkbox(
                value: _rememberMe,
                activeColor: kGold,
                onChanged: (v) => setState(() => _rememberMe = v ?? false),
              ),
              const Text('Remember me'),
            ],
          ),

          const SizedBox(height: 8),

          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kGold,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              // ✅ TEMPORARILY DISABLED: Just navigate to home
              onPressed: _onEmailLogin,
              child: const Text(
                'Sign In',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),

          const SizedBox(height: 12),

          Center(
            child: TextButton(
              onPressed: _onForgotPassword,
              child: const Text(
                'Forgot Password?',
                style: TextStyle(color: kGold),
              ),
            ),
          ),

          Center(
            child: TextButton(
              onPressed: _goToSignUp,
              child: const Text(
                "Don't have an account? Sign Up",
                style: TextStyle(
                  color: kGold,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ✅ TEMPORARILY DISABLED: No auth state needed
  Widget _buildSocialLogin() {
    return Column(
      children: [
        const Text(
          'Or continue with',
          style: TextStyle(color: Colors.black54),
        ),
        const SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _socialButton(
              'assets/icons/googlelogo.png',
              _onGoogleLogin,
            ),
            const SizedBox(width: 16),
            _socialButton(
              'assets/icons/applelogo.png',
              _onAppleLogin,
            ),
            const SizedBox(width: 16),
            _socialButton(
              'assets/icons/fblogo.png',
              _onFacebookLogin,
            ),
          ],
        ),
      ],
    );
  }

  // ✅ TEMPORARILY DISABLED: No loading state
  Widget _socialButton(String icon, VoidCallback onTap) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        height: 54,
        width: 54,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.black12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Image.asset(icon),
        ),
      ),
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
  // ACTIONS - ✅ MIGRATED: Now using authProvider instead of direct Firebase calls
  // ---------------------------------------------------------------------------

  void _goToSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SignUpPage()),
    );
  }

  // ✅ TEMPORARILY DISABLED: Just navigate to home for UI development
  Future<void> _onEmailLogin() async {
    // Skip authentication - just go to home
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const HomePage(
          displayName: 'User',
          isGuest: false,
          initialTabIndex: 0,
        ),
      ),
    );
  }

  // ✅ TEMPORARILY DISABLED: Forgot password disabled
  Future<void> _onForgotPassword() async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Password reset temporarily disabled for UI development')),
    );
  }

  // ✅ TEMPORARILY DISABLED: Social logins just navigate to home
  Future<void> _onGoogleLogin() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const HomePage(
          displayName: 'User',
          isGuest: false,
          initialTabIndex: 0,
        ),
      ),
    );
  }

  Future<void> _onAppleLogin() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const HomePage(
          displayName: 'User',
          isGuest: false,
          initialTabIndex: 0,
        ),
      ),
    );
  }

  Future<void> _onFacebookLogin() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const HomePage(
          displayName: 'User',
          isGuest: false,
          initialTabIndex: 0,
        ),
      ),
    );
  }
}
