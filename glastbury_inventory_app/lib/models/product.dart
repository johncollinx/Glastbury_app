// lib/models/product.dart

import 'product_category.dart'; // Import the new category enum

class Product {
  // 💡 Primary Key for SQLite: Unique ID for CRUD operations.
  final String id; 
  
  // Core Inventory Data
  final String name;
  final int quantity; // Required for inventory tracking (QTY)
  final double price;
  final String sku; // Stock Keeping Unit (unique identifier, but not the primary key here)
  
  // Media and Category
  final String imageUrl; // Path to the image (local asset or file path)
  final ProductCategory category; // The specific category enum

  // 💡 Constructor requires all essential fields for integrity
  Product({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
    required this.imageUrl,
    required this.sku,
    required this.category,
  });

  // 🚀 copyWith: Creates a new Product instance with specified fields updated.
  // This is a crucial pattern for efficient state management with immutable objects.
  Product copyWith({
    String? id,
    String? name,
    int? quantity,
    double? price,
    String? imageUrl,
    String? sku,
    ProductCategory? category,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      sku: sku ?? this.sku,
      category: category ?? this.category,
    );
  }
}
