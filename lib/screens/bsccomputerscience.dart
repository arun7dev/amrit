import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:path/path.dart' as Path;

import 'package:amrit/components.dart';
import 'package:amrit/screens/adddepartment.dart';
import 'package:amrit/screens/pdf.dart';
import 'package:amrit/screens/pdfviewer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'modal.dart';

TextEditingController name = TextEditingController();
var dn;

class ComputerScience extends StatefulWidget {
  final who;
  var name;

  ComputerScience(this.who, this.name);
  @override
  _ComputerScienceState createState() => _ComputerScienceState();
}

class _ComputerScienceState extends State<ComputerScience> {
  List<Modal> itemList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: amritAppBar(),
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
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 3),
                                      child: Text(
                                        itemList[index].name == null
                                            ? "QP ${index + 1}"
                                            : itemList[index].name.toString(),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            widget.who == "TEACHER"
                                ? Center(
                                    child: MaterialButton(
                                        child: Text('DELETE'),
                                        color: Colors.red,
                                        onPressed: () {
                                          itemList[index].link == null
                                              ? null
                                              : deleteFireBaseStorageItem(
                                                  itemList[index].link,
                                                  itemList[index].num,
                                                  widget.name);
                                        }),
                                  )
                                : Text(''),
                          ],
                        ),
                      ));
                },
              ),
        floatingActionButton: widget.who == "TEACHER"
            ? SingleChildScrollView(
                child: FloatingActionButton(
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
                                            borderRadius:
                                                const BorderRadius.all(
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
                ),
              )
            : null);
  }

  Future getPdfAndUpload(name) async {
    FilePickerResult result = await FilePicker.platform.pickFiles();
    File file = File(result.files.single.path);
    String fileName = '${name}.pdf';
    savePdf(file.readAsBytesSync(), fileName);
  }

  savePdf(List<int> asset, String name) async {
    Reference reference =
        FirebaseStorage.instance.ref('${widget.name}').child(name);
    UploadTask uploadTask = reference.putData(asset);
    TaskSnapshot snapshot = await uploadTask;
    String url = await snapshot.ref.getDownloadURL();

    documentFileUpload(url, name, CreateCryptoRandomString());
    //function call
  }

  String CreateCryptoRandomString([int length = 32]) {
    final Random _random = Random.secure();
    var values = List<int>.generate(length, (index) => _random.nextInt(256));
    return base64Url.encode(values);
  }

  void documentFileUpload(String str, name, num) {
    var data = {
      "PDF": str,
      "Filename": name,
      "child": num,
      //store data
    };
    FirebaseDatabase.instance
        .reference()
        .child('${DecodeString(widget.name)}')
        .child(num)
        .set(data)
        .then((v) {
      print("Store Successfully");
    });
  }

  @override
  void initState() {
    print(deptnames().name);
    dn = widget.name;
    //print(dn);
    FirebaseDatabase.instance
        .reference()
        .child('${DecodeString(widget.name)}')
        .once()
        .then((DataSnapshot snap) {
      print(snap);
      var data = snap.value;
      print(data);
      itemList.clear();
      data.forEach((key, value) {
        Modal m = new Modal(value['PDF'], value['Filename'], value['child']);
        itemList.add(m);
        print(itemList[0].name);

        setState(() {});
      });
    });
  }
}

void deleteFireBaseStorageItem(String fileUrl, String delpath, a) {
  String filePath = fileUrl.replaceAll(
      new RegExp(
          r'https://firebasestorage.googleapis.com/v0/b/final-year-project-eb5cd.appspot.com/o/'),
      '');

  filePath = filePath.replaceAll(new RegExp(r'%2F'), '/');

  filePath = filePath.replaceAll(new RegExp(r'(\?alt).*'), '');
  print(filePath);

  Reference storageReferance = FirebaseStorage.instance.ref();

  storageReferance
      .child(filePath)
      .delete()
      .then((_) => print('Successfully deleted $filePath storage item'));
  print(delpath);
  print(a);
  FirebaseDatabase.instance
      .reference()
      // .child('final-year-project-eb5cd-default-rtdb')
      .child('$a')
      .child('$delpath')
      .remove()
      .then((value) => print('Successfully deleted $delpath storage item'));
}

String DecodeString(String string) {
  return string.replaceAll(".", " ");
}
