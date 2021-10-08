import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:new_app/Components/Home/Bussiness.dart';
import 'package:http/http.dart' as http;
import 'package:new_app/Components/Home/Home.dart';


class Categories extends StatefulWidget {
  

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {

  var players = [
    {"Category": "business"},
    {"Category": " entertainment"},
    {"Category": "health"},
    {"Category": "science"},
    {"Category": "sports"},
    {"Category": "technology"},
 ];


  getuser() async {
    var users = [];
    var res = await http.get(Uri.parse(
        'http://api.mediastack.com/v1/news?access_key=93ba63c4992bd42ef7dc0fca0d9bc427'));
    var jsonData = jsonDecode(res.body);
    print(jsonData["data"]);

    for (var i in jsonData["data"]) {
      UserModel user = UserModel(
          i['author'],
          i['title'],
          i['description'],
          i['url'],
          i['source'],
          i['image'],
          i['category'],
          i['language'],
          i['country'],
          i['published_at']);
      users.add(user);
    }

    return users;
  }


 getdata (e){
   print(e);
  
 
 }
  


  @override
  Widget build(BuildContext context) {
    return  Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("Hello"),
              
              GridView.count(
                physics: ScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 0.0,
              mainAxisSpacing: 0.0,
               childAspectRatio: (0.9 / .4),
              shrinkWrap: true,
              children: List<Widget>.generate(players.length,
        (index)  {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    
                    child: Container(
                     
                      child: ElevatedButton(
                        onPressed: ()=> getdata(players[index]['Category']),
                        child: Text(players[index]['Category'])),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent),
                        // image: DecorationImage(
                        //   image: AssetImage('assets/main.png'),
                        //   fit: BoxFit.cover,
                        // ),
                        color: Color(0xffAED6F1 ),
                        borderRadius:
                        BorderRadius.all(Radius.circular(20.0),),
                       
                      ),
                    ),
                  );
                },),
            ),

             
             
          
      ]
          ),
        ),
        
      
    );
  }
}


class UserModel {
  var author;
  var title;
  var description;
  var url;
  var source;
  var image;
  var category;
  var language;
  var country;
  var publishedAt;

  UserModel(this.author, this.title, this.description, this.url, this.source,
      this.image, this.category, this.country, this.language, this.publishedAt);
}
