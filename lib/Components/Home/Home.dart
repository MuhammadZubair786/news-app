import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:new_app/Components/Home/Show_Detail_News.dart';
import 'package:new_app/Components/Favourite_New/Favourite.dart';
import 'package:new_app/Components/Headline/Headline.dart';
import 'package:new_app/Components/Sport_News/Sport_News.dart';
import 'package:new_app/Components/Top_News/Top_new.dart';
import 'package:new_app/Components/Profile/profile.dart';
import 'package:new_app/Components/Search/Search.dart';
import 'package:http/http.dart' as http;
import 'package:new_app/SplashScreen/SplashScreen.dart';

class Home extends StatefulWidget {
  var userUid;
  var Name;
  var Email;
  Home(this.userUid,this.Name,this.Email);

  @override
  _HomeState createState() => _HomeState(userUid,Name,Email);
}

class _HomeState extends State<Home> {
 var userUid;
  var Name;
  var Email;
  _HomeState(this.userUid,this.Name,this.Email);

  

  @override
  void initState() {
   
    super.initState();
    
  //   print(value.title);
  // print(value.content);
       
  print("User Uid :"+userUid);
    print("User Name 2 :" + Name);
          print("User Email  2:" + Email);

  }

  int currentIndex = 0;

//   DateTime now = new DateTime.now();
// // DateTime date = new DateTime(now.year, now.month, now.day);

  var value;

String _user;
String uid;
  bool chg = true;

  String cat = '';

  var Categories = [
    {"Category": "business","Icon":"Icons.business_center_sharp","Category_name": "Bussiness"},
    {"Category": "entertainment","Icon":"movie_filter_outlined","Category_name": "Entertainment"},
    {"Category": "health","Icon":"hail","Category_name": "Health"},
    {"Category": "science","Icon":"science_rounded","Category_name": "Science"},
    {"Category": "sports","Icon":"sports_soccer_sharp","Category_name": "Sports"},
    {"Category": "technology","Icon":"computer_rounded","Category_name": "Technology"},
  ];

  var users = [];
  var users2 = [];

  Future<List<dynamic>> getuser() async {
     setState(() {
        users2 = [];
        users = [];
      });
    if (cat == '') {
      var res = await http.get(Uri.parse(
          'https://newsapi.org/v2/everything?q=tesla&sortBy=publishedAt&apiKey=1866ed19591c4d99880992a3ca614497'));
      var jsonData = jsonDecode(res.body);
      // print(jsonData['articles']);

      for (var i in jsonData['articles']) {
        UserModel2 user2 = UserModel2(i['author'], i['title'], i['description'],
            i['url'], i['urlToImage'], i['publishedAt'], i['content']);
        users2.add(user2);
        // print(i['urlToImage']);
      }

      return users2;
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

  signOut(){
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.signOut();
    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SplashScreen()));


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
                    "Top News",
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
                        Padding(padding: EdgeInsets.all(4)),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
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
                                                      builder: (_) =>  Alldata(
                                                          value = snapshot.data[i],
                                                          _user = userUid
                                                  )
                                                          
                                                          )
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
                                                            Text(
                                                                snapshot.data[i]
                                                                    .title,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                                            Text(
                                                              
                                                              "Published At " +
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
                                                              .data[i],
                                                              _user = userUid
                                                              )),
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
                                                                Text(
                                                                snapshot.data[i]
                                                                    .title,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                                            Text(
                                                              
                                                              "Published At " +
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
              child: headLine(userUid=userUid),
            ),
            Container(
              child: TopNews(userUid=userUid),
            ),
            Container(
              child: SportNews(userUid=userUid),
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
        Categories.length,
        (index) {
          return Padding(
            
            padding: const EdgeInsets.all(5.0),
            child:  SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              
              
              child: Container(
                width: MediaQuery.of(context).size.width*100,
                
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.pink[400], // background
                      onPrimary: Colors.white, // foreground
                    ),
                    onPressed: () => getdata(Categories[index]['Category']),
                    child: Row(
                      children: [

                        Categories[index]['Category'] == 'business' ?
                          Icon(Icons.business_center_sharp,size: 40,)
                          : 
                          Text(""),
                           Categories[index]['Category'] == 'sports' ?
                          Icon(Icons.sports_basketball,size: 40,)
                          : 
                          Text(""),
                            Categories[index]['Category'] == 'health' ?
                          Icon(Icons.hail,size: 40,)
                          : 
                          Text(""),
                            Categories[index]['Category'] == 'science' ?
                          Icon(Icons.science_sharp,size: 40,)
                          : 
                          Text(""),
                           Categories[index]['Category'] == 'entertainment' ?
                          Icon(Icons.movie_filter_outlined,size: 40,)
                          : 
                          Text(""),
                           Categories[index]['Category'] == 'technology' ?
                          Icon(Icons.computer_sharp,size: 40,)
                          : 
                          Text(""),
                          SizedBox(width: 5,),

                  
                      
                        Text(Categories[index]['Category_name']),
                      ],
                    )),

                // image: DecorationImage(
                //   image: AssetImage('assets/main.png'),
                //   fit: BoxFit.cover,
                // )
              ),
            )
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
                      (Name),
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      (Email),
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
                        MaterialPageRoute(builder: (context) => Home(userUid,Name,Email)));
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
                        MaterialPageRoute(builder: (context) => Service(userUid,Name,Email)));
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
                  GestureDetector(
                  onTap: () {
                    // Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => FavouriteNews(userUid,Name,Email)));
                  },
                  child: ListTile(
                        leading: IconButton(
                          icon: Icon((Icons.featured_video_rounded)),
                          color: Colors.blueGrey,
                          iconSize: 30,
                          onPressed: (){},
                        ),
                        title: Text("Favourite New")),
                ),
                     
                
                ListTile(
                    leading: IconButton(
                      icon: Icon((Icons.contact_page)),
                      color: Colors.blueGrey,
                      iconSize: 30,
                      onPressed: () {},
                    ),
                    title: Text("Contact")),
                GestureDetector(
                  onTap: () {
                    // Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Profile(userUid,Name,Email)));
                  },
                  child: ListTile(
                    leading: IconButton(
                      icon: Icon((Icons.settings_sharp)),
                      color: Colors.blueGrey,
                      iconSize: 30,
                      onPressed: () {},
                    ),
                    title: Text("User Profile")),),
                 GestureDetector(
                  onTap:
                     signOut
                    // // Navigator.pop(context);
                    //  FirebaseAuth.instance.signOut();
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => SplashScreen()));
                  ,
                  child:  ListTile(
                    leading: IconButton(
                      icon: Icon((Icons.login_outlined)),
                      color: Colors.blueGrey,
                      iconSize: 30,
                      onPressed: () {},
                    ),
                    title: Text("Log Out")),)


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
