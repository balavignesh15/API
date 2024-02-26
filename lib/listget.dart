import 'dart:convert';

import 'package:api/model/randomclass.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class ran extends StatefulWidget {
  const ran({super.key});

  @override
  State<ran> createState() => _ranState();
}

class _ranState extends State<ran> {
  Future<List<Entries>> getlist() async{
    var resp = await http.get(Uri.parse("https://api.publicapis.org/entries"));
    var data = jsonDecode(resp.body)["entries"];
    // print(resp.body);
    return (data as List).map((e) => Entries.fromJson(e)).toList();
  }
  Future<random> fetch() async{
    var resp = await http.get(Uri.parse("https://api.publicapis.org/entries"));
    print(resp.body);
    return random.fromJson(jsonDecode(resp.body));
  }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                future: getlist(),
                builder: (context,snapshot){
                  if (snapshot.hasData){
                  List<Entries> getting_data = snapshot.data!;
                    return Container(
                      height: 800,
                      child: ListView.builder(
                        itemCount: getting_data.length,
                        itemBuilder: (BuildContext,int index){
                          return Column(
                            children: [
                              Text(getting_data[index].aPI.toString())
          
          
          
                            ],
                          );
                        },
          
                      ),
                    );
                  }
                  else if(snapshot.hasError){
                    return Text("${snapshot.error}");
                  }
                  return CircularProgressIndicator();
          
                }
          
          
          
              ),
              FutureBuilder(
                  future: fetch(),
                  builder: (context,snapshot){
                    if (snapshot.hasData){
                      // List<Entries> getting_data = snapshot.data!;
                      return Text(snapshot.data!.count.toString());
                    }
                    else if(snapshot.hasError){
                      return Text("${snapshot.error}");
                    }
                    return CircularProgressIndicator();
          
                  }
          
          
          
              ),
            ],
          ),
        ),
      );
    }
  }

        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        

  
  
  
  

