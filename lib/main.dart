// import 'package:firebase_db_auth/Splash_Screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:new_app/Components/Home/Bussiness.dart';
import 'package:new_app/Components/Home/Home.dart';
import 'package:new_app/SplashScreen/SplashScreen.dart';
import 'package:new_app/store/state.dart';
import 'package:new_app/store/state.dart';

// import 'Home.dart';
// import 'login_user.dart';
// import 'register.dart';

// enum Types {user}



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final  Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Container();
        }
        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home:SplashScreen(),
            routes: {
              // '/login': (context)=> Login(),
              // "/sig_up" :  (context)=> Register(),
              // "/home" :  (context)=> Drawer_Page(),
              // "/home": (context)=>Home(),
              "/bussiness":(context) =>Bussiness()
            },
            
         
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Container();
      },
    );
  
  }
}
