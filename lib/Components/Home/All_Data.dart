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
        title: Text("new"),
      ),
      body: SingleChildScrollView(
        child: Card(
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

              value.description == null  || value.description == '' ? Text('Description : NoDescription') :  Text('Description : '+value.description),
              value.publishedAt == null || value.publishedAt == '' ?  Text("Date : ") :  Text(value.publishedAt),
              value.content == null || value.content == '' ?  Text("Date : ") :  Text("Content :"+value.content),
              value.author == null || value.author == '' ? Text("No Author"):Text("Author :"+value.author),
              Text("Url :"+value.url),
              
              Container(
                child: Text("Title : "+value.title),

              ),
            ],
          ),
        ),
      ),
    );
  }
}
