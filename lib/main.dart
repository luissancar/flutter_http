import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
// tenemos que instalar el paquete HTTP modificando el fichero pubspec.yaml

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final url =
      //    "http://iesayala.ddns.net/json/jsonguitarras2.php"; // debe ser https
      "https://jsonplaceholder.typicode.com/posts";

  var _postJson = []; //variable gloval

  void fetchPosts() async {
    try {
      final response = await get(Uri.parse(url));
      final jsonData = jsonDecode(response.body) as List;

      setState(() {
        // las modificaciones de datos se actualizan en la interfaz
        _postJson = jsonData;
      });
    } catch (err) {
      print("Error http");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView.builder(
            itemCount: _postJson.length,
            itemBuilder: (context, i) {
              final post = _postJson[i];
              return Text("${post["title"]}\n");
            }),
      ),
    );
  }
}
