class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imagePath;
  final double rating;
  final String category;

  // Backwards-compatible getter for code using imageUrl
  String get imageUrl => imagePath;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
    required this.rating,
    required this.category,
  });
}

// Mock Data
final List<Product> mockProducts = [
  Product(
    id: '1',
    name: 'Wireless Headphones',
    description: 'High-quality wireless headphones with noise cancellation and 40-hour battery life.',
    price: 99.99,
    imagePath: 'assets/headphones.png',
    rating: 4.5,
    category: 'Electronics',
  ),
  Product(
    id: '2',
    name: 'Minimalist Watch',
    description: 'Elegant minimalist watch with a genuine leather strap and water resistance.',
    price: 149.50,
    imagePath: 'assets/watch.png',
    rating: 4.8,
    category: 'Accessories',
  ),
  Product(
    id: '3',
    name: 'Running Shoes',
    description: 'Lightweight and breathable running shoes designed for ultimate comfort and speed.',
    price: 79.99,
    imagePath: 'assets/shoes.png',
    rating: 4.3,
    category: 'Shoes',
  ),
];