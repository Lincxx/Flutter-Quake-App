import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert'; //convert json to strings
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

void main() async {
  Map _data = await getQuackJson();
  var _featureList = _data['features'];

  print(_featureList.length);
  print(_featureList[0]['properties']['place']);

  String _returnDateTime(int position) {
    DateTime _date = new DateTime.fromMillisecondsSinceEpoch(
        _featureList[position]['properties']['time']);
    var _formatter = new DateFormat("yMMMMd").add_jm();
    var _dateString = _formatter.format(_date);
    return _dateString;
  }

  runApp(MaterialApp(
    title: "Intro to Parse",
    home: Scaffold(
      appBar: AppBar(
        title: Text('JSON Parse'),
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
      ),
      body: Center(
        child: ListView.builder(
          itemCount: _featureList.length,
          padding: EdgeInsets.all(14.5),
          itemBuilder: (BuildContext context, int position) {
            return Column(
              children: <Widget>[
                Divider(height: 5.5),
                ListTile(
                  title: Text(
                    "${_returnDateTime(position)}",
                    style: TextStyle(fontSize: 17.9),
                  ),
                  subtitle: Text(
                    "${_featureList[position]['properties']['place']}",
                    style: TextStyle(
                        fontSize: 13.9,
                        color: Colors.grey,
                        fontStyle: FontStyle.italic),
                  ),
                  leading: CircleAvatar(
                      backgroundColor: Colors.greenAccent,
                      child: Text(
                          "${_featureList[position]['properties']['mag']}"
                              .toUpperCase(),
                          style: TextStyle(
                              fontSize: 16.4,
                              fontWeight: FontWeight.w400,
                              color: Colors.white))),
                  onTap: () => _showOnTapMessage(
                      context, _featureList[position]['properties']['place']),
                ),
              ],
            );
          },
        ),
      ),
    ),
  ));
}

//whenever you are building a new view or widget you must pass the context
void _showOnTapMessage(BuildContext context, String message) {
  var alert = AlertDialog(
    title: Text("Quake"),
    content: Text(message),
    actions: <Widget>[
      FlatButton(
          child: Text(
            "Ok",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.blueAccent)
    ],
  );
  //showDialog(context: context, child: alert);
  showDialog(context: context, builder: (context) => alert);
}

//future type object
Future<Map> getQuackJson() async {
  String apiURL =
      'https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson';

  http.Response response = await http.get(apiURL);

  return json.decode(response.body); //this returns a List type by default
}
