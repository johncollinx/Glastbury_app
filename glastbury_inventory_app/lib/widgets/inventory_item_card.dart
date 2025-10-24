// lib/widgets/inventory_item_card.dart

import 'dart:io';
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/product_category.dart';

class InventoryItemCard extends StatelessWidget {
  final Product product;
  final VoidCallback onViewDetail;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const InventoryItemCard({
    super.key,
    required this.product,
    required this.onViewDetail,
    required this.onEdit,
    required this.onDelete,
  });

  Widget _buildProductImage() {
    if (product.imageUrl.startsWith('assets/')) {
      return Image.asset(product.imageUrl, fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 40));
    } else {
      return Image.file(File(product.imageUrl), fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 40));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      
      // FIX: Ensure only one child, using Column to stack ListTile and Action buttons
      child: Column( 
        mainAxisSize: MainAxisSize.min,
        children: [
          // 1. Primary Information Display
          ListTile(
            onTap: onViewDetail,
            contentPadding: const EdgeInsets.all(10),
            leading: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 2, color: product.category.color),
              ),
              child: ClipOval(child: _buildProductImage()),
            ),
            title: Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: product.category.color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    product.category.displayName,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: product.category.color),
                  ),
                ),
                const SizedBox(height: 4),
                Text('SKU: ${product.sku}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'QTY: ${product.quantity}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: product.quantity < 20 ? Colors.redAccent : Colors.green, 
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: TextStyle(fontWeight: FontWeight.w600, color: Theme.of(context).primaryColor),
                ),
              ],
            ),
          ),
          
          // 2. Action Buttons Row
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  icon: Icon(Icons.edit, size: 20, color: Theme.of(context).primaryColor),
                  label: const Text('EDIT'),
                  onPressed: onEdit,
                ),
                const SizedBox(width: 10),
                TextButton.icon(
                  icon: const Icon(Icons.delete_outline, size: 20, color: Colors.redAccent),
                  label: const Text('DELETE', style: TextStyle(color: Colors.redAccent)),
                  onPressed: onDelete,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
