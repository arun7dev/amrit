import 'package:amrit/screens/pdfviewer.dart';
import 'package:flutter/material.dart';

import '../components.dart';

class Third extends StatefulWidget {
  @override
  _ThirdState createState() => _ThirdState();
}

class _ThirdState extends State<Third> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: amritAppBar(),
      body: SafeArea(
        child: ListView(
          children: [
            Center(
              child: GestureDetector(
                child: Card(
                    color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("SAMPLE QUESTION PAPER"),
                    )),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PdfViwer(3)));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
