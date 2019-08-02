import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'settings.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _nameController = TextEditingController();
  var result = "Unknown";
  var resultprobability;
  var probability = "0";
  predictGender(String name) async {
    var url = "https://api.genderize.io/?name=$name";
    var response = await http.get(url);
    var body = jsonDecode(response.body);
    probability = "${body['probability']}";
    resultprobability = "Probability : ${body['probability']}";
    result = "${body['gender']}";
    setState(() {});
  }

  bool check(String name) {
    return (name.length > 0);
  }

  startPredictor(String name) {
    result = null;
    setState(() {});
    predictGender(_nameController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.asset(
              'assets/gender.png',
              fit: BoxFit.contain,
              height: 40.0,
            ),
            Text(
              "Gender Predictor",
              style: TextStyle(
                fontSize: 19.0,
              ),
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            padding: EdgeInsets.only(right: 15),
            tooltip: 'Options',
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Setting()));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Image.asset(
                        'assets/maleAvatar.jpg',
                        fit: BoxFit.contain,
                        height: 100.0,
                      ),
                      Text('Male'),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Image.asset(
                        'assets/femaleAvatar.png',
                        fit: BoxFit.contain,
                        height: 100.0,
                      ),
                      Text('Female'),
                    ],
                  ),
                ],
              ),
            ),
            Text("Enter a name to predict"),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                    hintText: 'Enter a name to predict',
                    labelText: 'Name',
                    border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: FlatButton(
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0)),
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    'PREDICT',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.3,
                    ),
                  ),
                ),
                onPressed: () {
                  if (check(_nameController.text))
                    startPredictor(_nameController.text);
                  else
                    Fluttertoast.showToast(
                        msg: "Name can not be empty",
                        toastLength: Toast.LENGTH_SHORT,
                        fontSize: 16.0);
                },
              ),
            ),
            if (result == null)
              CircularProgressIndicator(
                strokeWidth: 2.0,
              ),
            if (result != null &&
                result != "Unknown" &&
                probability != "0" &&
                probability != "0.5")
              Column(
                children: <Widget>[
                  (result == "male")
                      ? Image.asset(
                          'assets/maleAvatar.jpg',
                          fit: BoxFit.contain,
                          height: 40.0,
                        )
                      : Image.asset(
                          'assets/femaleAvatar.png',
                          fit: BoxFit.contain,
                          height: 40.0,
                        ),
                  Padding(
                    padding: EdgeInsets.all(5),
                  ),
                  Text(resultprobability),
                ],
              ),
            if (result != null && result != "Unknown" && probability == "0.5")
              Column(
                children: <Widget>[
                  Image.asset(
                    'assets/both.png',
                    fit: BoxFit.contain,
                    height: 40.0,
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                  ),
                  Text(resultprobability),
                ],
              ),
            if (result != null && result != "Unknown" && probability == "0")
              Column(
                children: <Widget>[
                  Image.asset(
                    'assets/invalid.png',
                    fit: BoxFit.contain,
                    height: 40.0,
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                  ),
                  Text(resultprobability),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
