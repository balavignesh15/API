import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

import 'model/progms.dart';

class coding extends StatefulWidget {
  const coding({super.key});

  @override
  State<coding> createState() => _codingState();
}

class _codingState extends State<coding> {

  Future<program> line() async{
    var res=await http.get(Uri.parse("https://official-joke-api.appspot.com/random_joke"));
    return program.fromJson(jsonDecode(res.body));
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue,
        title: Center(child: Text("Pgms")),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            FutureBuilder(
                future: line(),
                builder: (context,snapshot)
        {
          if (snapshot.hasData){
            return Center(
              child: Column(
                children: [
                Text(snapshot.data!.id.toString(),style: TextStyle(fontWeight: FontWeight.bold),),
                Text(snapshot.data!.punchline.toString(),style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(snapshot.data!.setup.toString(),style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(snapshot.connectionState.toString(),style: TextStyle(fontWeight: FontWeight.bold))
                ],
              ),
            );
          }
          else if(snapshot.hasError){
            return Text("${snapshot.error}");
          }
          return Center(child: CircularProgressIndicator());

        }




            ) ],
        ),
      ),





    );
  }
}
