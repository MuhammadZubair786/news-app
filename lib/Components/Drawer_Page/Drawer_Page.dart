import 'package:flutter/material.dart';
import 'package:new_app/Components/Home/Home.dart';



class Drawer_Page extends StatefulWidget {
 

  @override
  _Drawer_PageState createState() => _Drawer_PageState();
}

class _Drawer_PageState extends State<Drawer_Page> {
  @override
  Widget build(BuildContext context) {
     return MaterialApp(
      debugShowCheckedModeBanner: false,
      
        home: Scaffold(
          
      appBar: AppBar(
         backgroundColor: Colors.cyan,
        title: Text("Drawer Example",style: TextStyle(color: Colors.black),),
         iconTheme: IconThemeData(color: Colors.black),
      ),
      

      drawer: drawerTab(context),
     
      
       

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
              image: NetworkImage(
                  "https://i.gifer.com/2ZMo.gif"),
              // fit: BoxFit.cover
            )
            ),
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
          )
          ),
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
                        children: <Widget>[
                       
                          Divider(color: Colors.black)
                        ],
                      ),
                    )
                  ],
                )),
              ),

              GestureDetector(onTap:(){
                // Navigator.pop(context);
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context)=>Home()));
              },
              child:  ListTile(
                leading:   IconButton(
                  icon: Icon((Icons.home)),
                  color: Colors.blueGrey,
                  iconSize: 30,
                  onPressed: () {},
                ),
                title: Text("Home")
              
              ),
              ),
            
             
               GestureDetector(onTap:(){
                // Navigator.pop(context);
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context)=>Text("ok")));
              },
              child:  ListTile(
                leading:   IconButton(
                  icon: Icon((Icons.home)),
                  color: Colors.blueGrey,
                  iconSize: 30,
                  onPressed: () {},
                ),
                title: Text("Services")
              
              ),
              ),
                ListTile(
                leading:   IconButton(
                  icon: Icon((Icons.contact_page)),
                  color: Colors.blueGrey,
                  iconSize: 30,
                  onPressed: () {},
                ),
                title: Text("Contact")
              
              ),
              ListTile(
                leading:   IconButton(
                  icon: Icon((Icons.app_blocking_rounded)),
                  color: Colors.blueGrey,
                  iconSize: 30,
                  onPressed: () {},
                ),
                title: Text("About")
              
              ),

               ListTile(
                leading:   IconButton(
                  icon: Icon((Icons.settings_sharp)),
                  color: Colors.blueGrey,
                  iconSize: 30,
                  onPressed: () {},
                ),
                title: Text("Setting")
              
              ),
                 ListTile(
                leading:   IconButton(
                  icon: Icon((Icons.login_outlined)),
                  color: Colors.blueGrey,
                  iconSize: 30,
                  onPressed: () {},
                ),
                title: Text("Log Out")
              
              ),
              

             
            ])
        ],
      ),
    );
  }
}