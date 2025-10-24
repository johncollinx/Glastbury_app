// lib/screens/inventory_list_screen.dart

import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/product_category.dart';
import '../widgets/inventory_item_card.dart';
import '../screens/product_detail_screen.dart';
import '../screens/product_form_screen.dart'; 
import '../helpers/db_helper.dart'; 
import '../data/mock_products.dart'; 
import '../widgets/main_drawer.dart'; // Add the drawer

class InventoryListScreen extends StatefulWidget {
  const InventoryListScreen({super.key});

  @override
  State<InventoryListScreen> createState() => _InventoryListScreenState();
}

class _InventoryListScreenState extends State<InventoryListScreen> {
  List<Product> _inventory = [];
  bool _isLoading = true; 
  ProductCategory? _selectedCategory; 

  @override
  void initState() {
    super.initState();
    _loadInventory();
  }

  // 🚀 R (Read): Loads data from SQLite, seeds mock data if empty
  Future<void> _loadInventory() async {
    setState(() { _isLoading = true; });

    final dataList = await DBHelper.getData();
    List<Product> loadedInventory;
    
    if (dataList.isEmpty) {
      // 💡 Seed the database if no data exists
      loadedInventory = mockInventory;
      for (var product in loadedInventory) {
        // Ensure the category is correctly stored as a string
        await _insertProductIntoDB(product);
      }
    } else {
      // Map DB results back to Product objects
      loadedInventory = dataList.map((item) {
        return Product(
          id: item['id'] as String,
          name: item['name'] as String,
          quantity: item['quantity'] as int,
          price: item['price'] as double,
          imageUrl: item['imageUrl'] as String,
          sku: item['sku'] as String,
          // Convert the stored string back to the Enum
          category: ProductCategory.values.firstWhere(
            (e) => e.toString() == item['category']
          ), 
        );
      }).toList();
    }

    setState(() {
      _inventory = loadedInventory;
      _isLoading = false;
    });
  }

  // Helper method for insertion/update logic (used by C/U)
  Future<void> _insertProductIntoDB(Product product) async {
    await DBHelper.insert({
      'id': product.id,
      'name': product.name,
      'quantity': product.quantity,
      'price': product.price,
      'imageUrl': product.imageUrl,
      'sku': product.sku,
      // Store the Enum as a string
      'category': product.category.toString(), 
    });
  }

  // 🚀 C & U Navigation
  void _openProductForm({Product? product}) async {
    final result = await Navigator.of(context).push<Product>(
      MaterialPageRoute(
        builder: (ctx) => ProductFormScreen(product: product),
      ),
    );

    if (result != null) {
      final isNew = product == null;

      // 1. Write to the database
      await _insertProductIntoDB(result);

      // 2. Reload the inventory to update UI
      _loadInventory(); 

      // Visual feedback
       ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(isNew ? 'Item added successfully!' : 'Item updated successfully!')),
      );
    }
  }
  
  // 🚀 R Navigation
  void _viewProductDetail(Product product) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => ProductDetailScreen(product: product),
      ),
    );
  }

  // 🚀 D (Delete)
  void _deleteProduct(String id) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirm Deletion'),
        content: const Text('Are you sure you want to delete this product?'),
        actions: <Widget>[
          TextButton(onPressed: () => Navigator.of(ctx).pop(false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.of(ctx).pop(true), child: const Text('Delete', style: TextStyle(color: Colors.redAccent))),
        ],
      ),
    );

    if (confirmed == true) {
      await DBHelper.delete(id);
      _loadInventory();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Item deleted.')),
      );
    }
  }

  // 💡 Filtering Logic
  List<Product> get _filteredInventory {
    if (_selectedCategory == null) {
      return _inventory;
    }
    return _inventory
        .where((product) => product.category == _selectedCategory)
        .toList();
  }

  // --- UI Implementation ---
  @override
  Widget build(BuildContext context) {
    final displayedInventory = _filteredInventory;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Store Inventory'),
        actions: [
          // 💡 Category Filter Button
          PopupMenuButton<ProductCategory?>(
            onSelected: (ProductCategory? newValue) {
              setState(() {
                _selectedCategory = newValue;
              });
            },
            icon: const Icon(Icons.filter_list),
            itemBuilder: (BuildContext context) => [
              // Show All option
              const PopupMenuItem(
                value: null,
                child: Text('All Products'),
              ),
              // Options for each category
              ...ProductCategory.values.map((category) => PopupMenuItem(
                value: category,
                child: Text(category.displayName),
              )),
            ],
          ),
        ],
      ),
      drawer: const MainDrawer(), // Hamburger menu

      body: _isLoading 
          ? const Center(child: CircularProgressIndicator())
          : displayedInventory.isEmpty
              ? Center(
                  child: Text(
                    _selectedCategory == null 
                        ? 'Inventory is Empty! Add your first item.'
                        : 'No ${_selectedCategory!.displayName} found.',
                    style: TextStyle(fontSize: 18, color: Theme.of(context).textTheme.bodyMedium!.color),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  itemCount: displayedInventory.length,
                  itemBuilder: (ctx, index) {
                    final product = displayedInventory[index];
                    return InventoryItemCard(
                      product: product,
                      onViewDetail: () => _viewProductDetail(product),
                      onEdit: () => _openProductForm(product: product),
                      onDelete: () => _deleteProduct(product.id),
                    );
                  },
                ),
      
      // ➕ Floating Action Button (Red Accent for Add action)
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openProductForm(),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}