# Core Providers Setup

## Overview

This directory contains all Riverpod providers for global state management in the app.

## Provider Structure

- **auth_provider.dart** - Authentication state and Firebase Auth operations
- **user_provider.dart** - User data model and user-related state
- **theme_provider.dart** - App theme and color constants
- **booking_provider.dart** - Booking flow state management
- **pricing_provider.dart** - Pricing calculations and service

## Setup Instructions

### 1. Install Dependencies

```bash
flutter pub get
```

### 2. Generate Provider Code

Riverpod uses code generation. Run this command to generate the provider files:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

Or for watch mode (auto-regenerates on file changes):

```bash
flutter pub run build_runner watch --delete-conflicting-outputs
```

### 3. Generated Files

After running build_runner, you'll see `.g.dart` files generated:
- `auth_provider.g.dart`
- `user_provider.g.dart`
- `theme_provider.g.dart`
- `booking_provider.g.dart`
- `pricing_provider.g.dart`

**Note:** These files are auto-generated. Do NOT edit them manually.

## Usage Examples

### Using Auth Provider

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uppuveli/core/providers/auth_provider.dart';

class MyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final authService = ref.watch(authServiceProvider);
    
    return Text(user?.email ?? 'Not logged in');
  }
}
```

### Using User Provider

```dart
final displayName = ref.watch(userDisplayNameProvider);
final isAuth = ref.watch(isAuthenticatedProvider);
```

### Using Booking Provider

```dart
final bookingState = ref.watch(bookingStateNotifierProvider);
final bookingNotifier = ref.read(bookingStateNotifierProvider.notifier);

// Update booking state
bookingNotifier.updateSearch(
  checkIn: DateTime.now(),
  checkOut: DateTime.now().add(Duration(days: 2)),
  guests: 2,
);
```

## Next Steps

1. Run `flutter pub get`
2. Run `flutter pub run build_runner build --delete-conflicting-outputs`
3. Start migrating pages to use these providers
4. Replace StatefulWidget with ConsumerWidget where appropriate


