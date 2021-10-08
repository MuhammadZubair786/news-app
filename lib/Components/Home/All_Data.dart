import 'package:flutter/material.dart';

class Alldata extends StatefulWidget {
  var value;
  Alldata(this.value);

  @override
  _AlldataState createState() => _AlldataState(value);
}

class _AlldataState extends State<Alldata> {
  var value;
  _AlldataState(this.value);

  @override
  void initState() {
    super.initState();
  //   print(value.title);
  // print(value.content);
  print(value.author);

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
                       child: Image.network(value.image,),
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
