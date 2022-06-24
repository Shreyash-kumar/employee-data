import 'package:employee_data/employee_details_screen.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'main.dart';
import 'database_helper.dart';

late int age;
String gender = '';
late TextEditingController ageController;
late TextEditingController genderController;
var mapDataAge = {};
var mapDataGender = {};
String currentEmployee = '';
List _employee = [];

class welcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<welcomeScreen> {


  Future<void> readJson() async {
    final String response = await rootBundle.loadString('json/User_mock.json');
    final data = await json.decode(response);
    setState(() {
      _employee = data["users"];
    });
  }

  @override
  void initState() {
    super.initState();
    ageController = TextEditingController();
    genderController = TextEditingController();
    readJson();
  }

  @override
  void dispose() {
    ageController.dispose();
    genderController.dispose();
    super.dispose();
  }

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
          child: Column(
            children: [
              // ElevatedButton(
              //   child: const Text('Load Data'),
              //   onPressed: readJson,
              // ),
              _employee.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: _employee.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            child: Card(
                              margin: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Stack(children: [
                                      FlatButton(
                                        onPressed: () {
                                              if (mapDataGender[_employee[index]["name"]] != null) {
                                                currentEmployee =
                                                    _employee[index]["name"];
                                                Navigator.pushNamed(context,
                                                    employeeDetails.id);
                                              } else
                                                print('hi');
                                        },
                                        child: Container(),
                                      ),
                                      Column(
                                        children: [
                                          SizedBox(
                                            height: 20.0,
                                          ),
                                          Text(
                                            _employee[index]["name"],
                                          )
                                        ],
                                      ),
                                    ]),
                                  ),
                                  loginButton(
                                      kname: _employee[index]["name"],
                                      buttonText: mapDataAge[_employee[index]["name"]] != null ?
                                          'Sign-Out':
                                          'Sign-In',
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}

class loginButton extends StatefulWidget {
  loginButton({required this.kname, required this.buttonText });
  String kname;
  String buttonText;


  @override
  State<loginButton> createState() => _loginButtonState();
}

class _loginButtonState extends State<loginButton> {

  bool flag = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: ElevatedButton(
          child: Text(flag?
          'Sign-In':
          'Sign-Out'),
          onPressed: () {
            setState(() {
              flag;
            });
                if (flag) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Enter Your Age and Gender'),
                      content: Column(children: [
                        TextField(
                          autofocus: true,
                          decoration:
                              InputDecoration(hintText: 'Enter your age'),
                          controller: ageController,
                        ),
                        TextField(
                          autofocus: true,
                          decoration:
                              InputDecoration(hintText: 'Enter your gender'),
                          controller: genderController,
                        ),
                      ]),
                      actions: [
                        TextButton(
                            onPressed: ()  {
                              setState(
                                () {
                                  Navigator.of(context).pop();
                                  mapDataAge[widget.kname] = ageController.text;
                                  mapDataGender[widget.kname] =
                                      genderController.text;
                                  currentEmployee = widget.kname;
                                  genderController.clear();
                                  ageController.clear();
                                  Navigator.pushNamed(
                                      context, employeeDetails.id);
                                  flag = false;
                                },
                              );
                            },
                            child: Text('SUBMIT'))
                      ],
                    ),
                  );
                } else{

                }
          },
        ),
      ),
    );
  }
}
