import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert'; //convert json to strings
import 'package:intl/intl.dart' as intl;

class Quake extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Quake Info"),
        centerTitle: true,
        backgroundColor: Colors.orangeAccent[700],
      ),
      body: Center(),
    );
  }
}

//future type object
Future<List> getJson() async {
  String apiURL =
      'https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson';

  http.Response response = await http.get(apiURL);

  return json.decode(response.body); //this returns a List type by default
}
