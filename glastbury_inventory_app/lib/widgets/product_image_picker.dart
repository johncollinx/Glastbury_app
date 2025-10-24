// lib/widgets/product_image_picker.dart

import 'dart:io'; // Required for the File class
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; 

class ProductImagePicker extends StatefulWidget {
  // The path can be an 'assets/...' string or a device file path.
  final String initialImagePath;
  // Callback returns the path of the selected/captured image
  final ValueChanged<String> onImageSelected; 

  const ProductImagePicker({
    super.key,
    required this.initialImagePath,
    required this.onImageSelected,
  });

  @override
  State<ProductImagePicker> createState() => _ProductImagePickerState();
}

class _ProductImagePickerState extends State<ProductImagePicker> {
  // State to hold the currently selected image path
  String? _currentImagePath;
  final _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // Initialize with the path passed from the form screen
    _currentImagePath = widget.initialImagePath;
  }

  // --- Image Display Logic ---

  // Helper to determine how to display the image based on its path type
  Widget _buildImageWidget() {
    if (_currentImagePath == null) {
      return const Center(child: Icon(Icons.image_not_supported, size: 40, color: Colors.black54));
    }
    
    // 1. Check if the path is a local asset (used for mock data/default)
    if (_currentImagePath!.startsWith('assets/')) {
      return Image.asset(
        _currentImagePath!, 
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Center(child: Icon(Icons.broken_image, size: 40, color: Colors.black54));
        },
      );
    }
    
    // 2. Assume it's a file path saved by image_picker (captured or selected)
    // NOTE: In a production app, you would copy this temporary file to a
    // permanent location (e.g., using path_provider) before saving its path.
    return Image.file(
      File(_currentImagePath!), 
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return const Center(child: Icon(Icons.broken_image, size: 40, color: Colors.black54));
      },
    );
  }

  // --- Image Picking Logic ---
  
  //  Function to call the native picker
  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(
      source: source,
      imageQuality: 50, // Optimize image quality for storage
      maxWidth: 600,
    );

    if (pickedFile != null) {
      setState(() {
        _currentImagePath = pickedFile.path;
      });
      // Update the parent screen's state with the new path
      widget.onImageSelected(_currentImagePath!);
    }
  }

  // Shows a Modal to allow the user to select the source (Camera or Gallery)
  void _showSourceSelection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Wrap(
          children: <Widget>[
            //  Camera Option (Capture)
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Color(0xFF0D47A1)),
              title: const Text('Capture from Camera'),
              onTap: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.camera);
              },
            ),
            //  Gallery Option (Upload)
            ListTile(
              leading: const Icon(Icons.photo_library, color: Color(0xFF0D47A1)),
              title: const Text('Select from Gallery'),
              onTap: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  // --- Build Method ---

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //  Image Preview Area
        Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            shape: BoxShape.circle, // Circular boundary for elegance
            border: Border.all(width: 2, color: Theme.of(context).primaryColor),
          ),
          child: ClipOval(
            child: _buildImageWidget(),
          ),
        ),
        const SizedBox(height: 10),

        //  Button to open the camera/gallery selection
        TextButton.icon(
          onPressed: () => _showSourceSelection(context),
          icon: const Icon(Icons.image_search, color: Colors.redAccent), // Red Accent Icon
          label: Text(
            'Capture or Upload Image', 
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
      ],
    );
  }
}