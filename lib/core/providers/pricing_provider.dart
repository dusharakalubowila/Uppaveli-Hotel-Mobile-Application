import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../pages/pricing_model.dart';
import '../../pages/pricing_service.dart';

part 'pricing_provider.g.dart';

/// Pricing service provider
@riverpod
PricingService pricingService(PricingServiceRef ref) {
  return PricingService();
}

/// Calculate pricing provider - async provider for pricing calculation
@riverpod
Future<PricingBreakdown> calculatePricing(
  CalculatePricingRef ref, {
  required double baseRatePerNight,
  required int nights,
  String? promoCode,
}) async {
  final service = ref.watch(pricingServiceProvider);
  return await service.calculate(
    baseRatePerNight: baseRatePerNight,
    nights: nights,
    promoCode: promoCode,
  );
}


