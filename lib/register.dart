import 'dart:io';
import 'home_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http/io_client.dart';


class AddContact extends StatefulWidget {
  final String phoneNumber;
  final String password;

  AddContact({required this.phoneNumber, required this.password});

  @override
  _AddContactState createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  // List to hold the contact numbers
  List<String> emergencyContacts = List<String>.filled(5, '', growable: false);

  bool _isLoading = false;

  HttpClient _createHttpClient() {
    final httpClient = HttpClient();
    httpClient.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return httpClient;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hide the debug banner
      home: Stack(
        children: [
          if (_isLoading)
            const Opacity(
              opacity: 0.8,
              child: ModalBarrier(dismissible: false, color: Colors.black),
            ),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
          if(_isLoading == false)
          Scaffold(
            appBar: AppBar(
              title: Text('${widget.password}'),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    for (int i = 0; i < emergencyContacts.length; i++)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Emergency Contact ${i + 1}',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            TextField(
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter phone number',
                              ),
                              onChanged: (value) {
                                setState(() {
                                  emergencyContacts[i] = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ElevatedButton(
                      onPressed: () async {
                        // Handle what to do with the emergencyContacts list
                        setState(() {
                          _isLoading = true;
                        });

                        final String emergencyContactOne = emergencyContacts[0];
                        final String emergencyContactTwo = emergencyContacts[1];
                        final String emergencyContactThree =
                            emergencyContacts[2];
                        final String emergencyContactFour =
                            emergencyContacts[3];
                        final String emergencyContactFive =
                            emergencyContacts[4];

                        // Replace with your API endpoint
                        final Uri url = Uri.parse(
                            'https://women-safety-backend.vercel.app/api/auth/register');

                        final ioClient = IOClient(_createHttpClient());

                        // Prepare the request
                        try {
                          final response = await ioClient.post(
                            url,
                            headers: <String, String>{
                              'Content-Type': 'application/json; charset=UTF-8',
                            },
                            body: jsonEncode({
                              'phoneNumber': widget.phoneNumber,
                              'password': widget.password,
                              'emergencyContactOne': emergencyContactOne,
                              'emergencyContactTwo': emergencyContactTwo,
                              'emergencyContactThree': emergencyContactThree,
                              'emergencyContactFour': emergencyContactFour,
                              'emergencyContactFive': emergencyContactFive
                            }),
                          );

                          print("HELLLLLLOOOO");
                          final Map<String, dynamic> responseData =
                              jsonDecode(response.body);
                          print(responseData['message']);
                          print(responseData);

                          if (responseData['message'] ==
                              'User registered successfully') {
                            // If the server returns a 200 OK response, parse the JSON.

                            print("Inside if");
                            final String emergencyContactOne =
                                emergencyContacts[0];
                            final String emergencyContactTwo =
                                emergencyContacts[1];
                            final String emergencyContactThree =
                                emergencyContacts[2];
                            final String emergencyContactFour =
                                emergencyContacts[3];
                            final String emergencyContactFive =
                                emergencyContacts[4];

                            // Handle successful login
                            // For example, navigate to the HomeScreen
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen(
                                        userPhoneNumber:
                                            widget.phoneNumber.toString(),
                                        emergencyContactOne:
                                            emergencyContactOne.toString(),
                                        emergencyContactTwo:
                                            emergencyContactTwo.toString(),
                                        emergencyContactThree:
                                            emergencyContactThree.toString(),
                                        emergencyContactFour:
                                            emergencyContactFour.toString(),
                                        emergencyContactFive:
                                            emergencyContactFive.toString(),
                                      )),
                            );
                          } else {
                            // Handle errors (e.g., wrong credentials)
                            final String errorMessage =
                                'Login id/password is incorrect';
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Error'),
                                content: Text(errorMessage),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      setState(() {
                                        _isLoading = false;
                                      });
                                    },
                                    child: Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          }
                        } catch (e) {
                          print("erriyOO");
                          print(e);
                        }

                        print(emergencyContacts);
                      },
                      child: Text('Save Contacts'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
