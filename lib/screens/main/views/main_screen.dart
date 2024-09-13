import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'package:my_windows_app/constants.dart';
import 'package:my_windows_app/route/route_constants.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onLogin() {
    if (_formKey.currentState!.validate()) {}
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Stack(
            children: [
              // Show image as background. Full Width and Full height. URL assets/images/full_color.jpg
              Image.asset(
                'assets/images/full_color.png',
                width: width,
                height: height,
                fit: BoxFit.cover,
              ),

              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.4),
                ),
                width: width,
                height: height,
              ),

              Container(
                  padding: const EdgeInsets.only(
                    left: defaultPadding / 2,
                    right: defaultPadding / 2,
                    top: defaultPadding / 4,
                    bottom: defaultPadding / 4,
                  ),
                  width: 400,
                  // margin auto
                  margin: EdgeInsets.only(
                      left: (width - 400) / 2, top: (height - 400) / 3),
                  child: Column(
                    children: [
                      const Text(
                        "Main Page",
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 217, 102),
                          // Shadows
                          shadows: [
                            Shadow(
                              color: Color.fromRGBO(0, 0, 0, 0.8),
                              offset: Offset(2, 2),
                              blurRadius: 2,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 50),
                      // Buttons : Data Entry, Search Page, Low Down, Exit
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, dataEntryScreenRoute);
                        },
                        child: const Text('Data Entry'),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, mainScreenRoute);
                        },
                        child: const Text('Search Page'),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, mainScreenRoute);
                        },
                        child: const Text('Low Down'),
                      ),
                      const SizedBox(height: 100),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, mainScreenRoute);
                        },
                        child: const Text('Exit'),
                      ),
                    ],
                  )),
            ],
          ),
        ],
      )),
    );
  }
}
