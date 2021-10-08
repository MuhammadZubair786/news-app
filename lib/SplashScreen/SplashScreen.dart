import 'package:flutter/material.dart';
import 'dart:async';
import 'package:new_app/Components/Sign_In_up/Main_Page.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 5),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginPage())));
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      fit: StackFit.expand,
      children: [
        Padding(
            padding: const EdgeInsets.only(top: 25.0),
            // child: Container(
            //     decoration: BoxDecoration(
            //   image: DecorationImage(
            //     image: AssetImage("assets/bg5.gif"),
            //     fit: BoxFit.cover,
            //   ),
            // )
            // )
            ),
        Center(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
                ),
                Image.asset('assets/main.png'),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                CircularProgressIndicator(
                  strokeWidth: 5,
                  backgroundColor: Colors.white,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
                Text(
                  " News  App",
                  style: TextStyle(
                      fontFamily: 'Lobster',
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue     ),
                )
              ],
            ),
          ),
        )
      ],
    ));
  }
}

   
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//           padding: const EdgeInsets.only(top: 25.0),
//           child: Container(
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage("assets/bg5.gif"),
//                 fit: BoxFit.cover,

//               ),
//           ),
//           child: Center(
//             child: Center(
//               child: Column(
//                 children: [
//                   SizedBox(
//                     height: MediaQuery.of(context).size.height * 0.25,
//                   ),
//                   Image.asset('assets/main.png'),
//                   SizedBox(
//                     height: MediaQuery.of(context).size.height * 0.05,
//                   ),
//                   CircularProgressIndicator(
//                     strokeWidth: 5,
//                     backgroundColor: Colors.white,
//                   ),
//                   SizedBox(
//                     height: MediaQuery.of(context).size.height * 0.2,
//                   ),
//                   Text(" News  App",style: TextStyle(fontFamily: 'Lobster',fontSize : 25,fontWeight: FontWeight.bold,color: Colors.white),)
//                 ],
//               ),
//             ),
//           )),
//     )
//     );
//   }
// }
