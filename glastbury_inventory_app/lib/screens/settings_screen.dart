// lib/screens/settings_screen.dart

import 'package:flutter/material.dart';
import '../main.dart'; // Access to the global theme state
import '../models/product_category.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 💡 Access global state for theme switching
    final appState = InventoryApp.of(context);
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          // 🚀 Theme Switcher Feature
          ListTile(
            title: const Text('Dark Mode'),
            subtitle: Text(isDarkTheme ? 'Enabled (Black Background)' : 'Disabled (White Background)'),
            trailing: Switch(
              value: isDarkTheme,
              onChanged: (bool value) {
                appState.toggleTheme(value);
              },
              activeColor: Theme.of(context).colorScheme.secondary, // Red accent for the switch
            ),
          ),
          const Divider(),

          // Placeholder: Product Categories Display
          ...ProductCategory.values.map((category) => ListTile(
            leading: Icon(Icons.category, color: category.color),
            title: Text(category.displayName),
            trailing: const Icon(Icons.chevron_right, color: Colors.grey),
            onTap: () {
               ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${category.displayName} settings placeholder')),
              );
            }
          )).toList(),
          
          const Divider(),

          // Placeholder: Data Backup Essential
          ListTile(
            leading: Icon(Icons.backup, color: Theme.of(context).primaryColor),
            title: const Text('Database Backup'),
            subtitle: const Text('Backup local SQLite data'),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Backup Function Placeholder')),
              );
            }
          ),
        ],
      ),
    );
  }
}
