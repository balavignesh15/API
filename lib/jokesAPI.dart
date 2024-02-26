import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import 'model/jokesclass.dart';
class smile extends StatefulWidget {
  const smile({super.key});

  @override
  State<smile> createState() => _smileState();
}

class _smileState extends State<smile> {
  Future<program>? _content;

  Future<program> fetchJokes() async {
    final response = await http.get(Uri.parse('https://official-joke-api.appspot.com/random_joke'));

    if (response.statusCode == 200) {
      return program.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load album');
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _content=fetchJokes();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text("Read the Jokes ")),
      ),
      body: Center(
        child: FutureBuilder<program>(
          future: _content,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Text(snapshot.data!.type.toString()),
                  Text(snapshot.data!.setup.toString()),
                  Text(snapshot.data!.punchline.toString()),
                  Text(snapshot.data!.id.toString()),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
