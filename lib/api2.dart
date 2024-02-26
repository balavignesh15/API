import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model/bored.dart';

class api2 extends StatefulWidget {
  const api2({super.key});

  @override
  State<api2> createState() => _api2State();
}

class _api2State extends State<api2> {
  Future<bored> auto() async{
    var res =await http.get(Uri.parse("https://dog.ceo/api/breeds/image/random"));
    print(res.body);
    return bored.fromJson(jsonDecode(res.body));


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Center(child: Text("Bored")),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                FutureBuilder(
                    future: auto(),
                    builder: (context,snapshot)
            {
              if(snapshot.hasData){
                return Center(
                  child: Column(
                    children: [
                      Text(snapshot.data!.status.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25)),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(snapshot.data!.message.toString(),style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      // Text(snapshot.data!.activity.toString()),
                      // Text(snapshot.data!.participants.toString()),
                      // Text(snapshot.data!.link.toString()),
                      // Text(snapshot.data!.key.toString()),
                      // Text(snapshot.data!.accessibility.toString()),
                      Container(
                        height: 500,
                        width: 400,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(snapshot.data!.message.toString())
                          )
                        ),
                      ),
                      Text(snapshot.data!.message.toString(),style: TextStyle(fontWeight: FontWeight.bold)),
                      Container(
                        height: 500,
                        width: 400,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(snapshot.data!.message.toString())
                            )
                        ),
                      )
                    ],
                  ),
                );
              }
              else if (snapshot.hasError){
                return Text("${snapshot.error}");
              }
              return Center(child: CircularProgressIndicator());
            }
        
        
        
        
        
        
                )],
            ),
          ),
        ),
      )
    );
  }
}


//
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// import 'api3.dart';
// import 'model/bored.dart';
//
// class api2 extends StatefulWidget {
//   const api2({super.key});
//
//   @override
//   State<api2> createState() => _api2State();
// }
//
// class _api2State extends State<api2> {
//   Future<breed> auto() async{
//     var res =await http.get(Uri.parse("https://dog.ceo/api/breeds/image/random"));
//     return breed.fromJson(jsonDecode(res.body));
//
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Center(child: Text("Bored")),
//         ),
//         body: Column(
//           children: [
//             FutureBuilder(
//                 future: auto(),
//                 builder: (context,snapshot)
//                 {
//                   if(snapshot.hasData){
//                     return Center(
//                       child: Column(
//                         children: [
//                           Text(snapshot.data!.price.toString()),
//                           Text(snapshot.data!.activity.toString()),
//                           Text(snapshot.data!.participants.toString()),
//                           Text(snapshot.data!.link.toString()),
//                           Text(snapshot.data!.key.toString()),
//                           Text(snapshot.data!.accessibility.toString()),
//                         ],
//                       ),
//                     );
//                   }
//                   else if (snapshot.hasError){
//                     return Text("${snapshot.error}");
//                   }
//                   return CircularProgressIndicator();
//                 }
//
//
//
//
//
//
//             )],
//         )
//     );
//   }
// }
