import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:new_app/Components/Home/All_Data.dart';


class headLine extends StatefulWidget {


  @override
  _headLineState createState() => _headLineState();
}

class _headLineState extends State<headLine> {

   DateTime now = new DateTime.now();

   var news = [];

    var value;


  @override
   void initState() {
    super.initState();
    print(now.year);
   
  }

   getuser() async {
   
      var res = await http.get(Uri.parse(
          'https://newsapi.org/v2/everything?q=tesla&from=$now.year-$now.month-$now.day&sortBy=publishedAt&apiKey=1866ed19591c4d99880992a3ca614497'));
      var jsonData = jsonDecode(res.body);

      print(jsonData['articles'].length);

      for (var i in jsonData['articles']) {
        UserModel2 today_new = UserModel2(i['author'], i['title'], i['description'],
            i['url'], i['urlToImage'], i['publishedAt'], i['content']);
        news.add(today_new);
        // print(i['urlToImage']);
      }

      print(news);

      return news;
    

   }


  Widget build(BuildContext context) {
    return SingleChildScrollView(

      child: Column(
        children: [
          Container(
                    child: SingleChildScrollView(
                      child: Column(children: [
                        Padding(padding: EdgeInsets.all(20)),
                        Text(
                          "Today News",
                          style: TextStyle(
                              fontSize: 25,
                              fontFamily: 'Arial',
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(padding: EdgeInsets.all(10)),
                      
                      ]),
                    ),
                  ),
          
            
          
           FutureBuilder(
                    future: getuser(),
                    builder: (context, snapshot) {
                      
                      if (snapshot.data == null) {
                        return Center(
                          child: Column(
                            children: [
                              Text(
                                "loading Today News.....",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Arial',
                                ),
                              ),
                              Container(
                                child: CircularProgressIndicator(),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Column(
                          children: [
                           
                            ListView.builder(
                                physics: ScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, i) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                       GestureDetector(
                                                onTap: () =>
                                                    Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (_) => Alldata(
                                                          value = snapshot
                                                              .data[i])),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                        // color: Colors.pink,
                                                        // image: const DecorationImage(
                                                        //   image: NetworkImage(
                                                        //       'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
                                                        //   fit: BoxFit.cover,
                                                        // ),
                                                        border: Border.all(
                                                          color: Colors.white,
                                                          width: 0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        // ),
                                                      ),
                                                      child: Card(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        color: Colors.white,
                                                        elevation: 20,
                                                        child: Row(
                                                        children: [
                                                          Container(
                                                            width: 100,
                                                            height: 100,
                                                            child: snapshot
                                                                            .data[
                                                                                i]
                                                                            .image ==
                                                                        null ||
                                                                    snapshot.data[i]
                                                                            .image ==
                                                                        ''
                                                                ? Image.asset(
                                                                    'assets/no.jpg',
                                                                    width: 200,
                                                                    height: 200,
                                                                  )
                                                                : Image.network(
                                                                    snapshot
                                                                        .data[i]
                                                                        .image,
                                                                    width: 200,
                                                                    height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height,
                                                                  ),
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Expanded(
                                                              child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text("Title : " +
                                                                  snapshot
                                                                      .data[i]
                                                                      .title),
                                                              Text(
                                                                "Published At :" +
                                                                    snapshot
                                                                        .data[i]
                                                                        .publishedAt,
                                                              ),
                                                            ],
                                                          ))

                                                          // ListTile(
                                                          //         leading: Container(
                                                          //           height: 200,
                                                          //           child: SizedBox(
                                                          //               height: 200.0,
                                                          //               width:
                                                          //                   100.0, // fixed width and height
                                                          //               child: snapshot.data[i].image ==
                                                          //                           null ||
                                                          //                       snapshot.data[i].image ==
                                                          //                           ''
                                                          //                   ? Image.asset(
                                                          //                       'assets/no.jpg')
                                                          //                   : Image
                                                          //                       .network(
                                                          //                       snapshot
                                                          //                           .data[i]
                                                          //                           .image,
                                                          //                       width:
                                                          //                           400,
                                                          //                       height:
                                                          //                           200,
                                                          //                       fit: BoxFit
                                                          //                           .fill,
                                                          //                     )),
                                                          //         ),
                                                          //         title: Text(
                                                          //             "Title : " +
                                                          //                 snapshot
                                                          //                     .data[
                                                          //                         i]
                                                          //                     .title),
                                                          //         subtitle: Text(
                                                          //             "Author :"),
                                                          //       ),
                                                          // ListTile(
                                                          //   title: Text(
                                                          //       "Description : " +
                                                          //           snapshot.data[i]
                                                          //               .description),
                                                          //   subtitle: Text(
                                                          //     "Published At :" +
                                                          //         snapshot.data[i]
                                                          //             .publishedAt,
                                                          //   ),
                                                          // ),
                                                        ],
                                                      ),
                                                      )),
                                                ),
                                              ),
                                      ],
                                    ),
                                  );
                                }),
                          ],
                        );
                      }
                    },
                  ),
        ],
      ),
    );
  }
  
}


class UserModel2 {
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
  var content;

  UserModel2(this.author, this.title, this.description, this.url, this.image,
      this.publishedAt, this.content);
}