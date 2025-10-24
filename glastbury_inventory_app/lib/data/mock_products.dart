// lib/data/mock_products.dart

import 'package:uuid/uuid.dart';
import '../models/product.dart';
import '../models/product_category.dart';

// Helper to generate unique IDs
final uuid = const Uuid();

// 💡 10 Unique Products across the three required categories for DB seeding
final List<Product> mockInventory = [
  // ------------------------------------
  // --- COSMETICS (4 Items)
  // ------------------------------------
  Product(
    id: uuid.v4(),
    name: 'Azure Eyeshadow Palette',
    quantity: 75,
    price: 34.99,
    category: ProductCategory.cosmetics,
    imageUrl: 'assets/images/cosmetic_01.png', 
    sku: 'COS001'
  ),
  Product(
    id: uuid.v4(),
    name: 'Ruby Red Velvet Lipstick',
    quantity: 120,
    price: 19.50,
    category: ProductCategory.cosmetics,
    imageUrl: 'assets/images/cosmetic_02.png',
    sku: 'COS002'
  ),
  Product(
    id: uuid.v4(),
    name: 'Jet Black Waterproof Eyeliner',
    quantity: 88,
    price: 14.00,
    category: ProductCategory.cosmetics,
    imageUrl: 'assets/images/cosmetic_03.png',
    sku: 'COS003'
  ),
  Product(
    id: uuid.v4(),
    name: 'White Clay Detox Mask',
    quantity: 30,
    price: 45.99,
    category: ProductCategory.cosmetics,
    imageUrl: 'assets/images/cosmetic_04.png',
    sku: 'COS004'
  ),

  // ------------------------------------
  // --- EYEWEAR (3 Items)
  // ------------------------------------
  Product(
    id: uuid.v4(),
    name: 'Glastbury Classic Blue Aviators',
    quantity: 12,
    price: 120.00,
    category: ProductCategory.eyewear,
    imageUrl: 'assets/images/eyewear_01.png',
    sku: 'EYE001'
  ),
  Product(
    id: uuid.v4(),
    name: 'Crimson Red Framed Readers',
    quantity: 55,
    price: 35.95,
    category: ProductCategory.eyewear,
    imageUrl: 'assets/images/eyewear_02.png',
    sku: 'EYE002'
  ),
  Product(
    id: uuid.v4(),
    name: 'Midnight Blackout Sunglasses',
    quantity: 22,
    price: 98.50,
    category: ProductCategory.eyewear,
    imageUrl: 'assets/images/eyewear_03.png',
    sku: 'EYE003'
  ),

  // ------------------------------------
  // --- SNACKS (3 Items)
  // ------------------------------------
  Product(
    id: uuid.v4(),
    name: 'Premium 85% Dark Chocolate Bar',
    quantity: 210,
    price: 4.99,
    category: ProductCategory.snacks,
    imageUrl: 'assets/images/snack_01.png',
    sku: 'SNA001'
  ),
  Product(
    id: uuid.v4(),
    name: 'Spicy Red Chili Pepper Chips',
    quantity: 90,
    price: 3.25,
    category: ProductCategory.snacks,
    imageUrl: 'assets/images/snack_02.png',
    sku: 'SNA002'
  ),
  Product(
    id: uuid.v4(),
    name: 'Blueberry Yogurt Almond Bites',
    quantity: 150,
    price: 5.75,
    category: ProductCategory.snacks,
    imageUrl: 'assets/images/snack_03.png',
    sku: 'SNA003'
  ),
];
