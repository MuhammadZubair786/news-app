import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_app/Components/Home/All_Data.dart';
import 'package:new_app/Components/Home/Home.dart';
import 'package:new_app/Components/Search/Search.dart';


class Profile extends StatefulWidget {
 var userUid;
  var Name;
  var Email;
  Profile(this.userUid,this.Name,this.Email);

  @override
  _ProfileState createState() => _ProfileState(userUid,Name,Email);
}

class _ProfileState extends State<Profile> {

  var userUid;
  var Name;
  var Email;

  void initState() {
   
    super.initState();
    
  //   print(value.title);
  // print(value.content);
       
  print("User Uid :"+userUid);
    print("User Name 2 :" + Name);
          print("User Email  2:" + Email);

  }
  _ProfileState(this.userUid,this.Name,this.Email);
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar:  AppBar(
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
          body: Center(
            child: Column(
              children: [
                Text("user Name : "+Name,style: TextStyle(fontSize: 25,color: Colors.pink),),
                Text("User Email :" +Email,style: TextStyle(fontSize: 25,color: Colors.pink)),
              ],
            ),
          )
        ));
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