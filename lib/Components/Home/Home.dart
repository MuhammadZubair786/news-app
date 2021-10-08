import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_app/Components/Drawer_Page/Drawer_Page.dart';
import 'package:new_app/Components/Home/All_Data.dart';
import 'package:new_app/Components/Home/Categories.dart';
import 'package:new_app/Components/Home/Headline.dart';
import 'package:new_app/Components/Home/Sport_News.dart';
import 'package:new_app/Components/Home/Top_new.dart';
import 'package:new_app/Components/Home/new_screen.dart';
import 'package:new_app/Components/Search/Search.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  // var userUid;
  // Home(this.userUid);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // var userUid;
  // _HomeState(this.userUid);

  @override
  // void initState() {
  //   super.initState();
  // //   print(value.title);
  // // print(value.content);
  // // print(userUid);

  // }

  int currentIndex = 0;

//   DateTime now = new DateTime.now();
// // DateTime date = new DateTime(now.year, now.month, now.day);

  var value;

  bool chg = true;

  String cat = '';

  var players = [
    {"Category": "business"},
    {"Category": " entertainment"},
    {"Category": "health"},
    {"Category": "science"},
    {"Category": "sports"},
    {"Category": "technology"},
  ];

  var users = [];
  var users2 = [];

  Future<List<dynamic>> getuser() async {
    if (cat == '') {
      var res = await http.get(Uri.parse(
          'http://api.mediastack.com/v1/news?access_key=b89e7c310e48c250ae5ddd5f0f3978b7'));
      var jsonData = jsonDecode(res.body);
      // print(jsonData["data"]);

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
    } else {
      // print(cat);
      // print(new DateTime(now.year, now.month, now.day));

      setState(() {
        users2 = [];
        users = [];
      });

      var res = await http.get(Uri.parse(
          'https://newsapi.org/v2/top-headlines?country=us&category=$cat&apiKey=1866ed19591c4d99880992a3ca614497'));
      var jsonData = jsonDecode(res.body);
      // print(jsonData['articles']);

      for (var i in jsonData['articles']) {
        UserModel2 user2 = UserModel2(i['author'], i['title'], i['description'],
            i['url'], i['urlToImage'], i['publishedAt'], i['content']);
        users2.add(user2);
        // print(i['urlToImage']);
      }

      // print(users2);
      setState(() {
        chg = false;
      });

      return users2;
    }
  }

  getnew() {
    // print(":jd fb");
  }

  getdata(e) async {
    // print(e);
    // print(users);

    setState(() {
      users = [];
      users2 = [];
      chg = true;
      cat = e;
    });
    // print(users);

    var res = await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=us&category=sports&apiKey=1866ed19591c4d99880992a3ca614497'));
    var jsonData = jsonDecode(res.body);
    // print(jsonData['articles'][0]);

    // getcat(cat);
  }

  //  getcat(cat) async {
  //    print(cat);
  //   var res = await http.get(Uri.parse(
  //       'https://newsapi.org/v2/top-headlines?country=sa&category=$cat&apiKey=1866ed19591c4d99880992a3ca614497'));
  //   var jsonData = jsonDecode(res.body);
  //   // print(jsonData['articles']);

  //   for (var i in jsonData['articles']) {
  //     UserModel2 user2 = UserModel2(
  //         i['author'],
  //         i['title'],
  //         i['description'],
  //         i['url'],

  //         i['image'],
  //         i['published_at']);
  //     users2.add(user2);
  //   }

  //   print(users2);

  //   return users2;
  // }

  // final tabs =[

  //     Container(
  //       height: 400,
  //       width: 800,
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           Text(('Home Screen'),style: TextStyle(fontSize: 30),)
  //         ],
  //       )),
  //        Container(
  //       height: 400,
  //       width: 800,
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           Text(('Search Screen'),style: TextStyle(fontSize: 30),)
  //         ],
  //       )),

  //      Container(
  //       height: 400,
  //       width: 800,
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           Text(('Camera Screen'),style: TextStyle(fontSize: 30),)
  //         ],
  //       )),
  //         Container(
  //       height: 400,
  //       width: 800,
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           Text(('Profile Screen'),style: TextStyle(fontSize: 30),)
  //         ],
  //       ))

  // ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: Text(
            "News App",
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: IconThemeData(color: Colors.white),
          actions: [
            IconButton(
                icon: Icon(Icons.notification_important), onPressed: () {}),
            IconButton(icon: Icon(Icons.search), onPressed: () {})
          ],
          elevation: 20,
          titleSpacing: 4,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.pink[300], Colors.pink[400]])),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: TabBar(
              unselectedLabelColor: Colors.black,
              labelColor: Colors.white,
              indicatorColor: Colors.white,
              indicatorWeight: 5,
              tabs: [
                Tab(
                  child: Text(
                    "Top Stories",
                    style: TextStyle(fontSize: 11),
                  ),
                ),
                Tab(
                  child: Text(
                    "Headlines",
                    style: TextStyle(fontSize: 11),
                  ),
                ),
                Tab(
                  child: Text(
                    "Popular News",
                    style: TextStyle(fontSize: 11),
                  ),
                ),
                Tab(
                  child: Text(
                    "Sports News",
                    style: TextStyle(fontSize: 11),
                  ),
                )
              ],
            ),
          ),
        ),
        drawer: drawerTab(context),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: SingleChildScrollView(
                      child: Column(children: [
                        Padding(padding: EdgeInsets.all(20)),
                        Text(
                          "Categories",
                          style: TextStyle(
                              fontSize: 25,
                              fontFamily: 'Arial',
                              color: Colors.pink,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(padding: EdgeInsets.all(10)),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: buildCategories(),
                        ),
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
                                "loading Top News.....",
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
                            cat == ''
                                ? Text(
                                    "Top News",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontFamily: 'Arial',
                                        color: Colors.pink,
                                        fontWeight: FontWeight.bold),
                                  )
                                : Text(
                                    "Select Categories " + cat,
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.pink[400],
                                        fontFamily: 'Arial',
                                        fontWeight: FontWeight.bold),
                                  ),
                            ListView.builder(
                                physics: ScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, i) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        chg
                                            ? GestureDetector(
                                                onTap: () =>
                                                    Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (_) => newScreen(
                                                          value = snapshot
                                                              .data[i])),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(0),
                                                  child: Card(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              1),
                                                    ),
                                                    color: Colors.white,
                                                    elevation: 10,
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
                                                                  snapshot
                                                                          .data[
                                                                              i]
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
                                                        Divider(color: Colors.red,),
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
                                                                snapshot.data[i]
                                                                    .title),
                                                            Text(
                                                              
                                                              "Published At :" +
                                                                  snapshot
                                                                      .data[i]
                                                                      .publishedAt,
                                                          style: TextStyle(color: Colors.pink), ),
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
                                                  ),
                                                ),
                                              )
                                            : GestureDetector(
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
                                                                  .circular(1),
                                                        ),
                                                        color: Colors.white,
                                                        elevation: 10,
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              width: 100,
                                                              height: 100,
                                                              child: snapshot.data[i].image ==
                                                                          null ||
                                                                      snapshot.data[i]
                                                                              .image ==
                                                                          ''
                                                                  ? Image.asset(
                                                                      'assets/no.jpg',
                                                                      width:
                                                                          200,
                                                                      height:
                                                                          200,
                                                                    )
                                                                  : Image.network(
                                                                      snapshot
                                                                          .data[
                                                                              i]
                                                                          .image,
                                                                      width:
                                                                          200,
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
                                                                          .data[
                                                                              i]
                                                                          .publishedAt,
                                                                          style: TextStyle(color: Colors.pink),
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
            ),
            Container(
              child: headLine(),
            ),
            Container(
              child: TopNews(),
            ),
            Container(
              child: SportNews(),
            ),
          ],
        ),
      ),
    );
  }

  GridView buildCategories() {
    return GridView.count(
      physics: ScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 0.0,
      mainAxisSpacing: 0.0,
      childAspectRatio: (0.9 / .4),
      shrinkWrap: true,
      children: List<Widget>.generate(
        players.length,
        (index) {
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.pink[400], // background
                    onPrimary: Colors.white, // foreground
                  ),
                  onPressed: () => getdata(players[index]['Category']),
                  child: Text(players[index]['Category'])),

              // image: DecorationImage(
              //   image: AssetImage('assets/main.png'),
              //   fit: BoxFit.cover,
              // ),
            ),
          );
        },
      ),
    );
  }

  Drawer drawerTab(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              child: Container(
            width: 300.0,
            height: 600.0,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: NetworkImage("https://i.gifer.com/2ZMo.gif"),
              // fit: BoxFit.cover
            )),
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon((Icons.supervised_user_circle_rounded)),
                  color: Colors.red,
                  iconSize: 60,
                  onPressed: () {},
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ("User"),
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      ("User@gmail.com"),
                      style: TextStyle(color: Colors.black),
                    )
                  ],
                )
              ],
            )),
          )),
          Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  color: Colors.white,
                  child: (Row(
                    children: <Widget>[
                      // ...
                      Expanded(
                        child: Column(
                          children: <Widget>[Divider(color: Colors.black)],
                        ),
                      )
                    ],
                  )),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Home()));
                  },
                  child: ListTile(
                      leading: IconButton(
                        icon: Icon((Icons.home)),
                        color: Colors.blueGrey,
                        iconSize: 30,
                        onPressed: () {},
                      ),
                      title: Text("Home")),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Service()));
                  },
                  child: ListTile(
                      leading: IconButton(
                        icon: Icon((Icons.screen_search_desktop)),
                        color: Colors.blueGrey,
                        iconSize: 30,
                        onPressed: () {},
                      ),
                      title: Text("Search New")),
                ),
                ListTile(
                    leading: IconButton(
                      icon: Icon((Icons.featured_video_rounded)),
                      color: Colors.blueGrey,
                      iconSize: 30,
                      onPressed: () {},
                    ),
                    title: Text("Favourite New")),
                ListTile(
                    leading: IconButton(
                      icon: Icon((Icons.contact_page)),
                      color: Colors.blueGrey,
                      iconSize: 30,
                      onPressed: () {},
                    ),
                    title: Text("Contact")),
                ListTile(
                    leading: IconButton(
                      icon: Icon((Icons.settings_sharp)),
                      color: Colors.blueGrey,
                      iconSize: 30,
                      onPressed: () {},
                    ),
                    title: Text("User Profile")),
                ListTile(
                    leading: IconButton(
                      icon: Icon((Icons.login_outlined)),
                      color: Colors.blueGrey,
                      iconSize: 30,
                      onPressed: () {},
                    ),
                    title: Text("Log Out")),
              ])
        ],
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
      this.image, this.category, this.language, this.country, this.publishedAt);
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
