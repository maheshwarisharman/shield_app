import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help"),
        backgroundColor:  Colors.pinkAccent,
      ),
      body: Container(
                  color: Color(0xFFfcaeac),

        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                      onPressed: () {
                        // Handle SOS button press
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
                Text("This is used to send distress sms to five selected emergency contacts.", style: TextStyle(fontSize: 20),),
            
                    SizedBox(height: 30), // Spacing between buttons
                    
            
                    ElevatedButton(
                        onPressed: () {
            
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
                Text("This is used to pinpoint the location of the person in distress..", style: TextStyle(fontSize: 20),),
            
                              SizedBox(height: 30), // Spacing between buttons
            
            ElevatedButton(
                        onPressed: () async {
                          // Handle Camera button press
            
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
                    Text("This gives camera access to record videos as proff for future references.", style: TextStyle(fontSize: 20),),
            
                    SizedBox(height: 30), // Spacing between buttons
            ElevatedButton(
                        onPressed: () {
                          // Handle Warning button press
                        },
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(34),
                          backgroundColor: Color(0xFFff371c)
                        ),
                        child: Icon(
                          Icons.add_alert,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),
                  Text("This sends a distress msg to people under a 1km radius who use the shield app.", style: TextStyle(fontSize: 20),),
            
            
              ],
            ),
        ),
      )
    );
  }
}