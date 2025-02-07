import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class EmergencyContact extends StatelessWidget {
  const EmergencyContact({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Emergency Contacts")
      ),
      body: Column(
        children: [
          SizedBox(height: 30),
          Text("ALL India women’s helpline number 181", style: TextStyle(fontSize: 20),),
          SizedBox(height:10),
          Text(" women’s emergency assistance 112", style: TextStyle(fontSize: 20),),
          SizedBox(height:10),
          Text(" National Commission for Women Helpline (7827170170)", style: TextStyle(fontSize: 20),),
          SizedBox(height:10),
          Text(" Multiple Action Research Group (MARG - 011 26497483/ 26496925)", style: TextStyle(fontSize: 20),),
          SizedBox(height:10),
          Text(" Shakti Shalini - Women’s Shelter (011 24373736/ 24373737)", style: TextStyle(fontSize: 20),),
          SizedBox(height:10),
          Text(" Socio Legal Information Centre (+91 24374501/ 24379855)", style: TextStyle(fontSize: 20),),
          SizedBox(height:10),
          Text(" All India Women’s Conference (AIWC - 10921/ (011) 23389680)", style: TextStyle(fontSize: 20),),

        ],
      ),
    );
  }
}