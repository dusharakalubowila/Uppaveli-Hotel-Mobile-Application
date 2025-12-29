# Riverpod Providers Usage Guide

## Overview

This guide explains how to use the Riverpod providers in your existing pages. The providers integrate seamlessly with your existing Firebase code.

## Providers Created

### 1. Auth Provider (`auth_provider.dart`)
Manages authentication state and provides methods for sign in/out.

**State Managed:**
- Current authenticated user
- Loading state during auth operations
- Error messages
- Authentication status

**Methods Available:**
- `signInWithEmail()` - Email/password login
- `signInWithGoogle()` - Google sign-in
- `signInWithApple()` - Apple sign-in
- `signInWithFacebook()` - Facebook sign-in
- `signUpWithEmail()` - Email/password signup
- `signOut()` - Sign out from all providers
- `sendPasswordResetEmail()` - Password reset

### 2. Booking Provider (`booking_provider.dart`)
Manages booking flow state across navigation.

**State Managed:**
- Check-in/check-out dates
- Number of guests and rooms
- Selected room (RoomItem)
- Promo code
- Member rate toggle
- Calculated pricing (integrated with PricingService)

**Methods Available:**
- `updateDates()` - Update check-in/check-out
- `updateGuests()` - Update number of guests
- `updateRooms()` - Update number of rooms
- `selectRoom()` - Select a room (triggers pricing calculation)
- `updatePromoCode()` - Update promo code
- `toggleMemberRate()` - Toggle member rate
- `resetBooking()` - Clear all booking state
- `clearRoomSelection()` - Clear only room selection

## Usage Examples

### Example 1: Migrating loginP.dart

**Before (StatefulWidget):**
```dart
class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<void> _onEmailLogin() async {
    try {
      final userCred = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Navigate...
    } catch (e) {
      // Error handling...
    }
  }
}
```

**After (ConsumerStatefulWidget):**
```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uppuveli/core/providers/auth_provider.dart';

class LoginPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _onEmailLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter email and password')),
      );
      return;
    }

    // Use auth provider instead of direct Firebase call
    final authNotifier = ref.read(authProvider.notifier);
    await authNotifier.signInWithEmail(
      email: email,
      password: password,
    );

    // Listen to auth state changes for navigation
    ref.listen<AuthState>(authProvider, (previous, next) {
      if (next.isAuthenticated && next.user != null) {
        // Navigate to home page
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
      } else if (next.error != null) {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error!)),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Watch auth state for loading indicator
    final authState = ref.watch(authProvider);

    return Scaffold(
      body: Column(
        children: [
          // Your existing UI...
          ElevatedButton(
            onPressed: authState.isLoading ? null : _onEmailLogin,
            child: authState.isLoading
                ? const CircularProgressIndicator()
                : const Text('Sign In'),
          ),
        ],
      ),
    );
  }
}
```

### Example 2: Migrating roomsearchP.dart

**Before (StatefulWidget):**
```dart
class _RoomSearchPageState extends State<RoomSearchPage> {
  DateTime? _checkIn;
  DateTime? _checkOut;
  late int _guests;
  late int _rooms;

  void _onFindRooms() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AvailableRoomsPage(
          checkIn: _checkIn!,
          checkOut: _checkOut!,
          guests: _guests,
        ),
      ),
    );
  }
}
```

**After (ConsumerStatefulWidget):**
```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uppuveli/core/providers/booking_provider.dart';

class RoomSearchPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<RoomSearchPage> createState() => _RoomSearchPageState();
}

class _RoomSearchPageState extends ConsumerState<RoomSearchPage> {
  @override
  void initState() {
    super.initState();
    // Initialize with widget parameters if provided
    final bookingNotifier = ref.read(bookingProvider.notifier);
    bookingNotifier.updateGuests(widget.initialGuests);
    bookingNotifier.updateRooms(widget.initialRooms);
  }

  void _onFindRooms() {
    final bookingState = ref.read(bookingProvider);
    
    if (!bookingState.isValidForSearch) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select check-in and check-out dates')),
      );
      return;
    }

    // State is already in provider, just navigate
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AvailableRoomsPage(
          checkIn: bookingState.checkIn!,
          checkOut: bookingState.checkOut!,
          guests: bookingState.guests,
        ),
      ),
    );
  }

  void _pickDate({required bool isCheckIn}) async {
    final picked = await showDatePicker(...);
    if (picked == null) return;

    final bookingNotifier = ref.read(bookingProvider.notifier);
    if (isCheckIn) {
      bookingNotifier.updateDates(checkIn: picked);
    } else {
      bookingNotifier.updateDates(checkOut: picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Watch booking state to rebuild UI when it changes
    final bookingState = ref.watch(bookingProvider);

    return Scaffold(
      body: Column(
        children: [
          // Display current state from provider
          Text('Check-in: ${bookingState.checkIn ?? "Not selected"}'),
          Text('Check-out: ${bookingState.checkOut ?? "Not selected"}'),
          Text('Guests: ${bookingState.guests}'),
          Text('Rooms: ${bookingState.rooms}'),
          
          // Update state through provider
          ElevatedButton(
            onPressed: () => _pickDate(isCheckIn: true),
            child: const Text('Select Check-in'),
          ),
          
          ElevatedButton(
            onPressed: bookingState.isValidForSearch ? _onFindRooms : null,
            child: const Text('Find Rooms'),
          ),
        ],
      ),
    );
  }
}
```

### Example 3: Using Auth State in homeP.dart

**Before:**
```dart
class HomePage extends StatefulWidget {
  final String displayName;
  final bool isGuest;
  // ...
}
```

**After:**
```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uppuveli/core/providers/auth_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key, this.initialTabIndex = 0});

  final int initialTabIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get user info from provider instead of constructor parameters
    final authState = ref.watch(authProvider);
    final displayName = authState.isAuthenticated 
        ? authState.displayName 
        : 'DSK GUEST';
    final isGuest = !authState.isAuthenticated;

    return Scaffold(
      body: Column(
        children: [
          Text('Welcome, $displayName'),
          // Rest of your UI...
        ],
      ),
    );
  }
}
```

## Key Concepts

### 1. ConsumerWidget vs ConsumerStatefulWidget
- **ConsumerWidget**: For stateless widgets that need to read/watch providers
- **ConsumerStatefulWidget**: For stateful widgets that need providers

### 2. ref.watch() vs ref.read()
- **ref.watch()**: Rebuilds widget when provider state changes (use in build method)
- **ref.read()**: One-time read, no rebuild (use in callbacks, initState, etc.)

### 3. ref.listen()
- Listens to provider changes and executes side effects (navigation, showing errors, etc.)
- Use for navigation, error handling, analytics

### 4. Accessing Notifier Methods
```dart
// Get the notifier to call methods
final authNotifier = ref.read(authProvider.notifier);
await authNotifier.signInWithEmail(email: email, password: password);

// Or directly read state
final authState = ref.read(authProvider);
```

## Migration Checklist

When migrating a page:

1. ✅ Change `StatefulWidget` → `ConsumerStatefulWidget`
2. ✅ Change `StatelessWidget` → `ConsumerWidget` (if no local state)
3. ✅ Import `flutter_riverpod` and provider files
4. ✅ Replace direct Firebase calls with provider methods
5. ✅ Use `ref.watch()` to read state in build method
6. ✅ Use `ref.read()` to call methods in callbacks
7. ✅ Use `ref.listen()` for navigation/error handling
8. ✅ Remove props drilling (state comes from providers)
9. ✅ Test that state persists across navigation

## Benefits

1. **No Props Drilling**: State is accessible from any widget
2. **State Persistence**: Booking state persists across navigation
3. **Centralized Logic**: Auth logic in one place, reusable
4. **Type Safety**: Compile-time checks for provider usage
5. **Testability**: Easy to mock providers for testing
6. **Performance**: Only rebuilds widgets that watch changed providers

## Next Steps

1. Start with `loginP.dart` - simplest migration
2. Then `signupP.dart` - similar pattern
3. Then `homeP.dart` - use auth state
4. Then `roomsearchP.dart` - use booking state
5. Finally `bookingP.dart` - full booking flow

See `RIVERPOD_MIGRATION_GUIDE.md` for detailed migration patterns.


