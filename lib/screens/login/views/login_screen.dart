import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'package:my_windows_app/constants.dart';
import 'package:my_windows_app/route/route_constants.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  // username and password
  String? _username;
  String? _password;
  // remember me
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onLogin() async {
    if (_formKey.currentState!.validate()) {
      // call backend api
      final requestBody = {
        "username": _username,
        "password": _password,
      };

      // Convert the request body to a JSON string
      final jsonString = json.encode(requestBody);

      // Example API request
      final response = await http.post(
        Uri.parse('$backendUrl/signin'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonString,
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login successful'),
            backgroundColor: Colors.green,
          ),
        );

        // Navigate to HomeScreen
        Navigator.pushNamed(context, mainScreenRoute);
      } else {
        // Show the error message from the API. I only want to show the error message
        final Map<String, dynamic> body =
            json.decode(response.body) as Map<String, dynamic>;

        final List<String> errors =
            body.entries.map((entry) => '${entry.value}').toList();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to login: ${errors.join(', ')}'),
            backgroundColor: Colors.red,
          ),
        );
      }
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
                              onChanged: (value) {
                                setState(() {
                                  _username = value;
                                });
                              },
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: "Username is required"),
                              ]).call,
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: "Password",
                              ),
                              obscureText: true,
                              onChanged: (value) {
                                setState(() {
                                  _password = value;
                                });
                              },
                              validator: RequiredValidator(
                                      errorText: "Password is required")
                                  .call,
                            ),
                            const SizedBox(height: 20),
                            // Gradient button from top black to bottom white
                            ElevatedButton(
                              onPressed: _onLogin,
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  const Color.fromARGB(255, 0, 0, 0),
                                ),
                                padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(
                                    vertical: 20,
                                    horizontal: 20,
                                  ),
                                ),
                              ),
                              child: const Text("Login"),
                            ),
                            const SizedBox(height: 20),
                            // Remember me
                            Row(
                              children: [
                                Checkbox(
                                    value: _rememberMe,
                                    onChanged: (value) {
                                      setState(() {
                                        _rememberMe = value!;
                                      });
                                    }),
                                const Text(
                                  "Remember me",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
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
