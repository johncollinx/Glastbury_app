// lib/screens/product_form_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

import '../models/product.dart';
import '../models/product_category.dart';
import '../widgets/product_image_picker.dart'; 

class ProductFormScreen extends StatefulWidget {
  // If 'product' is provided, we are in Edit Mode
  final Product? product;

  const ProductFormScreen({super.key, this.product});

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();

  // Text Controllers for input fields
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController();
  final _skuController = TextEditingController();
  
  // State variables for non-text fields
  ProductCategory _selectedCategory = ProductCategory.cosmetics;
  String? _selectedImageUrl; 

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      // Populate fields for editing
      _nameController.text = widget.product!.name;
      _priceController.text = widget.product!.price.toStringAsFixed(2);
      _quantityController.text = widget.product!.quantity.toString();
      _skuController.text = widget.product!.sku;
      _selectedCategory = widget.product!.category;
      _selectedImageUrl = widget.product!.imageUrl;
    } else {
      // Default placeholder for a new product
      _selectedImageUrl = 'assets/images/default_placeholder.png'; 
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    _skuController.dispose();
    super.dispose();
  }

  // 🚀 C & U: Handles form validation and returns the product object
  void _saveProduct() {
    if (_formKey.currentState!.validate() && _selectedImageUrl != null) {
      _formKey.currentState!.save();

      final String id = widget.product?.id ?? const Uuid().v4();

      final newProduct = Product(
        id: id,
        name: _nameController.text,
        price: double.parse(_priceController.text),
        quantity: int.parse(_quantityController.text),
        sku: _skuController.text,
        imageUrl: _selectedImageUrl!,
        category: _selectedCategory,
      );

      // Return the new/updated Product object to InventoryListScreen
      Navigator.of(context).pop(newProduct);
    } else if (_selectedImageUrl == null) {
       ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please capture or select an image.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.product != null;
    final title = isEditing ? 'Edit Product: ${widget.product!.name}' : 'Add New Product';

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          // Save Button styled with Red Accent
          IconButton(
            icon: Icon(Icons.save, color: Theme.of(context).colorScheme.secondary),
            onPressed: _saveProduct,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // 1. Image Picker (Camera/Gallery Feature)
                ProductImagePicker(
                  initialImagePath: _selectedImageUrl!,
                  onImageSelected: (path) {
                    setState(() {
                       _selectedImageUrl = path;
                    });
                  },
                ),
                const SizedBox(height: 16),
                
                // 2. Product Name
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Product Name',
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.inventory_2, color: Color(0xFF0D47A1)),
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (value) => value!.isEmpty ? 'Please enter a name.' : null,
                ),
                const SizedBox(height: 16),

                // 3. Category Dropdown
                DropdownButtonFormField<ProductCategory>(
                  value: _selectedCategory,
                  decoration: const InputDecoration(
                    labelText: 'Product Category',
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.category, color: Color(0xFF0D47A1)),
                  ),
                  items: ProductCategory.values.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category.displayName),
                    );
                  }).toList(),
                  onChanged: (ProductCategory? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _selectedCategory = newValue;
                      });
                    }
                  },
                ),
                const SizedBox(height: 16),
                
                // 4. Price & Quantity
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _priceController,
                        decoration: const InputDecoration(
                          labelText: 'Price',
                          border: OutlineInputBorder(),
                          prefixText: '\$ ',
                        ),
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                        ],
                        validator: (value) => 
                            (value!.isEmpty || double.tryParse(value) == null) ? 'Enter valid price.' : null,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _quantityController,
                        decoration: const InputDecoration(
                          labelText: 'Quantity (QTY)',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (value) => 
                            (value!.isEmpty || int.tryParse(value) == null || int.parse(value) < 0) 
                            ? 'Enter valid QTY.' 
                            : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // 5. SKU
                 TextFormField(
                  controller: _skuController,
                  decoration: const InputDecoration(
                    labelText: 'SKU (Stock ID)',
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.vpn_key, color: Color(0xFF0D47A1)),
                  ),
                  textInputAction: TextInputAction.done,
                  validator: (value) => value!.isEmpty ? 'Please enter an SKU.' : null,
                ),
                const SizedBox(height: 30),

                // Action Buttons
                ElevatedButton.icon(
                  onPressed: _saveProduct,
                  icon: const Icon(Icons.check, color: Colors.white),
                  label: Text(isEditing ? 'Update Item' : 'Save Item'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: Theme.of(context).colorScheme.secondary, // Red for Save
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
