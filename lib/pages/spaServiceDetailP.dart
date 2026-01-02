import 'package:flutter/material.dart';
import 'spabookP.dart';

class SpaServiceDetailPage extends StatelessWidget {
  final String serviceId;

  const SpaServiceDetailPage({
    super.key,
    required this.serviceId,
  });

  static const Color kGold = Color(0xFFC9A633);
  static const Color kBg = Color(0xFFF9F8F3);
  static const Color kCharcoal = Color(0xFF2C3E3F);
  static const Color kGray = Color(0xFF7A8A8D);

  // Mock spa service data - expanded with spa-specific details
  static final Map<String, Map<String, dynamic>> spaServiceData = {
    'signature-ayurvedic': {
      'id': 'signature-ayurvedic',
      'name': 'Signature Ayurvedic Massage',
      'category': 'Massages',
      'categoryColor': const Color(0xFFC9A633), // Gold
      'rating': 4.9,
      'reviews': 128,
      'duration': '60 min',
      'price': 85.0,
      'priceUnit': 'per session',
      'imageUrl': 'assets/images/beach.png',
      'description':
          'Experience the ancient healing art of Ayurvedic massage, perfected over thousands of years. Our signature treatment combines warm herbal oils, traditional techniques, and aromatherapy to restore balance and harmony to your body, mind, and spirit.\n\nThis deeply therapeutic massage targets energy points (marma points) to release tension, improve circulation, and promote natural healing. The warm oil penetrates deep into tissues, nourishing the skin while calming the nervous system.\n\nPerfect for stress relief, muscle tension, and overall wellness, this treatment leaves you feeling rejuvenated, balanced, and deeply relaxed.',
      'included': [
        'Professional Ayurvedic therapist',
        'Warm herbal oil blend (sesame, coconut, or almond)',
        'Traditional massage techniques',
        'Aromatherapy essential oils',
        'Post-treatment herbal tea',
        'Relaxation time in spa lounge',
      ],
      'benefits': [
        'Reduces stress and anxiety',
        'Relieves muscle tension and pain',
        'Improves blood circulation',
        'Enhances skin health and glow',
        'Promotes better sleep',
        'Boosts immune system',
        'Balances energy channels',
      ],
      'therapistQualification': 'Certified Ayurvedic Practitioner with 10+ years experience',
      'productsUsed': 'Organic sesame oil, coconut oil, Ayurvedic herbs (Ashwagandha, Brahmi)',
      'contraindications': [
        'Not recommended during pregnancy (first trimester)',
        'Avoid if you have open wounds or skin infections',
        'Consult doctor if you have high blood pressure or heart conditions',
        'Not suitable immediately after meals (wait 2 hours)',
      ],
      'preTreatment': [
        'Arrive 15 minutes early for consultation',
        'Avoid heavy meals 2 hours before treatment',
        'Inform therapist of any medical conditions',
        'Remove jewelry before treatment',
      ],
      'availableTimes': ['10:00 AM', '11:00 AM', '12:00 PM', '2:00 PM', '3:00 PM', '4:00 PM', '5:00 PM', '6:00 PM'],
      'gallery': [
        'assets/images/beach.png',
        'assets/images/breeze.png',
        'assets/images/garden.png',
      ],
    },
    'ocean-breeze-facial': {
      'id': 'ocean-breeze-facial',
      'name': 'Ocean Breeze Facial',
      'category': 'Facials',
      'categoryColor': const Color(0xFF00BCD4), // Cyan
      'rating': 4.8,
      'reviews': 96,
      'duration': '75 min',
      'price': 95.0,
      'priceUnit': 'per session',
      'imageUrl': 'assets/images/breeze.png',
      'description':
          'Indulge in our signature Ocean Breeze Facial, a luxurious treatment that harnesses the power of marine botanicals to hydrate, soothe, and brighten your skin. Inspired by the pristine waters of Uppuveli Beach, this facial uses seaweed extracts, marine minerals, and tropical botanicals.\n\nThe treatment begins with a gentle cleansing and exfoliation, followed by a hydrating mask infused with marine collagen and aloe vera. A relaxing facial massage improves circulation and lymphatic drainage, leaving your skin radiant and refreshed.\n\nPerfect for all skin types, especially those seeking deep hydration and a natural glow. The marine ingredients work to reduce fine lines, even out skin tone, and restore your skin\'s natural radiance.',
      'included': [
        'Professional esthetician',
        'Deep cleansing and exfoliation',
        'Marine collagen mask',
        'Facial massage and acupressure',
        'Hydrating serum application',
        'SPF protection application',
      ],
      'benefits': [
        'Deep hydration and moisture retention',
        'Reduces fine lines and wrinkles',
        'Brightens and evens skin tone',
        'Minimizes pores',
        'Soothes sensitive skin',
        'Improves skin elasticity',
        'Natural radiance and glow',
      ],
      'therapistQualification': 'Licensed Esthetician with specialized training in marine-based treatments',
      'productsUsed': 'Organic seaweed extract, marine collagen, aloe vera, hyaluronic acid, Vitamin C',
      'contraindications': [
        'Not recommended if you have active acne or rosacea',
        'Avoid if you have open wounds or sunburn',
        'Consult if you have severe skin allergies',
        'Not suitable immediately after chemical peels',
      ],
      'preTreatment': [
        'Arrive with clean, makeup-free skin',
        'Avoid retinoids 48 hours before',
        'Inform therapist of any skin sensitivities',
        'Remove contact lenses if applicable',
      ],
      'availableTimes': ['10:00 AM', '11:00 AM', '2:00 PM', '3:00 PM', '4:00 PM', '5:00 PM'],
      'gallery': [
        'assets/images/breeze.png',
        'assets/images/garden.png',
      ],
    },
    'coconut-body-scrub': {
      'id': 'coconut-body-scrub',
      'name': 'Coconut Body Scrub',
      'category': 'Body Treatments',
      'categoryColor': const Color(0xFFE76F51), // Orange
      'rating': 4.7,
      'reviews': 78,
      'duration': '45 min',
      'price': 55.0,
      'priceUnit': 'per session',
      'imageUrl': 'assets/images/garden.png',
      'description':
          'Reveal smooth, glowing skin with our signature Coconut Body Scrub. This invigorating treatment uses fresh coconut and sea salt to gently exfoliate, removing dead skin cells and revealing your natural radiance.\n\nThe scrub is enriched with coconut oil, which deeply moisturizes while the sea salt provides gentle exfoliation. The treatment includes a full-body application followed by a warm shower and application of hydrating body butter.\n\nPerfect for preparing your skin for sun exposure or simply maintaining soft, smooth skin throughout your stay. The natural ingredients are gentle yet effective, suitable for most skin types.',
      'included': [
        'Professional therapist',
        'Fresh coconut and sea salt scrub',
        'Full body exfoliation',
        'Warm shower facilities',
        'Hydrating body butter application',
        'Relaxation time',
      ],
      'benefits': [
        'Removes dead skin cells',
        'Smooths rough patches',
        'Improves skin texture',
        'Enhances skin radiance',
        'Stimulates circulation',
        'Preps skin for tanning',
        'Deeply moisturizes',
      ],
      'therapistQualification': 'Certified Body Treatment Specialist',
      'productsUsed': 'Fresh coconut, natural sea salt, organic coconut oil, shea butter',
      'contraindications': [
        'Not recommended if you have sensitive or irritated skin',
        'Avoid on sunburned or broken skin',
        'Not suitable for those with skin conditions like eczema',
        'Consult if you have allergies to coconut',
      ],
      'preTreatment': [
        'Shower before treatment',
        'Remove jewelry',
        'Inform therapist of any skin sensitivities',
        'Arrive 10 minutes early',
      ],
      'availableTimes': ['10:00 AM', '11:00 AM', '2:00 PM', '3:00 PM', '4:00 PM'],
      'gallery': [
        'assets/images/garden.png',
        'assets/images/beach.png',
      ],
    },
    'deep-tissue-therapy': {
      'id': 'deep-tissue-therapy',
      'name': 'Deep Tissue Therapy',
      'category': 'Massages',
      'categoryColor': const Color(0xFFC9A633), // Gold
      'rating': 4.6,
      'reviews': 114,
      'duration': '90 min',
      'price': 110.0,
      'priceUnit': 'per session',
      'imageUrl': 'assets/images/room.png',
      'description':
          'Target chronic muscle tension and stress with our intensive Deep Tissue Therapy. This powerful massage uses focused pressure and slow strokes to reach deeper layers of muscle and fascia, breaking down knots and adhesions.\n\nOur experienced therapists use their hands, forearms, and elbows to apply sustained pressure, working through layers of muscle to release chronic tension. While the pressure is firm, the treatment is tailored to your comfort level.\n\nIdeal for athletes, those with chronic pain, or anyone dealing with persistent muscle tension. You may experience some soreness after the treatment, which is normal and indicates the release of deep tension.',
      'included': [
        'Expert deep tissue therapist',
        'Intensive muscle work',
        'Hot towel application',
        'Stretching techniques',
        'Post-treatment consultation',
        'Relaxation time',
      ],
      'benefits': [
        'Relieves chronic muscle tension',
        'Breaks down scar tissue',
        'Improves range of motion',
        'Reduces pain and stiffness',
        'Enhances athletic performance',
        'Promotes faster recovery',
        'Releases trigger points',
      ],
      'therapistQualification': 'Licensed Massage Therapist with specialization in deep tissue and sports massage',
      'productsUsed': 'Therapeutic massage oil, hot towels, essential oils for pain relief',
      'contraindications': [
        'Not recommended if you have recent injuries or fractures',
        'Avoid if you have blood clotting disorders',
        'Not suitable during pregnancy',
        'Consult doctor if you have osteoporosis or severe arthritis',
      ],
      'preTreatment': [
        'Arrive 15 minutes early for consultation',
        'Inform therapist of any injuries or pain points',
        'Stay hydrated before and after',
        'Avoid heavy meals 2 hours before',
      ],
      'availableTimes': ['10:00 AM', '11:00 AM', '2:00 PM', '3:00 PM', '4:00 PM', '5:00 PM'],
      'gallery': [
        'assets/images/room.png',
        'assets/images/beach.png',
      ],
    },
    'sunset-wellness-package': {
      'id': 'sunset-wellness-package',
      'name': 'Sunset Wellness Package',
      'category': 'Wellness Packages',
      'categoryColor': const Color(0xFFE76F51), // Orange
      'rating': 5.0,
      'reviews': 67,
      'duration': '120 min',
      'price': 180.0,
      'priceUnit': 'per session',
      'imageUrl': 'assets/images/beach.png',
      'description':
          'Our most comprehensive wellness experience, the Sunset Wellness Package combines multiple treatments for complete rejuvenation. This luxurious 2-hour journey includes a full-body massage, hydrating facial, and guided meditation session overlooking the ocean.\n\nBegin with a relaxing full-body massage to release tension, followed by a nourishing facial treatment to restore your skin\'s radiance. The experience culminates with a guided meditation session on our ocean-view terrace, allowing you to connect with the natural beauty around you.\n\nThis package is perfect for special occasions, honeymoons, or simply treating yourself to the ultimate spa experience. Leave feeling completely renewed, balanced, and deeply relaxed.',
      'included': [
        'Full-body massage (60 min)',
        'Hydrating facial treatment (45 min)',
        'Guided meditation session (15 min)',
        'Ocean-view relaxation area',
        'Herbal tea and light refreshments',
        'Complimentary spa amenities',
        'Extended relaxation time',
      ],
      'benefits': [
        'Complete mind-body rejuvenation',
        'Reduces stress and anxiety',
        'Improves skin health and glow',
        'Enhances mental clarity',
        'Promotes deep relaxation',
        'Balances energy and mood',
        'Creates lasting sense of well-being',
      ],
      'therapistQualification': 'Team of certified therapists and meditation guide',
      'productsUsed': 'Premium organic oils, marine-based facial products, aromatherapy blends',
      'contraindications': [
        'Not recommended during first trimester of pregnancy',
        'Consult if you have multiple health conditions',
        'Inform therapist of any allergies or sensitivities',
      ],
      'preTreatment': [
        'Arrive 20 minutes early',
        'Avoid heavy meals 3 hours before',
        'Wear comfortable clothing',
        'Bring swimwear for relaxation area',
      ],
      'availableTimes': ['10:00 AM', '2:00 PM', '4:00 PM'],
      'gallery': [
        'assets/images/beach.png',
        'assets/images/breeze.png',
        'assets/images/garden.png',
      ],
    },
  };

  @override
  Widget build(BuildContext context) {
    final service = spaServiceData[serviceId] ?? spaServiceData['signature-ayurvedic']!;

    return Scaffold(
      backgroundColor: kBg,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          service['name'] as String? ?? 'Spa Service',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Colors.black),
            onPressed: () {
              debugPrint('Share spa service: ${service['name']}');
              // TODO: Implement share functionality
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 90),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hero Image with Category Badge
                _buildHeroImage(service),
                const SizedBox(height: 16),

                // Key Info Card
                _buildKeyInfoCard(service),
                const SizedBox(height: 12),

                // Description Card
                _buildDescriptionCard(service),
                const SizedBox(height: 12),

                // What's Included Card
                _buildIncludedCard(service),
                const SizedBox(height: 12),

                // Benefits Card
                _buildBenefitsCard(service),
                const SizedBox(height: 12),

                // Pre-Treatment Instructions Card
                _buildPreTreatmentCard(service),
                const SizedBox(height: 12),

                // Contraindications Card
                _buildContraindicationsCard(service),
                const SizedBox(height: 12),

                // Timing & Availability Card
                _buildTimingCard(service),
                const SizedBox(height: 12),

                // Therapist & Products Card
                _buildTherapistCard(service),
                const SizedBox(height: 12),

                // Gallery Section
                if (service['gallery'] != null) _buildGallery(service),

                const SizedBox(height: 24),
              ],
            ),
          ),

          // Sticky Bottom Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildBottomBar(context, service),
          ),
        ],
      ),
    );
  }

  // ==================== HERO IMAGE ====================
  Widget _buildHeroImage(Map<String, dynamic> service) {
    final imageUrl = service['imageUrl'] as String? ?? 'assets/images/beach.png';
    final categoryColor = service['categoryColor'] as Color? ?? kGold;
    final category = service['category'] as String? ?? 'Spa Service';

    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
          child: Image.asset(
            imageUrl,
            width: double.infinity,
            height: 250,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: double.infinity,
                height: 250,
                color: Colors.grey[300],
                child: const Icon(Icons.image, size: 50, color: Colors.grey),
              );
            },
          ),
        ),
        // Category Badge
        Positioned(
          top: 16,
          left: 16,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: categoryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              category,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ==================== KEY INFO CARD ====================
  Widget _buildKeyInfoCard(Map<String, dynamic> service) {
    final name = service['name'] as String? ?? 'Spa Service';
    final rating = service['rating'] as num? ?? 0.0;
    final reviews = service['reviews'] as int? ?? 0;
    final duration = service['duration'] as String? ?? 'N/A';
    final price = service['price'] as num? ?? 0.0;
    final priceUnit = service['priceUnit'] as String? ?? 'per session';

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: kCharcoal,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                '⭐ $rating',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: kCharcoal,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                '($reviews reviews)',
                style: const TextStyle(
                  fontSize: 12,
                  color: kGray,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  const Icon(Icons.access_time, size: 16, color: kGray),
                  const SizedBox(width: 4),
                  Text(
                    duration,
                    style: const TextStyle(
                      fontSize: 13,
                      color: kGray,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'LKR ${price.toStringAsFixed(0)}/$priceUnit',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: kGold,
            ),
          ),
        ],
      ),
    );
  }

  // ==================== DESCRIPTION CARD ====================
  Widget _buildDescriptionCard(Map<String, dynamic> service) {
    final description = service['description'] as String? ?? 'No description available.';
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        description,
        style: const TextStyle(
          fontSize: 13,
          color: kGray,
          height: 1.6,
        ),
      ),
    );
  }

  // ==================== WHAT'S INCLUDED CARD ====================
  Widget _buildIncludedCard(Map<String, dynamic> service) {
    final included = (service['included'] as List<dynamic>?)?.cast<String>() ?? <String>[];
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'What\'s Included',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: kCharcoal,
            ),
          ),
          const SizedBox(height: 12),
          ...included.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: Color(0xFF52B788),
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 13,
                          color: kCharcoal,
                        ),
                      ),
                    ),
                  ],
                ),
              )).toList(),
        ],
      ),
    );
  }

  // ==================== BENEFITS CARD ====================
  Widget _buildBenefitsCard(Map<String, dynamic> service) {
    final benefits = (service['benefits'] as List<dynamic>?)?.cast<String>() ?? <String>[];
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Benefits',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: kCharcoal,
            ),
          ),
          const SizedBox(height: 12),
          ...benefits.map((benefit) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.favorite,
                      color: kGold,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        benefit,
                        style: const TextStyle(
                          fontSize: 13,
                          color: kCharcoal,
                        ),
                      ),
                    ),
                  ],
                ),
              )).toList(),
        ],
      ),
    );
  }

  // ==================== PRE-TREATMENT CARD ====================
  Widget _buildPreTreatmentCard(Map<String, dynamic> service) {
    final preTreatment = (service['preTreatment'] as List<dynamic>?)?.cast<String>() ?? <String>[];
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Pre-Treatment Instructions',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: kCharcoal,
            ),
          ),
          const SizedBox(height: 12),
          ...preTreatment.map((instruction) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.info_outline,
                      color: kGold,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        instruction,
                        style: const TextStyle(
                          fontSize: 13,
                          color: kCharcoal,
                        ),
                      ),
                    ),
                  ],
                ),
              )).toList(),
        ],
      ),
    );
  }

  // ==================== CONTRAINDICATIONS CARD ====================
  Widget _buildContraindicationsCard(Map<String, dynamic> service) {
    final contraindications = (service['contraindications'] as List<dynamic>?)?.cast<String>() ?? <String>[];
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 18),
              SizedBox(width: 8),
              Text(
                'Important Information',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: kCharcoal,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...contraindications.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '⚠ ',
                      style: TextStyle(fontSize: 16, color: Colors.orange),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 13,
                          color: kCharcoal,
                        ),
                      ),
                    ),
                  ],
                ),
              )).toList(),
        ],
      ),
    );
  }

  // ==================== TIMING & AVAILABILITY CARD ====================
  Widget _buildTimingCard(Map<String, dynamic> service) {
    final availableTimes = (service['availableTimes'] as List<dynamic>?)?.cast<String>() ?? <String>[];
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Available Times',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: kCharcoal,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: availableTimes.map<Widget>((time) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: kGold),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    time,
                    style: const TextStyle(
                      fontSize: 13,
                      color: kCharcoal,
                    ),
                  ),
                )).toList(),
          ),
        ],
      ),
    );
  }

  // ==================== THERAPIST & PRODUCTS CARD ====================
  Widget _buildTherapistCard(Map<String, dynamic> service) {
    final therapistQualification = service['therapistQualification'] as String? ?? 'Certified Spa Therapist';
    final productsUsed = service['productsUsed'] as String? ?? 'Premium organic products';

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.spa, color: kGold, size: 18),
              SizedBox(width: 8),
              Text(
                'Therapist & Products',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: kCharcoal,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.person, color: kGray, size: 16),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  therapistQualification,
                  style: const TextStyle(
                    fontSize: 13,
                    color: kCharcoal,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.eco, color: kGray, size: 16),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  productsUsed,
                  style: const TextStyle(
                    fontSize: 13,
                    color: kCharcoal,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ==================== GALLERY SECTION ====================
  Widget _buildGallery(Map<String, dynamic> service) {
    final gallery = (service['gallery'] as List<dynamic>?)?.cast<String>() ?? <String>[];
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Gallery',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: kCharcoal,
            ),
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1.3,
            ),
            itemCount: gallery.length,
            itemBuilder: (context, index) => ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                gallery[index],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.image, color: Colors.grey),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==================== STICKY BOTTOM BAR ====================
  Widget _buildBottomBar(BuildContext context, Map<String, dynamic> service) {
    final price = service['price'] as num? ?? 0.0;
    final name = service['name'] as String? ?? 'Spa Service';
    final duration = service['duration'] as String? ?? '60 min';
    final imageUrl = service['imageUrl'] as String? ?? 'assets/images/beach.png';
    
    // Extract minutes from duration string (e.g., "60 min" -> 60)
    final minutesMatch = RegExp(r'(\d+)').firstMatch(duration);
    final minutes = minutesMatch != null ? int.tryParse(minutesMatch.group(1) ?? '60') ?? 60 : 60;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Price',
                  style: TextStyle(
                    fontSize: 11,
                    color: kGray,
                  ),
                ),
                Text(
                  'LKR ${price.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: kGold,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SpaBookingPage(
                        treatmentName: name,
                        minutes: minutes,
                        price: price.toDouble(),
                        imageAsset: imageUrl,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kGold,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Book Now',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

