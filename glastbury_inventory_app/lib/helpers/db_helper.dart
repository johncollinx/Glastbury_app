// lib/helpers/db_helper.dart

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/product_category.dart'; // Needed for category conversion

class DBHelper {
  // Define the table name and column names for easy reference and safety
  static const String _tableName = 'products';
  static const String _colId = 'id';
  static const String _colName = 'name';
  static const String _colQuantity = 'quantity';
  static const String _colPrice = 'price';
  static const String _colImageUrl = 'imageUrl';
  static const String _colSku = 'sku';
  static const String _colCategory = 'category'; // Stored as TEXT (Enum.toString())

  // 🚀 Method to initialize and open the database connection
  static Future<Database> database() async {
    // Get the platform-specific path where the database file should reside
    final dbPath = await getDatabasesPath();
    
    // Join the path with the database name ('inventory_app.db')
    return openDatabase(
      join(dbPath, 'inventory_app.db'),
      // This function runs only when the database file is first created
      onCreate: (db, version) {
        // 💡 Execute the SQL command to create the 'products' table.
        // TEXT is used for strings, INTEGER for whole numbers, REAL for decimals (price).
        return db.execute(
          '''
          CREATE TABLE $_tableName(
            $_colId TEXT PRIMARY KEY, 
            $_colName TEXT,
            $_colQuantity INTEGER,
            $_colPrice REAL,
            $_colImageUrl TEXT,
            $_colSku TEXT,
            $_colCategory TEXT
          )
          ''',
        );
      },
      // Set the database version (important for future schema migrations)
      version: 1,
    );
  }

  // 🚀 C (Create) and U (Update) helper
  // Uses ConflictAlgorithm.replace to handle both insertion (C) and update (U) 
  // based on the primary key ('id').
  static Future<void> insert(Map<String, Object> data) async {
    final db = await database();
    await db.insert(
      _tableName,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // 🚀 R (Read All) helper
  // Fetches all records from the products table.
  static Future<List<Map<String, dynamic>>> getData() async {
    final db = await database();
    return db.query(_tableName);
  }

  // 🚀 D (Delete) helper
  // Deletes a specific product identified by its ID.
  static Future<void> delete(String id) async {
    final db = await database();
    await db.delete(
      _tableName,
      where: '$_colId = ?', // SQL WHERE clause
      whereArgs: [id], // Arguments to prevent SQL injection
    );
  }
}
