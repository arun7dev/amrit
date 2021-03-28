import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class ViewPdf extends StatefulWidget {
  final link;

  ViewPdf(this.link);
  @override
  _ViewPdfState createState() => _ViewPdfState();
}

class _ViewPdfState extends State<ViewPdf> {
  @override
  Widget build(BuildContext context) {
    //get data from first class

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('PDF'),
      ),
      body: Container(
        child: PDF(
          swipeHorizontal: true,
        ).cachedFromUrl(widget.link),
      ),
    );
  }
}
