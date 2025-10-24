// lib/screens/landing_screen.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'inventory_list_screen.dart';
import '../widgets/main_drawer.dart'; 

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});
  
  static const String storeName = 'Glastbury Stores';
  static const String storeDescription = 'Your trusted local ledger for fine goods.';

  Widget _buildBody(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Store Name (Deep Blue, Elegant Font)
            Text(
              storeName,
              style: GoogleFonts.lato(
                fontSize: 48,
                fontWeight: FontWeight.w900,
                color: Theme.of(context).primaryColor, 
              ),
            ),
            const SizedBox(height: 10),

            // Store Description (Serif Font for Elegance)
            Text(
              storeDescription,
              textAlign: TextAlign.center,
              style: GoogleFonts.merriweather( 
                fontSize: 18,
                fontStyle: FontStyle.italic,
                color: Theme.of(context).textTheme.bodyMedium!.color,
              ),
            ),
            const SizedBox(height: 60),

            // 💡 Placeholder Call to Action Button (Red Accent)
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('New Arrivals CTA Tapped! (Placeholder)')),
                );
              },
              icon: const Icon(Icons.star_outline),
              label: const Text('New Arrivals & Promos'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(250, 55),
                backgroundColor: Theme.of(context).colorScheme.secondary, // Red Accent
                foregroundColor: Colors.white,
                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),

            // Inventory Button (Deep Blue Primary Navigation)
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const InventoryListScreen()),
                );
              },
              icon: const Icon(Icons.inventory_2),
              label: const Text('View Inventory (Start Here)'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(250, 55),
                backgroundColor: Theme.of(context).primaryColor, // Deep Blue
                foregroundColor: Colors.white,
                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
      ),
      drawer: const MainDrawer(), // Hamburger Menu
      body: _buildBody(context),
    );
  }
}