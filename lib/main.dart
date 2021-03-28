import 'package:amrit/components.dart';
import 'package:amrit/screens/bsccomputerscience.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

TextEditingController password = TextEditingController();
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
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0)),
                    color: Colors.lightBlue[100],
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(0),
                          child: Image.asset(
                            'assets/gnc.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          "GURU NANAK COLLEGE",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ComputerScience(widget.who)));
                  },
                ),
              ),
            ),
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
