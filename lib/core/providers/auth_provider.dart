import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

/// Authentication state model
/// Manages user authentication state, loading, and error states
class AuthState {
  final User? user;
  final bool isLoading;
  final String? error;
  final bool isAuthenticated;

  const AuthState({
    this.user,
    this.isLoading = false,
    this.error,
  }) : isAuthenticated = user != null;

  /// Initial state (not authenticated, not loading)
  const AuthState.initial()
      : user = null,
        isLoading = false,
        error = null,
        isAuthenticated = false;

  /// Loading state
  AuthState loading() {
    return AuthState(
      user: user,
      isLoading: true,
      error: null,
    );
  }

  /// Success state with user
  AuthState authenticated(User authenticatedUser) {
    return AuthState(
      user: authenticatedUser,
      isLoading: false,
      error: null,
    );
  }

  /// Error state
  AuthState errorState(String errorMessage) {
    return AuthState(
      user: user,
      isLoading: false,
      error: errorMessage,
    );
  }

  /// Signed out state
  AuthState signedOut() {
    return const AuthState.initial();
  }

  /// Get user display name or fallback
  String get displayName => user?.displayName ?? user?.email ?? 'User';

  /// Get user email
  String? get email => user?.email;
}

/// Authentication StateNotifier
/// Manages authentication state and provides methods for sign in/out
class AuthNotifier extends StateNotifier<AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  AuthNotifier() : super(const AuthState.initial()) {
    // Listen to auth state changes from Firebase
    _auth.authStateChanges().listen((User? user) {
      if (user != null) {
        state = state.authenticated(user);
      } else {
        state = state.signedOut();
      }
    });
  }

  /// Sign in with email and password
  /// Integrates with existing Firebase logic from loginP.dart
  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      state = state.loading();

      final userCred = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      final user = userCred.user;
      if (user != null) {
        state = state.authenticated(user);
      } else {
        state = state.errorState('Sign in failed: No user returned');
      }
    } on FirebaseAuthException catch (e) {
      String errorMsg = 'Login failed';
      if (e.code == 'user-not-found') {
        errorMsg = 'No account found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMsg = 'Wrong password.';
      } else if (e.code == 'invalid-email') {
        errorMsg = 'Invalid email.';
      } else if (e.code == 'user-disabled') {
        errorMsg = 'This account has been disabled.';
      } else if (e.code == 'too-many-requests') {
        errorMsg = 'Too many requests. Please try again later.';
      } else {
        errorMsg = e.message ?? 'Login failed';
      }
      state = state.errorState(errorMsg);
    } catch (e) {
      state = state.errorState('Login failed: $e');
    }
  }

  /// Sign in with Google
  /// Integrates with existing Google login logic from loginP.dart
  Future<void> signInWithGoogle() async {
    try {
      state = state.loading();

      UserCredential userCred;

      if (kIsWeb) {
        // Web Google login (Popup)
        final googleProvider = GoogleAuthProvider()
          ..addScope('email')
          ..addScope('profile');

        userCred = await _auth.signInWithPopup(googleProvider);
      } else {
        // Android/iOS Google login
        final googleUser = await _googleSignIn.signIn();
        if (googleUser == null) {
          // User canceled
          state = state.signedOut();
          return;
        }

        final googleAuth = await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        userCred = await _auth.signInWithCredential(credential);
      }

      final user = userCred.user;
      if (user != null) {
        state = state.authenticated(user);
      } else {
        state = state.errorState('Google sign-in failed: No user returned');
      }
    } catch (e) {
      state = state.errorState('Google sign-in failed: $e');
    }
  }

  /// Sign in with Apple
  /// Integrates with existing Apple login logic from loginP.dart
  Future<void> signInWithApple() async {
    try {
      state = state.loading();

      // Check if Apple Sign-In is available
      final isAvailable = await SignInWithApple.isAvailable();
      if (!isAvailable) {
        state = state.errorState('Apple Sign-In not available on this device');
        return;
      }

      // Get Apple credential
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      // Sign in with Firebase using Apple credential
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: credential.identityToken,
      );

      final userCred = await _auth.signInWithCredential(oauthCredential);
      final user = userCred.user;

      if (user != null) {
        state = state.authenticated(user);
      } else {
        state = state.errorState('Apple sign-in failed: No user returned');
      }
    } catch (e) {
      state = state.errorState('Apple sign-in failed: $e');
    }
  }

  /// Sign in with Facebook
  /// Integrates with existing Facebook login logic from loginP.dart
  Future<void> signInWithFacebook() async {
    try {
      state = state.loading();

      // Trigger the sign-in flow
      final LoginResult result = await FacebookAuth.instance.login(
        permissions: ['email', 'public_profile'],
      );

      if (result.status == LoginStatus.success) {
        // Get access token
        final AccessToken accessToken = result.accessToken!;

        // Sign in with Firebase using Facebook credential
        final credential = FacebookAuthProvider.credential(accessToken.tokenString);

        final userCred = await _auth.signInWithCredential(credential);
        final user = userCred.user;

        if (user != null) {
          state = state.authenticated(user);
        } else {
          state = state.errorState('Facebook sign-in failed: No user returned');
        }
      } else if (result.status == LoginStatus.cancelled) {
        state = state.signedOut();
      } else {
        state = state.errorState('Facebook sign-in failed: ${result.message}');
      }
    } catch (e) {
      state = state.errorState('Facebook sign-in error: $e');
    }
  }

  /// Create user with email and password
  /// Integrates with existing signup logic from signupP.dart
  Future<void> signUpWithEmail({
    required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      state = state.loading();

      final cred = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      // Update display name if provided
      if (displayName != null && displayName.isNotEmpty) {
        await cred.user?.updateDisplayName(displayName);
        await cred.user?.reload();
      }

      final user = cred.user;
      if (user != null) {
        state = state.authenticated(user);
      } else {
        state = state.errorState('Sign up failed: No user returned');
      }
    } on FirebaseAuthException catch (e) {
      String errorMsg = e.message ?? 'Sign up failed';
      if (e.code == 'email-already-in-use') {
        errorMsg = 'An account already exists for that email.';
      } else if (e.code == 'weak-password') {
        errorMsg = 'The password provided is too weak.';
      } else if (e.code == 'invalid-email') {
        errorMsg = 'Invalid email address.';
      }
      state = state.errorState(errorMsg);
    } catch (e) {
      state = state.errorState('Sign up failed: $e');
    }
  }

  /// Sign out
  /// Signs out from Firebase and Google (if applicable)
  Future<void> signOut() async {
    try {
      state = state.loading();

      // Sign out from Firebase
      await _auth.signOut();

      // Sign out from Google session (mobile)
      if (!kIsWeb) {
        await _googleSignIn.signOut();
      }

      // Sign out from Facebook
      await FacebookAuth.instance.logOut();

      state = state.signedOut();
    } catch (e) {
      state = state.errorState('Sign out failed: $e');
    }
  }

  /// Send password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      state = state.loading();
      await _auth.sendPasswordResetEmail(email: email.trim());
      // Don't change state on success, just clear loading
      state = AuthState(
        user: state.user,
        isLoading: false,
        error: null,
      );
    } catch (e) {
      state = state.errorState('Password reset failed: $e');
    }
  }

  /// Clear error state
  void clearError() {
    state = AuthState(
      user: state.user,
      isLoading: state.isLoading,
      error: null,
    );
  }
}

/// Auth provider - provides AuthNotifier instance
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});

/// Current user provider - provides current authenticated user
final currentUserProvider = Provider<User?>((ref) {
  final authState = ref.watch(authProvider);
  return authState.user;
});

/// Is authenticated provider - provides authentication status
final isAuthenticatedProvider = Provider<bool>((ref) {
  final authState = ref.watch(authProvider);
  return authState.isAuthenticated;
});

/// User display name provider - provides user display name
final userDisplayNameProvider = Provider<String>((ref) {
  final authState = ref.watch(authProvider);
  return authState.displayName;
});
