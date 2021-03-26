import 'package:amrit/screens/pdfviewer.dart';
import 'package:flutter/material.dart';
import 'package:native_pdf_view/native_pdf_view.dart';

import '../components.dart';

class First extends StatefulWidget {
  @override
  _FirstState createState() => _FirstState();
}

class _FirstState extends State<First> {
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
                      MaterialPageRoute(builder: (context) => PdfViwer(1)));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
