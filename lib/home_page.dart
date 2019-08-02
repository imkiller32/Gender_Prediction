import 'package:flutter/material.dart';
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
  var probability="0";
  predictGender(String name) async {
    var url = "https://api.genderize.io/?name=$name";
    var response = await http.get(url);
    var body = jsonDecode(response.body);
    probability = "${body['probability']}";
    resultprobability = "Probability : ${body['probability']}";
    result = "${body['gender']}";
    setState(() {});
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
            Text("Enter a name to predict"),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                    hintText: 'Enter a name to predict',
                    labelText: 'Name',
                    border: OutlineInputBorder()),
              ),
            ),
            FlatButton(
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
                result = null;
                setState(() {});
                predictGender(_nameController.text);
              },
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
                  Text(resultprobability),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
