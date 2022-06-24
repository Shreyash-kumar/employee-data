import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';


class Employeedata {
  final String name;
  final String gender;
  final String age;

  Employeedata({
    required this.name,
    required this.age,
    required this.gender,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'gender': age,
    };
  }

  @override
  String toString() {
    return 'Employeedata{name: $name, age: $age, gender: $gender}';
  }
}
