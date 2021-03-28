import 'package:amrit/screens/1st.dart';
import 'package:amrit/screens/2nd.dart';
import 'package:amrit/screens/3rd.dart';
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
        ListTile(
          title: Text("BSC computer science "),
          trailing: Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => ComputerScience(who)));
          },
        ),
      ],
    ),
  );
}
