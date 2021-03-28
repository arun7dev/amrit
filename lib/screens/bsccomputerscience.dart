import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:amrit/components.dart';
import 'package:amrit/screens/pdf.dart';
import 'package:amrit/screens/pdfviewer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '1st.dart';
import '2nd.dart';
import '3rd.dart';
import 'modal.dart';

TextEditingController name = TextEditingController();

class ComputerScience extends StatefulWidget {
  final who;
  ComputerScience(this.who);
  @override
  _ComputerScienceState createState() => _ComputerScienceState();
}

class _ComputerScienceState extends State<ComputerScience> {
  List<Modal> itemList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("BSC computer science"),
        ),
        body: itemList.length == 0
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: itemList.length,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: GestureDetector(
                        onTap: () {
                          String passData = itemList[index].link;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewPdf(
                                        itemList[index].link,
                                      )));
                        },
                        child: Stack(
                          children: <Widget>[
                            Container(
                              height: 100,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      'https://i.pinimg.com/originals/57/bb/66/57bb66cb4895565d755910654a6b0c80.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Center(
                              child: Container(
                                height: 140,
                                child: Card(
                                  margin: EdgeInsets.all(18),
                                  elevation: 7.0,
                                  child: Center(
                                    child: Text(itemList[index].name == null
                                        ? "QP ${index + 1}"
                                        : itemList[index].name.toString()),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ));
                },
              ),
        floatingActionButton: widget.who == "TEACHER"
            ? FloatingActionButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) => Container(
                            height: 200,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    controller: name,
                                    decoration: new InputDecoration(
                                        border: new OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                            const Radius.circular(10.0),
                                          ),
                                        ),
                                        filled: true,
                                        hintStyle: new TextStyle(
                                            color: Colors.grey[800]),
                                        hintText: "Type Question paper name",
                                        fillColor: Colors.white70),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                MaterialButton(
                                    child: Text("UPLOAD"),
                                    color: Colors.green,
                                    onPressed: () {
                                      getPdfAndUpload(name.text);
                                      Navigator.pop(context);
                                    })
                              ],
                            ),
                          ));
                },
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                backgroundColor: Colors.red,
              )
            : null);
  }

  final mainReference = FirebaseDatabase.instance.reference().child('Database');

  Future getPdfAndUpload(name) async {
    FilePickerResult result = await FilePicker.platform.pickFiles();
    File file = File(result.files.single.path);
    String fileName = '${name}.pdf';
    savePdf(file.readAsBytesSync(), fileName);
  }

  savePdf(List<int> asset, String name) async {
    Reference reference = FirebaseStorage.instance.ref().child(name);
    UploadTask uploadTask = reference.putData(asset);
    TaskSnapshot snapshot = await uploadTask;
    String url = await snapshot.ref.getDownloadURL();

    documentFileUpload(url, name);
    //function call
  }

  String CreateCryptoRandomString([int length = 32]) {
    final Random _random = Random.secure();
    var values = List<int>.generate(length, (index) => _random.nextInt(256));
    return base64Url.encode(values);
  }

  void documentFileUpload(String str, name) {
    var data = {
      "PDF": str,
      "Filename": name,
      //store data
    };
    mainReference.child(CreateCryptoRandomString()).set(data).then((v) {
      print("Store Successfully");
    });
  }

  @override
  void initState() {
    mainReference.once().then((DataSnapshot snap) {
      print(snap);
      var data = snap.value;
      print(data);
      itemList.clear();
      data.forEach((key, value) {
        Modal m = new Modal(value['PDF'], value['Filen  ame']);
        itemList.add(m);
        print(itemList[0].name);

        setState(() {});
      });
    });
  }
}
