# Riverpod Migration Guide

## ✅ Completed: Phase 1 - Core Setup

### 1. Dependencies Added ✓
- `flutter_riverpod: ^2.4.9`
- `riverpod_annotation: ^2.3.3`
- `build_runner: ^2.4.7` (dev)
- `riverpod_generator: ^2.3.9` (dev)

### 2. Core Providers Created ✓

**Location:** `lib/core/providers/`

- ✅ `auth_provider.dart` - Authentication state
- ✅ `user_provider.dart` - User data and state
- ✅ `theme_provider.dart` - Theme and colors
- ✅ `booking_provider.dart` - Booking flow state
- ✅ `pricing_provider.dart` - Pricing calculations

### 3. Main.dart Updated ✓
- ✅ Wrapped app with `ProviderScope`
- ✅ Changed `MyApp` to `ConsumerWidget`
- ✅ Integrated theme provider

## 🚀 Next Steps

### Step 1: Generate Provider Code

```bash
# Install dependencies first
flutter pub get

# Generate provider code
flutter pub run build_runner build --delete-conflicting-outputs
```

### Step 2: Migrate Pages (Priority Order)

#### High Priority Pages:
1. **loginP.dart** → Use `authServiceProvider` and `authStateChangesProvider`
2. **signupP.dart** → Use `authServiceProvider`
3. **homeP.dart** → Use `userDisplayNameProvider` and `isAuthenticatedProvider`
4. **roomsearchP.dart** → Use `bookingStateNotifierProvider`
5. **bookingP.dart** → Use `bookingStateNotifierProvider` and `calculatePricingProvider`

#### Medium Priority Pages:
6. **roomdetP.dart** → Use `bookingStateNotifierProvider`
7. **payP.dart** → Use booking state for payment flow
8. **loyaltyP.dart** → Use user provider for loyalty data

## 📝 Migration Pattern

### Before (StatefulWidget):
```dart
class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  
  Future<void> _onEmailLogin() async {
    final userCred = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    );
    // ...
  }
}
```

### After (ConsumerWidget):
```dart
class LoginPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _emailController = TextEditingController();
  
  Future<void> _onEmailLogin() async {
    final authService = ref.read(authServiceProvider);
    try {
      final userCred = await authService.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // Navigation handled by authStateChangesProvider listener
    } catch (e) {
      // Error handling
    }
  }
}
```

## 🔄 State Management Patterns

### Reading State
```dart
// Watch (rebuilds on change)
final user = ref.watch(currentUserProvider);

// Read (one-time read, no rebuild)
final user = ref.read(currentUserProvider);
```

### Updating State
```dart
// For Notifier providers
final notifier = ref.read(bookingStateNotifierProvider.notifier);
notifier.updateSearch(checkIn: DateTime.now());
```

### Listening to Changes
```dart
ref.listen<AsyncValue<User?>>(
  authStateChangesProvider,
  (previous, next) {
    if (next.hasValue && next.value != null) {
      // User logged in, navigate
      Navigator.pushReplacement(...);
    }
  },
);
```

## 🎨 Theme Usage

### Before:
```dart
static const Color kGold = Color(0xFFC9A633);
```

### After:
```dart
import 'package:uppuveli/core/providers/theme_provider.dart';

// In widget
final theme = ref.watch(appThemeProvider);
// Or use AppColors directly
AppColors.gold
```

## ⚠️ Common Issues

### Issue: "Provider not found"
**Solution:** Make sure you've run `build_runner` to generate `.g.dart` files

### Issue: "Type 'X' is not a subtype of type 'Y'"
**Solution:** Check that you're using the correct provider type (AsyncValue, etc.)

### Issue: "ProviderScope not found"
**Solution:** Ensure `main()` wraps app with `ProviderScope`

## 📚 Resources

- [Riverpod Documentation](https://riverpod.dev/)
- [Riverpod Code Generation](https://riverpod.dev/docs/concepts/about_code_generation)
- [Migration from StatefulWidget](https://riverpod.dev/docs/concepts/reading)

## ✅ Checklist

- [x] Dependencies added to pubspec.yaml
- [x] Core providers created
- [x] Main.dart updated with ProviderScope
- [ ] Run build_runner to generate code
- [ ] Migrate loginP.dart
- [ ] Migrate signupP.dart
- [ ] Migrate homeP.dart
- [ ] Migrate booking flow pages
- [ ] Test all migrated pages
- [ ] Remove unused StatefulWidget code

---

**Status:** Phase 1 Complete ✅  
**Next:** Run build_runner and start migrating pages


