import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Harpergetter(),
    );
  }
}

class Harpergetter extends StatefulWidget {
  @override
  _HarpergetterState createState() => _HarpergetterState();
}

class _HarpergetterState extends State<Harpergetter> {
  @override
  void initState() {
    super.initState();
    getharperdb();
  }

  List developers = [];

  Future getharperdb() async {
    var url = Uri.parse('https://harpertut-flutro.harperdbcloud.com');

    String basicAuth = 'Basic b3BlbnNvdXJjZTpmcmVlZm9yYWxs';

    var response = await http.post(url,
        headers: {'authorization': basicAuth},
        body: {"operation": "sql", "sql": "Select * from Conference.Users"});

    // print(response.statusCode);
    // print(response.body);

    setState(() {
      developers = jsonDecode(response.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Harperdb Flutter app'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: developers.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Text(developers[index]['Firstname']),
            title: Text(developers[index]['Lastname'] == null
                ? 'Last name not provided'
                : developers[index]['Lastname']),
          );
        },
      ),
    );
  }
}
