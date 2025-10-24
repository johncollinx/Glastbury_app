// lib/widgets/main_drawer.dart

import 'package:flutter/material.dart';
import '../screens/inventory_list_screen.dart'; 
import '../screens/settings_screen.dart';      

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  // Helper method for drawing consistent, elegant list tiles
  Widget _buildListTile(
    String title,
    IconData icon,
    VoidCallback onTapHandler,
    BuildContext context,
    {bool isBold = false, bool isAccent = false}
  ) {
    return ListTile(
      // Icons use the Deep Blue primary color
      leading: Icon(icon, size: 26, color: Theme.of(context).primaryColor), 
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 20,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          // Text color adjusts for dark/light theme
          color: isAccent ? Colors.redAccent : Theme.of(context).textTheme.bodyLarge!.color, 
        ),
      ),
      onTap: onTapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          // 💡 Drawer Header (Branding using Deep Blue)
          Container(
            height: 120,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).primaryColor, 
            child: const Text(
              'Glastbury Stores',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30,
                color: Colors.white, // White text on blue background
              ),
            ),
          ),
          const SizedBox(height: 20),
          
          // 1. Inventory Management (The main feature)
          _buildListTile(
            'Inventory Management',
            Icons.inventory_2,
            () {
              // Replace the current screen to avoid stacking (or navigate fresh)
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (ctx) => const InventoryListScreen()),
              );
            },
            context,
            isBold: true
          ),

          const Divider(),

          // 2. Placeholder: Admin Sign Up & Login (Placeholder for future feature)
          _buildListTile(
            'Admin Sign Up & Login',
            Icons.admin_panel_settings,
            () {
              Navigator.of(context).pop(); // Close drawer
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Admin Page Placeholder')),
              );
            },
            context,
            isAccent: true // Use Red accent to highlight administrative access
          ),

          // 3. Placeholder: About Us
          _buildListTile(
            'About Glastbury Stores',
            Icons.info_outline,
            () {
              Navigator.of(context).pop(); 
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('About Us Page Placeholder')),
              );
            },
            context
          ),

          // 4. Placeholder: Contact Us
          _buildListTile(
            'Contact Us',
            Icons.phone,
            () {
              Navigator.of(context).pop(); 
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Contact Page Placeholder')),
              );
            },
            context
          ),

          const Divider(),

          // 5. Settings Button (Leads to theme toggle)
          _buildListTile(
            'Settings',
            Icons.settings,
            () {
              Navigator.of(context).pop(); // Close drawer
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => const SettingsScreen()),
              );
            },
            context
          ),
        ],
      ),
    );
  }
}