// lib/models/product_category.dart

import 'package:flutter/material.dart'; // Import for color utilities

// 💡 Enum to define the allowed product categories
enum ProductCategory {
  cosmetics,
  eyewear,
  snacks,
}

// 💡 Extension methods to provide user-friendly names, colors, and asset prefixes.
extension ProductCategoryExtension on ProductCategory {
  // Returns a readable, capitalized name for the UI.
  String get displayName {
    switch (this) {
      case ProductCategory.cosmetics:
        return 'Cosmetics';
      case ProductCategory.eyewear:
        return 'Eyewear';
      case ProductCategory.snacks:
        return 'Snacks';
    }
  }

  // Returns a color hint for use in category labels or badges (Red/Blue/Accent).
  Color get color {
    switch (this) {
      case ProductCategory.cosmetics:
        return Colors.pink; // Standard accent for cosmetics
      case ProductCategory.eyewear:
        return const Color(0xFF0D47A1); // Deep Blue Primary
      case ProductCategory.snacks:
        return Colors.redAccent; // Red Accent
    }
  }

  // Helper for generating image asset paths specific to the category.
  String get assetPrefix {
    switch (this) {
      case ProductCategory.cosmetics:
        return 'cosmetic';
      case ProductCategory.eyewear:
        return 'eyewear';
      case ProductCategory.snacks:
        return 'snack';
    }
  }
}
