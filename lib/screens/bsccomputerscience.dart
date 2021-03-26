import 'package:amrit/components.dart';
import 'package:flutter/material.dart';

import '1st.dart';
import '2nd.dart';
import '3rd.dart';

class ComputerScience extends StatefulWidget {
  @override
  _ComputerScienceState createState() => _ComputerScienceState();
}

class _ComputerScienceState extends State<ComputerScience> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: amritAppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Card(
              color: Colors.blue[100],
              child: Center(
                child: Text(
                  "BSC Computer Science",
                  style: TextStyle(color: Colors.black, fontSize: 33),
                ),
              ),
            ),
          ),
          ListTile(
            title: Text("BSC computer science 1st year"),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => First()));
            },
          ),
          ListTile(
            title: Text("BSC computer science 2nd year"),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Second()));
            },
          ),
          ListTile(
            title: Text("BSC computer science 3rd year"),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Third()));
            },
          ),
        ],
      ),
    );
  }
}
