import 'package:amrit/components.dart';
import 'package:amrit/screens/adddepartment.dart';
import 'package:amrit/screens/bsccomputerscience.dart';
import 'package:amrit/screens/modal.dart';
import 'package:amrit/screens/pdf.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

TextEditingController password = TextEditingController();
TextEditingController head = TextEditingController();
TextEditingController read = TextEditingController();
var pass = "gnc@230201";
var pass1 = "gnc@211000";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHome(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final who;
  MyHomePage(this.who);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: amritAppBar(),
      drawer: amritDrawer(context, widget.who),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)),
                      color: Colors.lightBlue[100],
                      child: Column(
                        children: [
                          Expanded(
                            flex: 3,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: Image.asset(
                                'assets/gnc.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              "GURU NANAK COLLEGE",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddDepartment(widget.who)));
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border.all(width: 4, color: Colors.blue[900])),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          'NOTICE BOARD',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 30,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: notice(widget.who),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/icon/appicon.png"),
              Text(
                "QUESTION BANK",
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                "Exams made easy",
                style: TextStyle(fontSize: 25, color: Colors.yellow),
              ),
              SizedBox(
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "STUDENT",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyHomePage("STUDENT")));
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "TEACHER",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        color: Colors.white,
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
                                            controller: password,
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
                                                hintText: "Password",
                                                fillColor: Colors.white70),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        MaterialButton(
                                            child: Text("SUBMIT"),
                                            color: Colors.green,
                                            onPressed: () {
                                              Navigator.pop(context);
                                              print(password.text);
                                              if (password.text == pass ||
                                                  password.text == pass1) {
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            MyHomePage(
                                                                "TEACHER")));
                                              } else {
                                                _showDialog(context);
                                              }

                                              // Navigator.pop(context);
                                            })
                                      ],
                                    ),
                                  ));
                        }),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

void _showDialog(context) {
  // flutter defined function
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: new Text("Message"),
        content: new Text("Password Wrong"),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new MaterialButton(
            child: new Text("Close"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}

class notice extends StatefulWidget {
  final who;
  notice(this.who);
  @override
  _noticeState createState() => _noticeState();
}

class _noticeState extends State<notice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //appBar: amritAppBar(),
        // drawer: amritDrawer(context, widget.who),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('notice').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              } else {
                return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => noticefull(
                                        snapshot.data.docs[index]['head'],
                                        snapshot.data.docs[index]['read'],
                                      )));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.blue[100],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      snapshot.data.docs[index]['head'],
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    widget.who == "TEACHER"
                                        ? Center(
                                            child: MaterialButton(
                                                child: Text('DELETE'),
                                                color: Colors.red,
                                                onPressed: () {
                                                  FirebaseFirestore.instance
                                                      .collection("notice")
                                                      .where(
                                                        "head",
                                                        isEqualTo: snapshot.data
                                                                .docs[index]
                                                            ['head'],
                                                      )
                                                      .get()
                                                      .then((value) {
                                                    value.docs
                                                        .forEach((element) {
                                                      FirebaseFirestore.instance
                                                          .collection("notice")
                                                          .doc(element.id)
                                                          .delete()
                                                          .then((value) {
                                                        print("Success!");
                                                      });
                                                    });
                                                  });
                                                }),
                                          )
                                        : Text(''),
                                  ],
                                ),
                              )),
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
        floatingActionButton: widget.who == "TEACHER"
            ? SingleChildScrollView(
                child: FloatingActionButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) => SingleChildScrollView(
                              child: Container(
                                height: 500,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextField(
                                        controller: head,
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
                                            hintText: "title",
                                            fillColor: Colors.white70),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextField(
                                        controller: read,
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
                                            hintText: "content",
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
                                              .collection('notice')
                                              .add({
                                            'head': head.text,
                                            'read': read.text,
                                          });
                                          Navigator.pop(context);
                                        })
                                  ],
                                ),
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

class noticefull extends StatefulWidget {
  final head;
  final read;
  noticefull(this.head, this.read);
  @override
  _noticefullState createState() => _noticefullState();
}

class _noticefullState extends State<noticefull> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NOTICE'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.red,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      widget.head,
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.blue[100],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.read,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
