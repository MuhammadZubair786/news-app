
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:new_app/Components/Sign_In_up/Main_Page.dart';

class Alldata extends StatefulWidget {
  var value;
  var _user;
  Alldata(this.value,this._user);

  @override
  _AlldataState createState() => _AlldataState(value,_user);
}

class _AlldataState extends State<Alldata> {
  var value;
  var _user;
  _AlldataState(this.value,this._user);

  List News = [];

  @override
  void initState() {
    super.initState();
  //   print(value.title);
  // print(value.content);
  print(value.author);
  print(_user);

  }

 added_firebase_news() async{
     DatabaseReference userRef = FirebaseDatabase.instance.reference().child('fav_news');
        var key = userRef.child(_user).push().key;
         var obj = {
          "userUid": _user,
          "image":  value.image == null || value.image == '' ? null : value.image,
          "title": value.title == null || value.title == '' ? null : value.title,
           "description": value.description == null || value.description== '' ? null : value.description,
           "publishedAt": value.publishedAt == null || value.publishedAt== '' ? null : value.publishedAt,
           "content": value.content == null || value.content== '' ? null : value.content,
           "author": value.author == null || value.author== '' ? null : value.author,
           "key":key
        };
        print(obj);



       await userRef.child(_user).child(key).set(obj);
        Widget okButtons = TextButton(
        child: Text("OK"),
       onPressed: () => Navigator.pop(context, true), );

    AlertDialog alerts = AlertDialog(
      
      title: Center(child: Text("Add Favourite News")),
      content: Text("Added This News"),
      actions: [
        okButtons,
      ],
      
    );


         showDialog(
        context: context,
        builder: (BuildContext context) {
          return alerts;
        },
      );


  }


  addnews () async {
      // FirebaseFirestore db = FirebaseFirestore.instance;
      DatabaseReference userRef = FirebaseDatabase.instance.reference().child('fav_news');
     Widget okButton = TextButton(
        child: Text("OK"),
        onPressed: () {
         Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginPage()));
         
          // print("Hello");
        });

    AlertDialog alert = AlertDialog(
      
      title: Center(child: Text("User Not Login")),
      content: Text("First Login Then Add Favourite News"),
      actions: [
        okButton,
      ],
      
    );

    
    if(_user=="NONE"){
       showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
    else{
      print(_user);

      userRef.child(_user).orderByChild('title').equalTo(value.title).once().then((DataSnapshot dataSnapshot){
      var data = dataSnapshot.value;
      if(data == null){
        print("no data");
        added_firebase_news();
        //   var key = userRef.child(_user).push().key;
        //  var obj = {
        //   "userUid": _user,
        //   "image":  value.image == null || value.image == '' ? null : value.image,
        //   "title": value.title == null || value.title == '' ? null : value.title,
        //    "description": value.description == null || value.description== '' ? null : value.description,
        //    "publishedAt": value.publishedAt == null || value.publishedAt== '' ? null : value.publishedAt,
        //    "content": value.content == null || value.content== '' ? null : value.content,
        //    "author": value.author == null || value.author== '' ? null : value.author,
        //    "key":key
        // };
        // print(obj);



        //   userRef.child(_user).child(key).set(obj);
      }
      else{
      data.forEach((key,values){
        print(values);
        print("already Added  news");

         Widget okButtons = TextButton(
        child: Text("OK"),
       onPressed: () => Navigator.pop(context, true), );

    AlertDialog alerts = AlertDialog(
      
      title: Center(child: Text("Add Favourite News")),
      content: Text("Already Added This News"),
      actions: [
        okButtons,
      ],
      
    );


         showDialog(
        context: context,
        builder: (BuildContext context) {
          return alerts;
        },
      );
        // News.add(values);
      });
      
      }
      });

     

      // var key = userRef.child(_user).push().key;
      //    var obj = {
      //     "userUid": _user,
      //     "image":  value.image == null || value.image == '' ? null : value.image,
      //     "title": value.title == null || value.title == '' ? null : value.title,
      //      "description": value.description == null || value.description== '' ? null : value.description,
      //      "publishedAt": value.publishedAt == null || value.publishedAt== '' ? null : value.publishedAt,
      //      "content": value.content == null || value.content== '' ? null : value.content,
      //      "author": value.author == null || value.author== '' ? null : value.author,
      //      "key":key
      //   };
        // print(obj);



        //  await userRef.child(_user).child(key).set(obj);
    }

  }

  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text("Detail New"),
        backgroundColor: Colors.pink,
        
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: [
              Card(
                 shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              color: Colors.white,
              elevation: 20,
                child: Column(
                  children: [
                    
                     value.image == null || value.image == '' ? 
                     Image.asset('assets/no.jpg') 
                     :
                     Padding(
                       padding: const EdgeInsets.all(4.0),
                       child: Container(
      constraints: new BoxConstraints.expand(
        height: 200.0,
      ),
      alignment: Alignment.bottomLeft,
      padding: new EdgeInsets.only(left: 290.0, bottom: 5.0),
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new NetworkImage(value.image),
          fit: BoxFit.cover,
        ),
      ),
      child:  IconButton(
        onPressed: addnews,
        icon: Icon(Icons.favorite_border,color: Colors.pink,size: 40,
        ),
      ),
    )
                       
                       
                       
                      //  Image.network(value.image,),
                     ),
                      SizedBox(height: 10,),
                          Row(children: [
                            Text("Title : ",
                                style: TextStyle(color: Colors.pink, fontSize: 25)),
                          ]),
                          value.title == null || value.title == ''
                              ? Text('No Title')
                              : Container(
                                  child :  Text(value.title,
                                      style:
                                          TextStyle(color: Colors.black, fontSize: 18)),
                                  ),
                          SizedBox(
                            height: 13,
                          ),
                          Row(children: [
                            Text("Description : ",
                                style: TextStyle(color: Colors.pink, fontSize: 25)),
                          ]),
                          value.description == null || value.description == ''
                              ? Text('No Description')
                              : Container(
                                  child: Text(value.description,
                                      style:
                                          TextStyle(color: Colors.black, fontSize: 18)),
                                ),

                          SizedBox(
                            height: 13,
                          ),
                          Row(children: [
                            Text("publishedAt : ",
                                style: TextStyle(color: Colors.pink, fontSize: 25)),
                          ]),
                          value.publishedAt == null || value.publishedAt == ''
                              ? Row(children: [
                                  Text("Not Show Date : ",
                                      style:
                                          TextStyle(color: Colors.pink, fontSize: 25)),
                                ])
                              : Row(children: [
                                  Text(value.publishedAt,
                                      style:
                                          TextStyle(color: Colors.black, fontSize: 18)),
                                ]),

                          SizedBox(
                            height: 13,
                          ),
                           Row(children: [
                            Text("Content : ",
                                style: TextStyle(color: Colors.pink, fontSize: 25)),
                          ]),
                             value.content == null || value.content == ''
                              ? Row(children: [
                                  Text("Not Show Content : ",
                                     ),
                                ])
                              : Container(child: 
                                  Text(value.content,
                                      style:
                                          TextStyle(color: Colors.black, fontSize: 18)),
                                ),

                          SizedBox(
                            height: 13,
                          ),
                           Row(children: [
                            Text("Author : ",
                                style: TextStyle(color: Colors.pink, fontSize: 25)),
                          ]),
                            value.author == null || value.author == ''
                              ? Row(children: [
                                  Text("No Any Author : ",
                                     ),
                                ])
                              : Row(children :  [
                                  Text(value.author,
                                      style:
                                          TextStyle(color: Colors.black, fontSize: 18)),
                              ]),

                          SizedBox(
                            height: 13,
                          ),
                           SizedBox(
                            height: 13,
                          ),
                           Row(children: [
                            Text("Url : ",
                                style: TextStyle(color: Colors.pink, fontSize: 25)),
                          ]),
                            value.url == null || value.url == ''
                              ? Row(children: [
                                  Text(" No Url : ",
                                      ),
                                ])
                              : Container(child : 
                                  Text(value.url,
                                      style:
                                          TextStyle(color: Colors.black, fontSize: 18)),
                              ),

                          SizedBox(
                            height: 13,
                          ),

                   
                   
                   
                  
                  ],
                ),
              ),
              SizedBox(height: 15,)
            ],

          ),
        ),
      ),
    );
  }
}
