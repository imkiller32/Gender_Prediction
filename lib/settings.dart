import 'package:flutter/material.dart';
import 'module.dart';

void main() => runApp(Setting());

class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
      ),
      body: SettingPage(),
    );
  }
}

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool darkTheme = module.getTheme();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Options',
                style: TextStyle(fontSize: 16.0, color: Colors.lightBlue),
              ),
              ListTile(
                title: Text('Dark Theme'),
                trailing: Switch(
                  value: false,
                  onChanged: null,
                ),
              ),
              Divider(
                height: 3.0,
              ),
              Padding(
                padding: EdgeInsets.only(top: 25.0),
              ),
              Text(
                'About',
                style: TextStyle(fontSize: 16.0, color: Colors.lightBlue),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.0),
              ),
              Text('GenderPredictor'),
              Text('Version:2.0.0'),
            ],
          ),
        ),
      ),
    );
  }
}
