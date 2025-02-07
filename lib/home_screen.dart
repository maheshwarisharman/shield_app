import 'package:flutter/material.dart';
import 'sos.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'help_screen.dart';
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'emergency_contact.dart';




class HomeScreen extends StatefulWidget {

  final String userPhoneNumber;
  final String emergencyContactOne;
  final String emergencyContactTwo;
  final String emergencyContactThree;
  final String emergencyContactFour;
  final String emergencyContactFive;



  HomeScreen({required this.userPhoneNumber, required this.emergencyContactOne, required this.emergencyContactTwo, required this.emergencyContactThree, required this.emergencyContactFour, required this.emergencyContactFive});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

      HttpClient _createHttpClient() {
    final httpClient = HttpClient();
    httpClient.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return httpClient;
  }

  Position? _currentPosition;


  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, request users to enable it.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try requesting permissions again.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    } 

    // When we reach here, permissions are granted and we can get the position of the device.
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    
    setState(() {
      _currentPosition = position;
    });
    print(_currentPosition);
    sendRequest(_currentPosition!.latitude, _currentPosition!.longitude);
  }



  sendRequest(latitude, longitude) async {
    // Prepare the data
      
      
        // Replace with your API endpoint
        final Uri url = Uri.parse('https://women-safety-backend.vercel.app/api/auth/sendsms');
      
        final ioClient = IOClient(_createHttpClient());

        final maplink = 'https://www.google.com/maps?q=' + latitude.toString() + ',+' + longitude.toString();
      
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
            'emergencyContactFive': widget.emergencyContactFive,
            'locationLink': maplink
            }),
          );
      
          print("HELLLLLLOOOO");
          final Map<String, dynamic> responseData = jsonDecode(response.body);
          print(responseData);
      
            // If the server returns a 200 OK response, parse the JSON.
            final String errorMessage = 'SOS messages sent successfully!';
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Successfull!'),
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

           
        } catch(e){
          print("erriyOO");
          print(e);
        }
  }



  final ImagePicker _picker = ImagePicker();

  Future<void> _openCamera() async {
    final XFile? video = await _picker.pickVideo(source: ImageSource.camera);
    if (video != null) {
      File savedVideo = await _saveVideoLocally(video);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Video saved to: ${savedVideo.path}')),
      );
    }
  }

  Future<File> _saveVideoLocally(XFile video) async {
    final Directory? dcimDir = await getApplicationDocumentsDirectory();
    print(dcimDir!.path);
    final String dcimPath = path.join(dcimDir!.path);
    await Directory(dcimPath).create(recursive: true);
        final String filePath = path.join(dcimPath, path.basename(video.path));
        return File(video.path).copy(filePath);
  }



  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor:  Colors.pinkAccent,
      title: TextButton(onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) => HelpScreen()),
                  );},child: Text("Help?", style: TextStyle(fontSize: 25, color: Colors.white),),
      ),),
      body: Container(
          color: Color(0xFFfcaeac),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [ ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                      builder: (context) => SOSPage(
                              emergencyContactOne: widget.emergencyContactOne,
                                          emergencyContactTwo: widget.emergencyContactTwo,
                                          emergencyContactThree: widget.emergencyContactThree,
                                          emergencyContactFour: widget.emergencyContactFour,
                                          emergencyContactFive: widget.emergencyContactFive,
                      )),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(36),
                    backgroundColor: Color(0xFFb50f00)
                  ),
                  child: Text(
                    'SOS',
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                ),
        
                SizedBox(width: 30), 
                
        
                ElevatedButton(
                    onPressed: () {
                        _getCurrentLocation();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(34),
                      backgroundColor: Colors.black
                    ),
                    child: Icon(
                      Icons.location_on,
                      size: 50,
                      color: Colors.red,
                    ),
                  ),
                
                ]
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      print("Helllo");
                      _openCamera();
        
                    },
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(34),
                      backgroundColor: Color(0xFF595fff)
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 30), 
                  
                  ElevatedButton(
                    onPressed: () {

                      Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) => EmergencyContact()),
                  );


                    },
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(34),
                      backgroundColor: Color.fromARGB(255, 177, 41, 23)
                    ),
                    child: Icon(
                      Icons.phone,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),



            ],
          ),




        ),
      ),
    );
  }
}
