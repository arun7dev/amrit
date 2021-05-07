import 'package:amrit/main.dart';
import 'package:amrit/screens/adddepartment.dart';
import 'package:amrit/screens/bsccomputerscience.dart';
import 'package:flutter/material.dart';

amritAppBar() {
  return AppBar(
    title: Text("QUESTION BANK"),
  );
}

amritDrawer(context, who) {
  return Drawer(
    child: ListView(
      children: <Widget>[
        Image.asset(
          'assets/gnc.jpg',
          fit: BoxFit.cover,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            color: Colors.blue[100],
            child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => MyHomePage(who)));
                },
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Home',
                    style: TextStyle(fontSize: 20),
                  ),
                ))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            color: Colors.blue[100],
            child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddDepartment(who)));
                },
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Department',
                    style: TextStyle(fontSize: 20),
                  ),
                ))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            color: Colors.blue[100],
            child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddDepartment(who)));
                },
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Notes',
                    style: TextStyle(fontSize: 20),
                  ),
                ))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            color: Colors.blue[100],
            child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => MyHomePage(who)));
                },
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Notice Board',
                    style: TextStyle(fontSize: 20),
                  ),
                ))),
          ),
        ),
      ],
    ),
  );
}
