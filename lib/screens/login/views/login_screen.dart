import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'package:my_windows_app/constants.dart';
import 'package:my_windows_app/route/route_constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
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
    if (_formKey.currentState!.validate()) {
      // Navigate to HomeScreen
      Navigator.pushNamed(context, mainScreenRoute);
    }
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
                  padding: const EdgeInsets.only(
                    left: defaultPadding / 2,
                    right: defaultPadding / 2,
                    top: defaultPadding / 4,
                    bottom: defaultPadding / 4,
                  ),
                  width: 400,
                  // margin auto
                  margin: EdgeInsets.only(
                      left: (width - 400) / 2, top: (height - 400) / 2),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        "Golden Eye",
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 217, 102),
                          // Shadows
                          shadows: [
                            Shadow(
                              color: Color.fromRGBO(0, 0, 0, 0.5),
                              offset: Offset(2, 2),
                              blurRadius: 2,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: "Username",
                              ),
                              // validator: MultiValidator([
                              //   RequiredValidator(
                              //       errorText: "Username is required"),
                              //   EmailValidator(
                              //       errorText: "Enter a valid username"),
                              // ]).call,
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: "Password",
                              ),
                              // validator: RequiredValidator(
                              //         errorText: "Password is required")
                              //     .call,
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                _onLogin();
                              },
                              child: const Text("Login"),
                            ),
                            const SizedBox(height: 20),
                            // Remember me
                            Row(
                              children: [
                                Checkbox(value: false, onChanged: (value) {}),
                                const Text("Remember me"),
                              ],
                            ),
                          ],
                        ),
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
