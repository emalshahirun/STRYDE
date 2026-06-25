class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final double rating;
  final String category;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
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
    imageUrl: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500',
    rating: 4.5,
    category: 'Electronics',
  ),
  Product(
    id: '2',
    name: 'Minimalist Watch',
    description: 'Elegant minimalist watch with a genuine leather strap and water resistance.',
    price: 149.50,
    imageUrl: 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500',
    rating: 4.8,
    category: 'Accessories',
  ),
  Product(
    id: '3',
    name: 'Running Shoes',
    description: 'Lightweight and breathable running shoes designed for ultimate comfort and speed.',
    price: 79.99,
    imageUrl: 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=500',
    rating: 4.3,
    category: 'Shoes',
  ),
];