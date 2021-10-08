import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:new_app/Components/Drawer_Page/Drawer_Page.dart';
import 'package:new_app/Components/Search/Search.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;

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
            style: TextStyle(color: Colors.black),
          ),
          iconTheme: IconThemeData(color: Colors.black),
          actions: [
            IconButton(
                icon: Icon(Icons.notification_important), onPressed: () {}),
            IconButton(icon: Icon(Icons.search), onPressed: () {})
          ],
          elevation: 20,
          titleSpacing: 4,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient:
                    LinearGradient(colors: [Colors.cyanAccent, Colors.cyan])),
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
            Column(
              children: [
                Container(
                  child: Text("Home"),
                ),
                ElevatedButton(
                  child: Text("CLICK"),
                  onPressed: getuser,
                ),
                FutureBuilder(
                  future: getuser(),
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return Container(
                        child: Text("No Data"),
                      );
                    } else {
                      return Expanded(
                        child: SizedBox(
                          height: 200.0,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, i) {
                                return Column(
                                  children: [

                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Container(
                                        
                                          decoration: BoxDecoration(
                                            color: Colors.lightBlueAccent,
                                            // image: const DecorationImage(
                                            //   image: NetworkImage(
                                            //       'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
                                            //   fit: BoxFit.cover,
                                            // ),
                                            border: Border.all(
                                              color: Colors.black,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Column(
                                            children: [

                                             snapshot.data[i].image == null || snapshot.data[i].image == '' ? Image.asset('assets/no.jpg')  : Image.network(snapshot.data[i].image),
                                              ListTile(
                                                title: Text("Title : " + snapshot.data[i].title),
                                                subtitle:  Text(
                                                snapshot.data[i].author == null ? 'null' : "Author :" + snapshot.data[i].author,),
                                              ),
                                               ListTile(
                                                title: Text("Description : " + snapshot.data[i].description),
                                                subtitle:  Text(
                                               "Published At :" + snapshot.data[i].publishedAt,),
                                              ),
                                             
                                            ],
                                          )),
                                    ),
                                  ],
                                );
                              }),
                        ),
                      );
                    }
                  },
                )
              ],
            ),
            Container(
              child: Text("Login"),
            ),
            Container(
              child: Text("Page"),
            ),
            Container(
              child: Text("Home"),
            ),
          ],
        ),
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
                  color: Colors.blueGrey,
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
      this.image, this.category, this.country, this.language, this.publishedAt);
}
