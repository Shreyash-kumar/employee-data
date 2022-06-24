import 'package:employee_data/employee_details_screen.dart';
import 'package:employee_data/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'database_helper.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = openDatabase(
      join(await getDatabasesPath(), 'employee_database.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE employee(name TEXT, age INTEGER, gender TEXT)',
      );
    },
    version: 1,
  );

  Future<void> insertEmployee(Employeedata employeedata ) async {
    final db = await database;
    await db.insert(
      'employeedata',
      employeedata.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }


  Future<List<Employeedata>> employeedata() async {
    final db = await database;


    final List<Map<String, dynamic>> maps = await db.query('employeedata');

    return List.generate(maps.length, (i) {
      return Employeedata(
        name: maps[i]['name'],
        age: maps[i]['age'],
        gender: maps[i]['gender'],
      );
    });
  }

  Future<void> deleteEmployee(int id) async {
    final db = await database;

    await db.delete(
      'employeedata',
      where: 'id = ?',
      whereArgs: [id],
    );
  }




  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: welcomeScreen.id,

      routes: {
        welcomeScreen.id : (context) => welcomeScreen(),
        employeeDetails.id: (context) => employeeDetails(),
      },
    );
  }
}

