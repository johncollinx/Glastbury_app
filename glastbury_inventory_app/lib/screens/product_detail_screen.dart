// lib/screens/product_detail_screen.dart

import 'dart:io';
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/product_category.dart'; // FIX: Required for displayName

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  Widget _buildProductImage() {
    if (product.imageUrl.startsWith('assets/')) {
      return Image.asset(product.imageUrl, fit: BoxFit.cover);
    } else {
      return Image.file(File(product.imageUrl), fit: BoxFit.cover);
    }
  }

  Widget _buildDetailRow(BuildContext context, String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).primaryColor, size: 24),
          const SizedBox(width: 16),
          Expanded(
            flex: 2,
            child: Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.bodyLarge!.color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Header Image Area
            Container(
              height: 250,
              width: double.infinity,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Hero(
                tag: product.id,
                child: _buildProductImage(),
              ),
            ),
            const SizedBox(height: 20),

            // Price Tag
            Center(
              child: Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const Divider(height: 30, thickness: 1),

            // Detailed Info Section
            _buildDetailRow(context, 'Category', product.category.displayName, Icons.category),
            _buildDetailRow(context, 'Quantity in Stock', '${product.quantity}', Icons.format_list_numbered),
            _buildDetailRow(context, 'Stock Keeping Unit (SKU)', product.sku, Icons.vpn_key),
            
            // Low stock alert
            if (product.quantity < 20)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                child: Card(
                  color: Colors.red.withOpacity(0.1),
                  child: const ListTile(
                    leading: Icon(Icons.warning_amber, color: Colors.red),
                    title: Text('Low Stock Alert!', style: TextStyle(color: Colors.red)),
                    subtitle: Text('Reorder this item soon to avoid running out.'),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
