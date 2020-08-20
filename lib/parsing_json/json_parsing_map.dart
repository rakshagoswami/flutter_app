import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/model/post.dart';
import 'package:http/http.dart';

class JsonParsingMap extends StatefulWidget {

  @override
  _JsonParsingMapState createState() => _JsonParsingMapState();
}

class _JsonParsingMapState extends State<JsonParsingMap> {

  Future<PostList> data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Network network= Network("https://jsonplaceholder.typicode.com/posts");
    data= network.loadPosts();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade300,
        title: Text("PODO",
        style: TextStyle(
          fontSize: 25,
          fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w900
        ),),
      ),
     body: Center(
       child: Container(
         child: FutureBuilder(
              future: data,
             builder: (context, AsyncSnapshot<PostList> snapshot){
           List<Post> allposts;
           if(snapshot.hasData){
          allposts = snapshot.data.posts;

          return createListView(allposts, context);
           }else{
             return CircularProgressIndicator();
           }
         }),

       ),
     ),
    );
  }
  Widget createListView(List<Post> data,BuildContext context){
    return Container(
       child: ListView.builder(
         itemCount: data.length,
           itemBuilder: (context, int index){
           return Column(
             children: [
               Divider(height: 5.0,),
               ListTile(
                 title: Text(" ${data[index].title}",
                 style: TextStyle(
                   color: Colors.amber
                 ),),
                 subtitle: Text("${data[index].body}"),
                 leading: Column(
                   children: [
                     CircleAvatar(
                       backgroundColor: Colors.pink.shade100,
                       radius: 23,
                       child: Text('${data[index].id}',
                       style: TextStyle(
                         fontSize: 20,
                         color: Colors.black
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

  Network(this.url);

  Future<PostList> loadPosts() async{
    final response  = await get(Uri.encodeFull(url));

    if(response.statusCode == 200 ){
      //okh
      return PostList.fromJson(json.decode(response.body)); // we get json object

    }else{
      throw Exception("Failed to get post");
    }
  }





}


















