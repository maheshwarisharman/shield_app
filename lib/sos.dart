import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http/io_client.dart';


class SOSPage extends StatefulWidget {

  final String emergencyContactOne;
  final String emergencyContactTwo;
  final String emergencyContactThree;
  final String emergencyContactFour;
  final String emergencyContactFive;

  SOSPage({ required this.emergencyContactOne, required this.emergencyContactTwo, required this.emergencyContactThree, required this.emergencyContactFour, required this.emergencyContactFive});


  @override
  _SOSPageState createState() => _SOSPageState();
}

class _SOSPageState extends State<SOSPage> {
  bool isSOSActive = false;

    HttpClient _createHttpClient() {
    final httpClient = HttpClient();
    httpClient.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return httpClient;
  }
  
  sendRequest() async {
    // Prepare the data
      
      
        // Replace with your API endpoint
        final Uri url = Uri.parse('https://women-safety-backend.vercel.app/api/auth/sendsms');
      
        final ioClient = IOClient(_createHttpClient());
      
        // Prepare the request
        try {
          final response = await ioClient.post(
            url,
        headers: <String, String>{ 
            'Content-Type': 'application/json; charset=UTF-8', 
          },  
          body: jsonEncode({
            'emergencyContactOne': widget.emergencyContactOne,
            'emergencyContactTwo': widget.emergencyContactTwo,
            'emergencyContactThree': widget.emergencyContactThree,
            'emergencyContactFour': widget.emergencyContactFour,
            'emergencyContactFive': widget.emergencyContactFive
            }),
          );
      
          print("HELLLLLLOOOO");
          final Map<String, dynamic> responseData = jsonDecode(response.body);
      
          if (responseData['message'] == 'Success' || response.statusCode == 200) {
            // If the server returns a 200 OK response, parse the JSON.
            final String errorMessage = 'Login id/password is incorrect';
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Alert Singles Sent Successfully!'),
                content: Text(errorMessage),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              ),);
      
            // Handle successful login
            // For example, navigate to the HomeScreen
          } else {
            // Handle errors (e.g., wrong credentials)
            final String errorMessage = 'Sorry something went wrong!';
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Error'),
                content: Text(errorMessage),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
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

  initState() {
    print("initState Called");
  sendRequest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SOS"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Icon(
              Icons.sos,
              size: 100,
              color: isSOSActive ? Colors.red : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}