import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../pages/roomitem.dart';
import '../../pages/pricing_model.dart';
import '../../pages/pricing_service.dart';

/// Booking state model
/// Manages all booking-related state: dates, guests, rooms, selected room, etc.
class BookingState {
  final String? roomType;
  final DateTime? checkIn;
  final DateTime? checkOut;
  final int guests;
  final int rooms;
  final String? selectedRoomName;
  final RoomItem? selectedRoom;
  final String? promoCode;
  final bool applyMemberRate;
  final PricingBreakdown? pricing;

  const BookingState({
    this.roomType,
    this.checkIn,
    this.checkOut,
    this.guests = 2,
    this.rooms = 1,
    this.selectedRoomName,
    this.selectedRoom,
    this.promoCode,
    this.applyMemberRate = false,
    this.pricing,
  });

  /// Initial state with default values
  const BookingState.initial()
      : roomType = null,
        checkIn = null,
        checkOut = null,
        guests = 2,
        rooms = 1,
        selectedRoomName = null,
        selectedRoom = null,
        promoCode = null,
        applyMemberRate = false,
        pricing = null;

  /// Create a copy with updated fields
  BookingState copyWith({
    String? roomType,
    DateTime? checkIn,
    DateTime? checkOut,
    int? guests,
    int? rooms,
    String? selectedRoomName,
    RoomItem? selectedRoom,
    String? promoCode,
    bool? applyMemberRate,
    PricingBreakdown? pricing,
  }) {
    return BookingState(
      roomType: roomType ?? this.roomType,
      checkIn: checkIn ?? this.checkIn,
      checkOut: checkOut ?? this.checkOut,
      guests: guests ?? this.guests,
      rooms: rooms ?? this.rooms,
      selectedRoomName: selectedRoomName ?? this.selectedRoomName,
      selectedRoom: selectedRoom ?? this.selectedRoom,
      promoCode: promoCode ?? this.promoCode,
      applyMemberRate: applyMemberRate ?? this.applyMemberRate,
      pricing: pricing ?? this.pricing,
    );
  }

  /// Check if booking state is valid for room search
  bool get isValidForSearch {
    return checkIn != null &&
        checkOut != null &&
        checkOut!.isAfter(checkIn!) &&
        guests > 0 &&
        rooms > 0;
  }

  /// Check if booking state is valid for booking confirmation
  bool get isValidForBooking {
    return isValidForSearch &&
        selectedRoom != null &&
        selectedRoomName != null;
  }

  /// Calculate number of nights
  int get nights {
    if (checkIn == null || checkOut == null) return 0;
    return checkOut!.difference(checkIn!).inDays;
  }

  /// Get formatted date range string
  String get dateRangeString {
    if (checkIn == null || checkOut == null) return '';
    return '${_formatDate(checkIn!)} - ${_formatDate(checkOut!)}';
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
    return '${months[date.month - 1]} ${date.day.toString().padLeft(2, '0')}';
  }
}

/// Booking StateNotifier
/// Manages booking flow state and integrates with PricingService
class BookingNotifier extends StateNotifier<BookingState> {
  final PricingService _pricingService = PricingService();

  BookingNotifier() : super(const BookingState.initial());

  /// Update check-in and check-out dates
  /// Validates that check-out is after check-in
  void updateDates({
    DateTime? checkIn,
    DateTime? checkOut,
  }) {
    DateTime? newCheckIn = checkIn ?? state.checkIn;
    DateTime? newCheckOut = checkOut ?? state.checkOut;

    // Validate dates
    if (newCheckIn != null && newCheckOut != null) {
      if (!newCheckOut.isAfter(newCheckIn)) {
        // Invalid date range, don't update
        return;
      }
    }

    state = state.copyWith(
      checkIn: newCheckIn,
      checkOut: newCheckOut,
    );

    // Recalculate pricing if room is selected
    if (state.selectedRoom != null) {
      _recalculatePricing();
    }
  }

  /// Update number of guests
  void updateGuests(int guests) {
    if (guests < 1) return;
    state = state.copyWith(guests: guests);

    // Recalculate pricing if room is selected
    if (state.selectedRoom != null) {
      _recalculatePricing();
    }
  }

  /// Update number of rooms
  void updateRooms(int rooms) {
    if (rooms < 1) return;
    state = state.copyWith(rooms: rooms);

    // Recalculate pricing if room is selected
    if (state.selectedRoom != null) {
      _recalculatePricing();
    }
  }

  /// Update room type filter
  void updateRoomType(String? roomType) {
    state = state.copyWith(roomType: roomType);
  }

  /// Select a room by name
  void updateRoomName(String roomName) {
    state = state.copyWith(selectedRoomName: roomName);
  }

  /// Select a room (RoomItem)
  /// This will trigger pricing calculation
  void selectRoom(RoomItem room) {
    state = state.copyWith(
      selectedRoom: room,
      selectedRoomName: room.name,
    );

    // Calculate pricing when room is selected
    _recalculatePricing();
  }

  /// Update promo code
  /// This will trigger pricing recalculation
  void updatePromoCode(String? promoCode) {
    state = state.copyWith(promoCode: promoCode);
    _recalculatePricing();
  }

  /// Toggle member rate application
  void toggleMemberRate(bool apply) {
    state = state.copyWith(applyMemberRate: apply);
    _recalculatePricing();
  }

  /// Recalculate pricing based on current booking state
  /// Integrates with existing PricingService from pricing_service.dart
  Future<void> _recalculatePricing() async {
    if (state.selectedRoom == null ||
        state.checkIn == null ||
        state.checkOut == null) {
      return;
    }

    try {
      final nights = state.nights;
      if (nights < 1) return;

      final baseRate = state.selectedRoom!.price.toDouble();
      final pricing = await _pricingService.calculate(
        baseRatePerNight: baseRate,
        nights: nights,
        promoCode: state.promoCode,
      );

      state = state.copyWith(pricing: pricing);
    } catch (e) {
      // Error calculating pricing - keep existing pricing or set to null
      // In production, you might want to show an error message
      print('Error calculating pricing: $e');
    }
  }

  /// Manually trigger pricing calculation
  /// Useful when you want to recalculate pricing on demand
  Future<void> calculatePricing() async {
    await _recalculatePricing();
  }

  /// Reset booking state to initial values
  void resetBooking() {
    state = const BookingState.initial();
  }

  /// Clear only room selection (keep search parameters)
  void clearRoomSelection() {
    state = state.copyWith(
      selectedRoom: null,
      selectedRoomName: null,
      pricing: null,
    );
  }

  /// Clear only pricing (keep room selection)
  void clearPricing() {
    state = state.copyWith(pricing: null);
  }
}

/// Booking provider - provides BookingNotifier instance
final bookingProvider = StateNotifierProvider<BookingNotifier, BookingState>((ref) {
  return BookingNotifier();
});

/// Booking validation provider - checks if booking is valid for search
final isBookingValidForSearchProvider = Provider<bool>((ref) {
  final bookingState = ref.watch(bookingProvider);
  return bookingState.isValidForSearch;
});

/// Booking validation provider - checks if booking is valid for confirmation
final isBookingValidForBookingProvider = Provider<bool>((ref) {
  final bookingState = ref.watch(bookingProvider);
  return bookingState.isValidForBooking;
});

/// Number of nights provider - calculates nights from booking state
final bookingNightsProvider = Provider<int>((ref) {
  final bookingState = ref.watch(bookingProvider);
  return bookingState.nights;
});
