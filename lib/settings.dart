import 'package:flutter/material.dart';
import 'package:gender_prediction/theme.dart';
import 'package:provider/provider.dart';

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
  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    ThemeData data = _themeChanger.getTheme();

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
                  value: data == ThemeData.dark(),
                  onChanged: (value) async {
                    if (value == true)
                      _themeChanger.setTheme(ThemeData.dark());
                    else
                      _themeChanger.setTheme(ThemeData.light());
                  },
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
              Text('Version:2.0.3'),
            ],
          ),
        ),
      ),
    );
  }
}
