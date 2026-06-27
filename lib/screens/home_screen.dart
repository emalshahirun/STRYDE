import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product_model.dart';
import '../providers/cart_provider.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import 'product_details_screen.dart';
import 'cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = 'All';
  String _searchQuery = '';

  final List<String> _categories = ['All', 'Electronics', 'Accessories', 'Shoes'];

  @override
  Widget build(BuildContext context) {
    const Color backgroundColor = Color(0xFF121212);
    const Color cardColor = Color(0xFF1A1A1A);
    const Color primaryYellow = Color(0xFFFBB000);

    // Filter products based on Category and Search Query
    final filteredProducts = mockProducts.where((product) {
      final matchesCategory = _selectedCategory == 'All' || product.category == _selectedCategory;
      final matchesSearch = product.name.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: const Text(
          'STRYDE Shop',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 24),
        ),
        actions: [
          // Cart Icon with dynamic badge count
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_bag_outlined, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartScreen()),
                  );
                },
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Consumer<CartProvider>(
                  builder: (context, cart, child) {
                    return cart.itemCount > 0
                        ? Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: primaryYellow,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                      child: Text(
                        '${cart.itemCount}',
                        style: const TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    )
                        : const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search products...',
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                fillColor: cardColor,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // 2. Horizontal Category Filter
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 16),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = _selectedCategory == category;
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ChoiceChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                    selectedColor: primaryYellow,
                    backgroundColor: cardColor,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.black : Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),

          // 3. Product Grid
          Expanded(
            child: filteredProducts.isEmpty
                ? const Center(child: Text('No products found', style: TextStyle(color: Colors.grey)))
                : GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return GestureDetector(
                  onTap: () {
                    // Navigate to product detail
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailsScreen(product: product),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product Image
                        Expanded(
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                                  image: DecorationImage(
                                    image: AssetImage(product.imageUrl),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              // Add to Cart shortcut button
                              Positioned(
                                right: 8,
                                bottom: 8,
                                child: CircleAvatar(
                                  backgroundColor: primaryYellow,
                                  radius: 18,
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    icon: const Icon(Icons.add, color: Colors.black, size: 20),
                                    onPressed: () {
                                      context.read<CartProvider>().addToCart(product);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('${product.name} added to cart!'),
                                          duration: const Duration(seconds: 1),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        // Product Text Info
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '\$${product.price.toStringAsFixed(2)}',
                                    style: const TextStyle(color: primaryYellow, fontWeight: FontWeight.w900, fontSize: 14),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.star, color: Colors.amber, size: 14),
                                      const SizedBox(width: 2),
                                      Text(
                                        '${product.rating}',
                                        style: const TextStyle(color: Colors.grey, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: -1, // No selection for HomeScreen
        onTap: (index) {
          if (index == 1) {
            // Navigate to Cart Screen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CartScreen()),
            );
          } else if (index == 2) {
            // Navigate to Profile Screen (not implemented)
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Profile screen not implemented yet!')),
            );
          }
        },
      )
    );
  }
}