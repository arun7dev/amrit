import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../components.dart';
import 'bsccomputerscience.dart';

var mainReference;

TextEditingController departmentname = TextEditingController();
int len;
var deptname;

class AddDepartment extends StatefulWidget {
  final who;
  AddDepartment(this.who);
  @override
  _AddDepartmentState createState() => _AddDepartmentState();
}

class _AddDepartmentState extends State<AddDepartment> {
  void initState() {
    // TODO: implement initState
    super.initState();
    getlength();
  }

  getlength() async {
    return await FirebaseFirestore.instance
        .collection("collegedetails")
        .get()
        .then((QuerySnapshot querySnapshot) {
      print(querySnapshot.docs.length);
      len = querySnapshot.docs.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: amritAppBar(),
        drawer: amritDrawer(context, widget.who),
        body: SafeArea(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('collegedetails')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            deptnames().name =
                                snapshot.data.docs[index]['departmentname'];
                            print(
                                '${snapshot.data.docs[index]['departmentname']}');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ComputerScience(
                                        widget.who,
                                        snapshot.data.docs[index]
                                            ['departmentname'])));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.blue[100],
                                    border: Border.all(
                                      width: 5,
                                      color: Colors.black,
                                    )),
                                height: 150,
                                child: Center(
                                    child: Text(
                                  snapshot.data.docs[index]['departmentname'],
                                  style: TextStyle(fontSize: 30),
                                ))),
                          ),
                        );
                      });
                }
              }
              // Column(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              //     Center(
              //       child: Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: GestureDetector(
              //           child: Card(
              //             shape: RoundedRectangleBorder(
              //                 borderRadius: BorderRadius.circular(0)),
              //             color: Colors.lightBlue[100],
              //             child: Column(
              //               children: [
              //                 ClipRRect(
              //                   borderRadius: BorderRadius.circular(0),
              //                   child: Image.asset(
              //                     'assets/gnc.jpg',
              //                     fit: BoxFit.cover,
              //                   ),
              //                 ),
              //                 Text(
              //                   "GURU NANAK COLLEGE",
              //                   style: TextStyle(
              //                       fontSize: 25,
              //                       fontWeight: FontWeight.bold,
              //                       color: Colors.black),
              //                 ),
              //               ],
              //             ),
              //           ),
              //           onTap: () {
              //             Navigator.push(
              //                 context,
              //                 MaterialPageRoute(
              //                     builder: (context) => ComputerScience(widget.who)));
              //           },
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              ),
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
                                      controller: departmentname,
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
                                          hintText: "Department Name",
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
                                        FirebaseFirestore.instance
                                            .collection('collegedetails')
                                            .add({
                                          'departmentname': departmentname.text
                                        });
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
}

class deptnames {
  var name;
}
