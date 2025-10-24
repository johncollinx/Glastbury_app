// lib/widgets/inventory_item_card.dart

import 'dart:io';
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/product_category.dart';

class InventoryItemCard extends StatelessWidget {
  final Product product;
  // Define callbacks for CRUD actions (R, U, D)
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

  // Helper to display the image based on whether it's an asset or a file path
  Widget _buildProductImage() {
    if (product.imageUrl.startsWith('assets/')) {
      // Image is a local asset (for mock data)
      return Image.asset(
        product.imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.broken_image, size: 40);
        },
      );
    } else {
      // Image is a file captured/selected by the user
      return Image.file(
        File(product.imageUrl),
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.broken_image, size: 40);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    //  High-contrast design using Card for elegance
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),

        //  Leading Image (Circular for distinction)
        leading: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 2, color: product.category.color),
          ),
          child: ClipOval(
            child: _buildProductImage(),
          ),
        ),

        //  Title and Subtitle (Name and Category)
        title: Text(
          product.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.bodyLarge!.color,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            // Category Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: product.category.color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                product.category.displayName,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: product.category.color,
                ),
              ),
            ),
            const SizedBox(height: 4),
            // Price and SKU
            Text(
              'SKU: ${product.sku}',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),

        //  Trailing Info (QTY and Price)
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // QTY (Highlighted based on stock)
            Text(
              'QTY: ${product.quantity}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                // Highlight Low Stock (Red)
                color: product.quantity < 20 ? Colors.red : Colors.green, 
              ),
            ),
            const SizedBox(height: 4),
            // Price
            Text(
              '\$${product.price.toStringAsFixed(2)}',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).primaryColor, // Deep Blue price
              ),
            ),
          ],
        ),
        
        //  On tap leads to the Detail View (R)
        onTap: onViewDetail,
        
        //  Action Buttons (Edit and Delete)
        isThreeLine: true,
        
        // Secondary action row (Edit/Delete)
        // Note: For a true elegant look, these actions are often better placed
        // in a separate row or using a Dismissible widget, but we use an 
        // ActionRow for clarity here.
        
        // For simplicity and adherence to standard list patterns, 
        // we'll use a trailing icon button for primary action (Edit) 
        // and handle Delete via a swipe or context menu in a full implementation. 
        // For this example, we place the options below using an ExpansionTile for elegance:
      ),
      
      // Separate row for CRUD actions using a Divider for clarity
      child: Column(
        children: [
          ListTile(
            onTap: onViewDetail,
            title: Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('QTY: ${product.quantity} | \$${product.price.toStringAsFixed(2)}'),
            leading: SizedBox(width: 60, height: 60, child: _buildProductImage()),
            trailing: IconButton(
              icon: const Icon(Icons.info_outline, color: Colors.grey),
              onPressed: onViewDetail,
            ),
          ),
          
          // Action Buttons Row
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //  Edit Button (Update - U)
                TextButton.icon(
                  icon: Icon(Icons.edit, size: 20, color: Theme.of(context).primaryColor),
                  label: const Text('EDIT'),
                  onPressed: onEdit,
                ),
                const SizedBox(width: 10),
                //  Delete Button (Delete - D)
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