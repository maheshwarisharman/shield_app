import 'dart:io';
import 'package:flutter/material.dart';
import 'sign_up_screen.dart';
import 'home_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http/io_client.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();


}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

   HttpClient _createHttpClient() {
    final httpClient = HttpClient();
    httpClient.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return httpClient;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
                if (_isLoading)
          const Opacity(
            opacity: 0.8,
            child: ModalBarrier(dismissible: false, color: Colors.black),
          ),
if (_isLoading)
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image(image: AssetImage('assets/loading.gif')),
              ),
              Center(
                child: CircularProgressIndicator()
              )
            ],
          ),

if(_isLoading == false)

        Scaffold(
        appBar: AppBar(
          title: Text('Login', style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.pinkAccent, 
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            color: Color(0xFFfcaeac),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset('assets/logo.png'),
                    SizedBox(height: 30),
                    TextFormField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.phone_android),
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                  
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 30),
                  
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          // Process the login data
                            setState(() {_isLoading = true;});
                                  
                  
            final String email = _phoneController.text;
            final String password = _passwordController.text;
                  
            print(email);
            print(password);
                  
            final Uri url = Uri.parse('https://women-safety-backend.vercel.app/api/auth/login');
                  
            final ioClient = IOClient(_createHttpClient());
                  
            try {
              final response = await ioClient.post(
                url,
            headers: <String, String>{ 
                'Content-Type': 'application/json; charset=UTF-8', 
              },  
              body: jsonEncode({
                'phoneNumber': email,
                'password': password,
                }),
              );
                  
              print("HELLLLLLOOOO");
                  
              if (response.statusCode == 200) {
                final Map<String, dynamic> responseData = jsonDecode(response.body);
                  
                  
                final String userPhoneNumber = responseData['phoneNumber'];
                final String emergencyContactOne = responseData['emergencyContactOne'];
                final String emergencyContactTwo = responseData['emergencyContactTwo'];
                final String emergencyContactThree = responseData['emergencyContactThree'];
                final String emergencyContactFour = responseData['emergencyContactFour'];
                final String emergencyContactFive = responseData['emergencyContactFive'];
                  
                  
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen(
                      userPhoneNumber: userPhoneNumber,
                      emergencyContactOne: emergencyContactOne,
                      emergencyContactTwo: emergencyContactTwo,
                      emergencyContactThree: emergencyContactThree,
                      emergencyContactFour: emergencyContactFour,
                      emergencyContactFive: emergencyContactFive,
                  
                  )),
                );
              } else {
                final String errorMessage = 'Login id/password is incorrect';
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
            } catch(e){
              print("erriyOO");
              print(e);
            }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        backgroundColor: Colors.pinkAccent, // Button color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account? "),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignUpScreen()),
                            );
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.pinkAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  
                  
                  ],
                ),
              ),
            ),
          ),
        ),
      ),]
    );
  }
}
