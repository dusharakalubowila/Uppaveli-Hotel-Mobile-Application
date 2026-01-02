import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'auth_provider.dart';

part 'user_provider.g.dart';

/// User data model
class AppUser {
  final String uid;
  final String? email;
  final String? displayName;
  final String? photoURL;
  final bool isGuest;

  const AppUser({
    required this.uid,
    this.email,
    this.displayName,
    this.photoURL,
    this.isGuest = false,
  });

  /// Create from Firebase User
  factory AppUser.fromFirebaseUser(User user, {bool isGuest = false}) {
    return AppUser(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      photoURL: user.photoURL,
      isGuest: isGuest,
    );
  }

  /// Create guest user
  factory AppUser.guest({String displayName = 'DSK GUEST'}) {
    return AppUser(
      uid: 'guest',
      displayName: displayName,
      isGuest: true,
    );
  }

  /// Get display name or fallback
  String get displayNameOrEmail => displayName ?? email ?? 'User';

  /// Get initials for avatar
  String get initials {
    if (displayName != null) {
      final parts = displayName!.trim().split(RegExp(r'\s+'))
          .where((p) => p.isNotEmpty)
          .toList();
      if (parts.isEmpty) return 'GU';
      if (parts.length == 1) {
        return parts[0].substring(0, 1).toUpperCase();
      }
      return (parts[0].substring(0, 1) + parts[1].substring(0, 1)).toUpperCase();
    }
    if (email != null) {
      return email!.substring(0, 1).toUpperCase();
    }
    return 'GU';
  }
}

/// Current app user provider - converts Firebase user to AppUser
@riverpod
AppUser? currentAppUser(CurrentAppUserRef ref) {
  final user = ref.watch(currentUserProvider);
  if (user == null) return null;
  return AppUser.fromFirebaseUser(user);
}

/// User display name provider
@riverpod
String userDisplayName(UserDisplayNameRef ref) {
  final appUser = ref.watch(currentAppUserProvider);
  return appUser?.displayNameOrEmail ?? 'DSK GUEST';
}

/// Is user authenticated provider
@riverpod
bool isAuthenticated(IsAuthenticatedRef ref) {
  final user = ref.watch(currentUserProvider);
  return user != null;
}

/// Is guest user provider
@riverpod
bool isGuestUser(IsGuestUserRef ref) {
  final appUser = ref.watch(currentAppUserProvider);
  return appUser?.isGuest ?? true;
}



