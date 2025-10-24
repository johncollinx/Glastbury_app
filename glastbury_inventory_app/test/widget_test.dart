// glastbury_inventory_app/test/widget_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// 💡 IMPORT THE CORRECT MAIN WIDGET
import 'package:glastbury_inventory_app/main.dart'; 
// Note: The package name must match the 'name:' in your pubspec.yaml

void main() {
  testWidgets('Renders the landing screen text', (WidgetTester tester) async {
    
    // 💡 FIX: Use InventoryApp() instead of MyApp()
    await tester.pumpWidget(const InventoryApp());

    // Verify that the "Glastbury Stores" name appears.
    expect(find.text('Glastbury Stores'), findsOneWidget);
    
    // Verify that the Inventory button is rendered.
    expect(find.byIcon(Icons.inventory_2), findsOneWidget);
    
    // Check for the main CTA text
    expect(find.text('View Inventory (Start Here)'), findsOneWidget);
  });
}
