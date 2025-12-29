import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ✅ REMOVED: Direct Firebase imports (now using provider)
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import 'signupP.dart';
import 'homeP.dart'; // ✅ make sure this file name matches your GuestHomePage file
import '../core/providers/auth_provider.dart'; // ✅ ADDED: Import auth provider

// ✅ MIGRATED: Changed from StatefulWidget to ConsumerStatefulWidget
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

// ✅ MIGRATED: Changed from State to ConsumerState
class _LoginPageState extends ConsumerState<LoginPage> {
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
    // ✅ ADDED: Listen to auth state changes for navigation and error handling
    ref.listen<AuthState>(authProvider, (previous, next) {
      // Handle errors
      if (next.error != null && previous?.error != next.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error!)),
        );
      }

      // Handle successful authentication - navigate to home
      if (next.isAuthenticated && next.user != null && previous?.isAuthenticated != true) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => HomePage(
              displayName: next.displayName,
              isGuest: false,
              initialTabIndex: 0,
            ),
          ),
        );
      }
    });

    // ✅ ADDED: Watch auth state for loading indicator
    final authState = ref.watch(authProvider);

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

                    _buildLoginCard(authState),

                    const SizedBox(height: 24),

                    _buildSocialLogin(authState),

                    // ✅ CHANGED: Use provider loading state instead of local _loadingSocial
                    if (authState.isLoading) ...[
                      const SizedBox(height: 18),
                      const CircularProgressIndicator(),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ✅ CHANGED: Added authState parameter to access loading state
  Widget _buildLoginCard(AuthState authState) {
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
              // ✅ CHANGED: Disable button when loading (from provider)
              onPressed: authState.isLoading ? null : _onEmailLogin,
              child: authState.isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text(
                      'Sign In',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
            ),
          ),

          const SizedBox(height: 12),

          Center(
            child: TextButton(
              onPressed: authState.isLoading ? null : _onForgotPassword,
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

  // ✅ CHANGED: Added authState parameter
  Widget _buildSocialLogin(AuthState authState) {
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
              authState.isLoading,
            ),
            const SizedBox(width: 16),
            _socialButton(
              'assets/icons/applelogo.png',
              _onAppleLogin,
              authState.isLoading,
            ),
            const SizedBox(width: 16),
            _socialButton(
              'assets/icons/fblogo.png',
              _onFacebookLogin,
              authState.isLoading,
            ),
          ],
        ),
      ],
    );
  }

  // ✅ CHANGED: Added isLoading parameter instead of using local _loadingSocial
  Widget _socialButton(String icon, VoidCallback onTap, bool isLoading) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: isLoading ? null : onTap,
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

  // ✅ MIGRATED: Replaced Firebase call with provider method
  Future<void> _onEmailLogin() async {
    final email = _emailController.text.trim();
    final pass = _passwordController.text.trim();

    if (email.isEmpty || pass.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter email and password')),
      );
      return;
    }

    // ✅ CHANGED: Use auth provider instead of direct Firebase call
    final authNotifier = ref.read(authProvider.notifier);
    await authNotifier.signInWithEmail(
      email: email,
      password: pass,
    );

    // ✅ REMOVED: Manual navigation and error handling - now handled by ref.listen
    // Navigation happens automatically when isAuthenticated becomes true
    // Errors are shown automatically via ref.listen
  }

  // ✅ IMPLEMENTED: Forgot password using provider
  Future<void> _onForgotPassword() async {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your email address')),
      );
      return;
    }

    // ✅ CHANGED: Use auth provider method
    final authNotifier = ref.read(authProvider.notifier);
    await authNotifier.sendPasswordResetEmail(email);

    // Show success message
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password reset email sent. Please check your inbox.'),
        ),
      );
    }
  }

  // ✅ MIGRATED: Replaced Google sign-in with provider method
  Future<void> _onGoogleLogin() async {
    // ✅ CHANGED: Use auth provider instead of direct Firebase/GoogleSignIn calls
    final authNotifier = ref.read(authProvider.notifier);
    await authNotifier.signInWithGoogle();

    // ✅ REMOVED: Manual navigation - handled by ref.listen
    // For social logins that go to SocialConfirmPage, we'll handle that separately
    // if needed, or let the provider handle it
  }

  // ✅ MIGRATED: Replaced Apple sign-in with provider method
  Future<void> _onAppleLogin() async {
    // ✅ CHANGED: Use auth provider instead of direct Firebase/Apple calls
    final authNotifier = ref.read(authProvider.notifier);
    await authNotifier.signInWithApple();

    // ✅ REMOVED: Manual navigation - handled by ref.listen
  }

  // ✅ MIGRATED: Replaced Facebook sign-in with provider method
  Future<void> _onFacebookLogin() async {
    // ✅ CHANGED: Use auth provider instead of direct Firebase/Facebook calls
    final authNotifier = ref.read(authProvider.notifier);
    await authNotifier.signInWithFacebook();

    // ✅ REMOVED: Manual navigation - handled by ref.listen
  }
}
