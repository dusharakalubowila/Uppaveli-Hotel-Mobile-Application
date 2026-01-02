import 'package:flutter/material.dart';
import 'payP.dart';

class RoomServicePage extends StatefulWidget {
  const RoomServicePage({super.key});

  @override
  State<RoomServicePage> createState() => _RoomServicePageState();
}

class _RoomServicePageState extends State<RoomServicePage>
    with SingleTickerProviderStateMixin {
  static const Color kGold = Color(0xFFC9A633);
  static const Color kBg = Color(0xFFF9F8F3);
  static const Color kCharcoal = Color(0xFF2C3E3F);
  static const Color kGray = Color(0xFF7A8A8D);

  late TabController _tabController;
  String? selectedRoomNumber;
  final TextEditingController _roomNumberController = TextEditingController();
  final Map<String, int> _cart = {}; // itemId -> quantity

  // Mock menu data
  final Map<String, List<Map<String, dynamic>>> _menuData = {
    'Breakfast': [
      {
        'id': 'bf-001',
        'name': 'Continental Breakfast',
        'description': 'Fresh fruits, pastries, eggs, bacon, toast, coffee',
        'price': 2500.0,
        'imageUrl': 'assets/images/beach.png',
        'category': 'Continental',
      },
      {
        'id': 'bf-002',
        'name': 'Sri Lankan Breakfast',
        'description': 'String hoppers, dhal curry, coconut sambol, egg curry',
        'price': 1800.0,
        'imageUrl': 'assets/images/breeze.png',
        'category': 'Sri Lankan',
      },
      {
        'id': 'bf-003',
        'name': 'Pancake Stack',
        'description': 'Fluffy pancakes with maple syrup and butter',
        'price': 1200.0,
        'imageUrl': 'assets/images/garden.png',
        'category': 'Continental',
      },
      {
        'id': 'bf-004',
        'name': 'Eggs Benedict',
        'description': 'Poached eggs on English muffin with hollandaise',
        'price': 2200.0,
        'imageUrl': 'assets/images/room.png',
        'category': 'Continental',
      },
    ],
    'Lunch': [
      {
        'id': 'ln-001',
        'name': 'Grilled Chicken Salad',
        'description': 'Mixed greens, grilled chicken, vegetables, dressing',
        'price': 2800.0,
        'imageUrl': 'assets/images/beach.png',
      },
      {
        'id': 'ln-002',
        'name': 'Rice & Curry',
        'description': 'Traditional Sri Lankan rice with 3 curries',
        'price': 2000.0,
        'imageUrl': 'assets/images/breeze.png',
      },
      {
        'id': 'ln-003',
        'name': 'Club Sandwich',
        'description': 'Chicken, bacon, lettuce, tomato, mayo',
        'price': 2400.0,
        'imageUrl': 'assets/images/garden.png',
      },
      {
        'id': 'ln-004',
        'name': 'Pasta Carbonara',
        'description': 'Creamy pasta with bacon and parmesan',
        'price': 2600.0,
        'imageUrl': 'assets/images/room.png',
      },
    ],
    'Dinner': [
      {
        'id': 'dn-001',
        'name': 'Grilled Seafood Platter',
        'description': 'Fresh fish, prawns, calamari with sides',
        'price': 4500.0,
        'imageUrl': 'assets/images/beach.png',
      },
      {
        'id': 'dn-002',
        'name': 'Beef Steak',
        'description': 'Tender beef steak with vegetables and sauce',
        'price': 3800.0,
        'imageUrl': 'assets/images/breeze.png',
      },
      {
        'id': 'dn-003',
        'name': 'Chicken Curry',
        'description': 'Traditional Sri Lankan chicken curry with rice',
        'price': 2200.0,
        'imageUrl': 'assets/images/garden.png',
      },
      {
        'id': 'dn-004',
        'name': 'Vegetable Kottu Roti',
        'description': 'Shredded roti with vegetables and spices',
        'price': 1800.0,
        'imageUrl': 'assets/images/room.png',
      },
    ],
    'Drinks': [
      {
        'id': 'dr-001',
        'name': 'Fresh Orange Juice',
        'description': 'Freshly squeezed orange juice',
        'price': 600.0,
        'imageUrl': 'assets/images/beach.png',
      },
      {
        'id': 'dr-002',
        'name': 'Coconut Water',
        'description': 'Fresh king coconut water',
        'price': 500.0,
        'imageUrl': 'assets/images/breeze.png',
      },
      {
        'id': 'dr-003',
        'name': 'Iced Coffee',
        'description': 'Cold brew coffee with ice',
        'price': 800.0,
        'imageUrl': 'assets/images/garden.png',
      },
      {
        'id': 'dr-004',
        'name': 'Soft Drinks',
        'description': 'Coca Cola, Sprite, Fanta',
        'price': 400.0,
        'imageUrl': 'assets/images/room.png',
      },
    ],
    'Desserts': [
      {
        'id': 'ds-001',
        'name': 'Chocolate Lava Cake',
        'description': 'Warm chocolate cake with vanilla ice cream',
        'price': 1500.0,
        'imageUrl': 'assets/images/beach.png',
      },
      {
        'id': 'ds-002',
        'name': 'Watalappan',
        'description': 'Traditional Sri Lankan coconut pudding',
        'price': 1200.0,
        'imageUrl': 'assets/images/breeze.png',
      },
      {
        'id': 'ds-003',
        'name': 'Ice Cream Sundae',
        'description': 'Vanilla ice cream with toppings',
        'price': 1000.0,
        'imageUrl': 'assets/images/garden.png',
      },
    ],
    'Snacks': [
      {
        'id': 'sn-001',
        'name': 'French Fries',
        'description': 'Crispy golden fries with ketchup',
        'price': 800.0,
        'imageUrl': 'assets/images/beach.png',
      },
      {
        'id': 'sn-002',
        'name': 'Chicken Wings',
        'description': 'Spicy chicken wings with dip',
        'price': 1800.0,
        'imageUrl': 'assets/images/breeze.png',
      },
      {
        'id': 'sn-003',
        'name': 'Nachos',
        'description': 'Crispy nachos with cheese and salsa',
        'price': 1500.0,
        'imageUrl': 'assets/images/garden.png',
      },
    ],
  };

  final List<String> _categories = [
    'Breakfast',
    'Lunch',
    'Dinner',
    'Drinks',
    'Desserts',
    'Snacks',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _categories.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _roomNumberController.dispose();
    super.dispose();
  }

  int get _cartItemCount {
    return _cart.values.fold(0, (sum, quantity) => sum + quantity);
  }

  double get _cartTotal {
    double total = 0.0;
    for (var category in _menuData.values) {
      for (var item in category) {
        final itemId = item['id'] as String;
        final quantity = _cart[itemId] ?? 0;
        if (quantity > 0) {
          total += (item['price'] as num).toDouble() * quantity;
        }
      }
    }
    return total;
  }

  Map<String, dynamic>? _getItemById(String itemId) {
    for (var category in _menuData.values) {
      for (var item in category) {
        if (item['id'] == itemId) {
          return item;
        }
      }
    }
    return null;
  }

  void _addToCart(String itemId) {
    setState(() {
      _cart[itemId] = (_cart[itemId] ?? 0) + 1;
    });
  }

  void _removeFromCart(String itemId) {
    setState(() {
      final currentQuantity = _cart[itemId] ?? 0;
      if (currentQuantity > 1) {
        _cart[itemId] = currentQuantity - 1;
      } else {
        _cart.remove(itemId);
      }
    });
  }

  void _showCartDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildCartModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Room Service',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
        ),
        backgroundColor: kGold,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: _categories.map((cat) => Tab(text: cat)).toList(),
        ),
      ),
      body: Column(
        children: [
          // Room Number Input
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Row(
              children: [
                const Icon(Icons.hotel, color: kGold, size: 20),
                const SizedBox(width: 8),
                const Text(
                  'Room Number:',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: kCharcoal),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _roomNumberController,
                    decoration: InputDecoration(
                      hintText: 'Enter room number',
                      hintStyle: const TextStyle(fontSize: 13, color: kGray),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: kGold),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: kGold, width: 2),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    ),
                    style: const TextStyle(fontSize: 14, color: kCharcoal),
                    onChanged: (value) {
                      setState(() {
                        selectedRoomNumber = value.isEmpty ? null : value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          // Menu Items
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: _categories.map((category) => _buildMenuGrid(category)).toList(),
            ),
          ),
        ],
      ),
      // Floating Cart Badge
      floatingActionButton: _cartItemCount > 0
          ? Stack(
              clipBehavior: Clip.none,
              children: [
                FloatingActionButton(
                  onPressed: _showCartDialog,
                  backgroundColor: kGold,
                  child: const Icon(Icons.shopping_cart, color: Colors.white),
                ),
                Positioned(
                  right: -4,
                  top: -4,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '$_cartItemCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            )
          : null,
      // Sticky Bottom Bar
      bottomNavigationBar: _cartItemCount > 0
          ? Container(
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
                          'Total',
                          style: TextStyle(fontSize: 11, color: kGray),
                        ),
                        Text(
                          'LKR ${_cartTotal.toStringAsFixed(0)}',
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
                        onPressed: _showCartDialog,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kGold,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'View Cart',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : null,
    );
  }

  Widget _buildMenuGrid(String category) {
    final items = _menuData[category] ?? [];
    if (items.isEmpty) {
      return const Center(
        child: Text('No items available', style: TextStyle(color: kGray)),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.75,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) => _buildMenuItemCard(items[index]),
    );
  }

  Widget _buildMenuItemCard(Map<String, dynamic> item) {
    final itemId = item['id'] as String;
    final quantity = _cart[itemId] ?? 0;
    final price = (item['price'] as num).toDouble();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: Image.asset(
              item['imageUrl'] as String? ?? 'assets/images/beach.png',
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 120,
                  color: Colors.grey[300],
                  child: const Icon(Icons.image, color: Colors.grey),
                );
              },
            ),
          ),
          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['name'] as String? ?? 'Item',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: kCharcoal,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item['description'] as String? ?? '',
                    style: const TextStyle(
                      fontSize: 11,
                      color: kGray,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'LKR ${price.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: kGold,
                        ),
                      ),
                      // Add/Remove buttons
                      quantity > 0
                          ? Row(
                              children: [
                                InkWell(
                                  onTap: () => _removeFromCart(itemId),
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: kGold.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: const Icon(Icons.remove, size: 16, color: kGold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(
                                    '$quantity',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: kCharcoal,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () => _addToCart(itemId),
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: kGold,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: const Icon(Icons.add, size: 16, color: Colors.white),
                                  ),
                                ),
                              ],
                            )
                          : InkWell(
                              onTap: () => _addToCart(itemId),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: kGold,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Text(
                                  'Add',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartModal() {
    final cartItems = <Map<String, dynamic>>[];
    for (var entry in _cart.entries) {
      final item = _getItemById(entry.key);
      if (item != null) {
        cartItems.add({
          ...item,
          'quantity': entry.value,
        });
      }
    }

    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            // Handle
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // Header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Your Cart',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: kCharcoal,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: kGray),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            // Cart Items
            Expanded(
              child: cartItems.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.shopping_cart_outlined, size: 64, color: kGray),
                          SizedBox(height: 16),
                          Text(
                            'Your cart is empty',
                            style: TextStyle(fontSize: 16, color: kGray),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      controller: scrollController,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final item = cartItems[index];
                        final itemId = item['id'] as String;
                        final quantity = item['quantity'] as int;
                        final price = (item['price'] as num).toDouble();

                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: kBg,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  item['imageUrl'] as String? ?? 'assets/images/beach.png',
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      width: 60,
                                      height: 60,
                                      color: Colors.grey[300],
                                      child: const Icon(Icons.image, color: Colors.grey),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['name'] as String? ?? 'Item',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: kCharcoal,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'LKR ${price.toStringAsFixed(0)}',
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: kGold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () => setState(() => _removeFromCart(itemId)),
                                    child: Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        color: kGold.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: const Icon(Icons.remove, size: 18, color: kGold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    child: Text(
                                      '$quantity',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: kCharcoal,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () => setState(() => _addToCart(itemId)),
                                    child: Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        color: kGold,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: const Icon(Icons.add, size: 18, color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
            // Bottom Section
            if (cartItems.isNotEmpty)
              Container(
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
                child: Column(
                  children: [
                    // Special Instructions
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Special instructions (optional)',
                        hintStyle: const TextStyle(fontSize: 13, color: kGray),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: kGold),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: kGold, width: 2),
                        ),
                        contentPadding: const EdgeInsets.all(12),
                      ),
                      maxLines: 2,
                      style: const TextStyle(fontSize: 13, color: kCharcoal),
                    ),
                    const SizedBox(height: 12),
                    // Delivery Time
                    Row(
                      children: [
                        const Icon(Icons.access_time, size: 18, color: kGray),
                        const SizedBox(width: 8),
                        const Text(
                          'Delivery Time:',
                          style: TextStyle(fontSize: 13, color: kCharcoal),
                        ),
                        const Spacer(),
                        DropdownButton<String>(
                          value: '30 min',
                          items: ['30 min', '45 min', '1 hour'].map((time) {
                            return DropdownMenuItem(value: time, child: Text(time));
                          }).toList(),
                          onChanged: (value) {},
                          style: const TextStyle(fontSize: 13, color: kCharcoal),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Total
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: kCharcoal,
                          ),
                        ),
                        Text(
                          'LKR ${_cartTotal.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: kGold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Confirm Order Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (selectedRoomNumber == null || selectedRoomNumber!.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please enter your room number'),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }
                          Navigator.pop(context);
                          // Navigate to payment page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PaymentMethodPage(
                                totalAmount: _cartTotal,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kGold,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Confirm Order',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

