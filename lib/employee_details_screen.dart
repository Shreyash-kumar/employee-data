import 'package:flutter/material.dart';
import 'package:employee_data/welcome_screen.dart';
import 'main.dart';
import 'database_helper.dart';


class employeeDetails extends StatefulWidget {
  static const String id = 'employeeDetails';
  @override
  _employeeDetailsState createState() => _employeeDetailsState();
}

class _employeeDetailsState extends State<employeeDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: Material(
            elevation: 2.0,
            child: Padding(
              padding: EdgeInsets.only(
                  left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Employee Data',
                    style: TextStyle(
                      color: Color(0xFFFF5A5F),
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Image(
                    image: AssetImage('images/teamwork.png'),
                    height: 25.0,
                    width: 25.0,
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(25.0),
          child: Center(
            child: Column(
              children: [
                Text(
                  'Employee Name : $currentEmployee',
                  style: textstyle,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'Age : ${mapDataAge[currentEmployee]}',
                  style: textstyle,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'Gender : ${mapDataGender[currentEmployee]}',
                  style: textstyle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

const textstyle = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.w400,
);
