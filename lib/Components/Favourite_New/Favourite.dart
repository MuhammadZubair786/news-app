

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:new_app/Components/Home/Home.dart';
import 'package:new_app/Components/Profile/profile.dart';
import 'package:new_app/Components/Search/Search.dart';
import 'package:new_app/SplashScreen/SplashScreen.dart';

class FavouriteNews extends StatefulWidget {
  var userUid;
  var Name;
  var Email;
  FavouriteNews(this.userUid, this.Name, this.Email);
  @override
  _FavouriteNewsState createState() =>
      _FavouriteNewsState(userUid, Name, Email);
}

class _FavouriteNewsState extends State<FavouriteNews> {
  var userUid;
  var Name;
  var Email;
  _FavouriteNewsState(this.userUid, this.Name, this.Email);
  @override

  

   
  void initState() {
   
    super.initState();
    
  //   print(value.title);
  // print(value.content);
       
  print("User Uid jdjd :"+userUid);
    print("User Name 2 djjd :" + Name);
          print("User Email jdjd  2:" + Email);

  }
  final userRef = FirebaseDatabase.instance.reference().child('fav_news');
  var news = [];

  var value;

   String _user;


    signOut(){
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.signOut();
    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SplashScreen()));


  }



  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
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
            ),
            drawer: drawerTab(context),
            body: SingleChildScrollView(
              child: Column(
               
                children: [ 
                  
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        children: [
                           Padding(
                             padding: const EdgeInsets.all(1.0),
                             child: Text(
                  "Your Favourite News",
                  style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'Arial',
                      color: Colors.pink[400],
                      fontWeight: FontWeight.bold),
                ),
                           ),
                          Flexible(
                            child: new FirebaseAnimatedList(
                                query: userRef.child(userUid),
                                itemBuilder: (BuildContext context, DataSnapshot snapshot,
                                    Animation<double> animation, int index) {
                                  var x = snapshot.value['title'];
                                  print(x);
                                  return Column(
                                    children: [
                                      Padding(padding: EdgeInsets.all(4)),
                                      Padding(
                                          padding: const EdgeInsets.all(2),
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
                                                borderRadius: BorderRadius.circular(5),
                                                // ),
                                              ),
                                              child: Card(
                                                 shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(5),
                                                      ),
                                                      color: Colors.white,
                                                      elevation: 20,
                                                  child: Row(
                                                    children: [
                                                   
                                                          Container(
                                                            width: 100,
                                                            height: 100,
                                                            child: snapshot.value['image'] ==
                                                                        null ||
                                                                    snapshot.value['image']
                                                                            ==
                                                                        ''
                                                                ? Image.asset(
                                                                    'assets/no.jpg',
                                                                    width: 200,
                                                                    height: 200,
                                                                  )
                                                                : Image.network(
                                                                    snapshot.value['image'],
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
                                                                MainAxisAlignment.start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                snapshot.value['title'],
                                                                style: TextStyle(
                                                                    fontSize: 15,
                                                                    fontWeight:
                                                                        FontWeight.bold),
                                                              ),
                                                              Text(
                                                                "Published At " +
                                                                     snapshot.value['publishedAt'],
                                                                       
                                                                style: TextStyle(
                                                                    color: Colors.pink),
                                                              ),
                                                            ],
                                                          ))
                                                    ],
                                                  ))),
                                        ),
                                      
                                    ],
                                  );
                                })),
                        ],
                      ),
                    ),
                  ),
                  ]  ),
            )));
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
                  child: ListTile(
                      leading: IconButton(
                        icon: Icon((Icons.login_outlined)),
                        color: Colors.blueGrey,
                        iconSize: 30,
                        onPressed: () {},
                      ),
                      title: Text("Log Out")),
                ),
              ])
        ],
      ),
    );
  }
}



class UserModel2 {
  var author;
  var title;
  var description;
  var image;
  var publishedAt;
  var content;
  var key;

  UserModel2(this.author, this.title, this.description, this.image,
      this.publishedAt, this.content, this.key);
}
