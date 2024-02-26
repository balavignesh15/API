import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model/listinobj.dart';

class objin extends StatefulWidget {
  const objin({super.key});

  @override
  State<objin> createState() => _objinState();
}

class _objinState extends State<objin> {

  Future<List<alpha>> fetch() async{
    var res= await http.get(Uri.parse("http://universities.hipolabs.com/search?country=United+States"));
    var data=jsonDecode(res.body);
    return (data as List).map((e) =>alpha.fromJson(e)).toList();

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
                future: fetch(),
                builder: (context,snaphot){
                  if(snaphot.hasData){
                    List<alpha> alphadata=snaphot.data!;
                  return Container(
                    height: 700,
                    child: ListView.builder(
                      itemCount:alphadata.length ,
                        itemBuilder: (BuildContext, int index)
                      {
                        return Column(
                            children: [
                        Text(alphadata[index].name.toString()),
                              Text(alphadata[index].webPages!.toString()),
                              Text(alphadata[index].domains.toString()),
                    ]
                    );
                                  }
                    ),
                  ); }
                  else if(snaphot.hasError){
                    return Text("${snaphot.error}");
                  }
                  return CircularProgressIndicator();
                  }
        
        
        
            ) ],
        ),
      ),
    );
  }
}
