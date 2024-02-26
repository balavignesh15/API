import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model/list.dart';

class place extends StatefulWidget {
  const place({super.key});

  @override
  State<place> createState() => _placeState();
}

class _placeState extends State<place> {

  Future<List<Places>>fet() async{
    var res=await http.get(Uri.parse("https://api.zippopotam.us/us/33162"));
    var data= jsonDecode(res.body)["places"];
    print(res.body);
    return(data as List).map((e) => Places.fromJson(e)).toList();
  }

  Future<list>fets() async{
    var res=await http.get(Uri.parse("https://api.zippopotam.us/us/33162"));
    return list.fromJson(jsonDecode(res.body));
  }










  







  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
                future: fet(),
                builder: (context,snapshot)
                {
                  if(snapshot.hasData){
                    List<Places> placesdata =snapshot.data!;
                  return Container(
                    height: 700,
                    child: ListView.builder(
                      itemCount: placesdata.length,
                        itemBuilder: (BuildContext,int index) {
                          return Column(
                            children: [
                              Text(placesdata[index].placeName.toString()),
                              Text(placesdata[index].latitude.toString()),
                              Text(placesdata[index].longitude.toString()),
                              Text(placesdata[index].stateAbbreviation.toString()),
                              Text(placesdata[index].state.toString()),
                            ],
                          );
                        }
        
                    ),
                  );}
                  else if(snapshot.hasError){
                    return Text("${snapshot.error}");
                    }
                  return CircularProgressIndicator();
            }
            ),
            FutureBuilder(
                future: fets(),
                builder: (context,snapshot)
                {
                  if (snapshot.hasData){
                    // List<Entries> getting_data = snapshot.data!;
                    return Column(
                      children: [
                      Text(snapshot.data!.places.toString()),
                        Text(snapshot.data!.postCode.toString()),
                        Text(snapshot.data!.country.toString()),
                        Text(snapshot.data!.countryAbbreviation.toString()),

                      ],
                    );
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
