import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class JsonParsingSimple extends StatefulWidget {
  @override
  _JsonParsingSimpleState createState() => _JsonParsingSimpleState();
}

class _JsonParsingSimpleState extends State<JsonParsingSimple> {

  Future data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //data = Network("https://jsonplaceholder.typicode.com/posts").fetchData();
    data = getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade100,
        title: Text("Parsing Json",
        style: TextStyle(
         // color: Colors.black87,
          fontSize: 22,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w800

        ),),
      ),
      body: Center(
        child: Container(
          child: FutureBuilder(
              future: getData(),
              builder: (context , AsyncSnapshot<dynamic> snapshot){
                if(snapshot.hasData){
                  return createListView(snapshot.data,context);
                //return Text(snapshot.data[0]['userId'].toString());
    }
                   return CircularProgressIndicator();
              }),
          
        ),
      ),
    );
  }
    Future getData() async{
    var data;
    String url="https://jsonplaceholder.typicode.com/posts";
    Network network = Network(url);
    data = network.fetchData();
//    data.then((value) {
//      print(value[9]['title']);});


    return data;
    }

  // ignore: missing_return
  Widget createListView(List data, BuildContext context) {
   return Container(
     child: ListView.builder(
         itemCount: data.length,
         itemBuilder: (context , int index){
       return Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Divider(height: 5.0),
           ListTile(
             title: Text("${data[index]["title"]}",
             style: TextStyle(
               color: Colors.lightBlueAccent.shade700
             ),),
             subtitle: Text("${data[index]["body"]}"),
             leading: Column(
               children: [
                 CircleAvatar(
                   backgroundColor: Colors.amber.shade300,
                   radius: 24,
                   child: Text("${data[index]["id"]}",
                   style: TextStyle(
                     fontSize: 22
                   ),),
                 )
               ],
             ),
           )
         ],
       );
     }),
   );

  }
}









class Network{
  final String url;

  Future fetchData() async{
    print("url");
    Response response = await get(Uri.encodeFull(url));
    if(response.statusCode == 200){
      //okh

      //print(response.body[1]);
      return json.decode(response.body);
     // return response.body;
    }else{
      print(response.statusCode);
    }
  }
  Network(this.url);

}
