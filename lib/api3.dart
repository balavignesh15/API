import 'dart:convert';


import 'package:api/model/breed.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class breed extends StatefulWidget {
  const breed({super.key});

  @override
  State<breed> createState() => _breedState();
}

class _breedState extends State<breed> {

  Future<pet> fetch() async{
    var res =await http.get(Uri.parse("https://dog.ceo/api/breeds/image/random"));
    var data= jsonDecode(res.body);
   return data;

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Breed"),
      ),
      body: Column(
        children: [
          FutureBuilder(future: fetch(), builder: (context,snapshot)
      {
        if (snapshot.hasData){
          return Column(
            children: [
              Text(snapshot.data!.message.toString()),
            ],
          );
            }
          else if(snapshot.hasError){
           return Text("${snapshot.error}");
          }
           return CircularProgressIndicator();
      }

          )],
      ),
    );
  }
}
