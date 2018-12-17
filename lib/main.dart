import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert'; //convert json to strings
import 'package:intl/intl.dart' as intl;

void main() async {
  runApp(MaterialApp(
    title: "Quake App",
    debugShowCheckedModeBanner: false,
    home: Scaffold(),
  ));
}

//future type object
Future<List> getQuackJson() async {
  String apiURL =
      'https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson';

  http.Response response = await http.get(apiURL);

  return json.decode(response.body); //this returns a List type by default
}
