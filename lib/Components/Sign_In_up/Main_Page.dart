import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:new_app/Components/Home/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import  'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TapGestureRecognizer _tapGestureRecognizer;
  bool _showSignIn;
  String userUid;
  String Name;
  String Email;
  

  @override
  void initState() {
    super.initState();
    _showSignIn = true;
    _tapGestureRecognizer = TapGestureRecognizer()
      ..onTap = () {
        setState(() {
          _showSignIn = !_showSignIn;
          // print("Hello");
        });
      };
  }

  direct(){
     Navigator.of(context).push(MaterialPageRoute(builder: (_) => Home(userUid = "NONE",Name = "Not Register user",Email = "Email None")));
  }

      drawer() async {
        String user;
      FirebaseAuth auth = FirebaseAuth.instance;
      FirebaseFirestore db = FirebaseFirestore.instance;

      final String email = useremail_login.text;
      final String password = password_login.text;

      if (email == '' ) {
         Widget okButton = TextButton(child: Text("OK"), onPressed: () {Navigator.of(context).pop(); });

      AlertDialog alert = AlertDialog(
        title: Center(child: Text("Empty Value")),
        content: Text("Plz Enter Your  Email Address"),
        actions: [
          okButton,
        ],
      );

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        );


      } 
      
      else if(password == '' ){

         Widget okButton = TextButton(child: Text("OK"), onPressed: () {Navigator.of(context).pop(); });

      AlertDialog alert = AlertDialog(
        title: Center(child: Text("Empty Value")),
        content: Text("Plz Enter Your Password "),
        actions: [
          okButton,
        ],
      );

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        );


      }
      else {
        print(email);
        print(password);

        try {
          
    
          final UserCredential user = await auth.signInWithEmailAndPassword(
              email: email, password: password);
          final DocumentSnapshot snapshot =
              await db.collection('users').doc(user.user.uid).get();

          final data = snapshot.data();

          print("User Name :" + data["username"]);
          print("User Email :" + data["email"]);

    Navigator.of(context).push(MaterialPageRoute(builder: (_) => Home(userUid = user.user.uid,Name = data["username"],Email = data["email"])));


         
         
        } catch (e) {
          print(e);
        }
      }
    }
    // Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
  // }

  void signUp() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore db = FirebaseFirestore.instance;
    final String username = usernameController.text;
    final String email = useremailController.text;
    final String password = userpasswordController.text;

    Widget okButton = TextButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.of(context).pop();
            setState(() {
          _showSignIn = !_showSignIn;
          // print("Hello");
        });
        });

    AlertDialog alert = AlertDialog(
      
      title: Center(child: Text("Empty Value")),
      content: Text("Fill All Input Fields"),
      actions: [
        okButton,
      ],
      
    );

     AlertDialog alert_reg = AlertDialog(
      title: Center(child: Text("User Register")),
      
      // content: Text("Fill All Input Fields"),
      actions: [
        okButton,
      ],
    );

    if (email == '' || password == '' || username == '') {
      print("enter all");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    } else {
      print(username + email + password);
      try {
        UserCredential userCredential = await auth
            .createUserWithEmailAndPassword(email: email, password: password);
        print(userCredential);

        var obj = {
          "email" : email,
          "password": password,
          "username" : username
        };

         await db.collection('users').doc( userCredential.user.uid).set(obj);


        showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert_reg;
        },
      );
       

        
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  final blueColor = Color(0XFF5e92f3);

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController useremailController = TextEditingController();
  final TextEditingController userpasswordController = TextEditingController();

  final TextEditingController useremail_login = TextEditingController();
  final TextEditingController password_login = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        BuildCircleTopSide(),
        BuildCircleRightSide(),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(left: 16, right: 16, top: 50, bottom: 40),
            child: Column(
              children: [
                Text(
                  _showSignIn ? "Sig In" : "Create Account",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 24,
                ),
                buildAvatarContainer(),
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOutBack,
                  height: _showSignIn ? 240 : 430,
                  margin: _showSignIn
                      ? EdgeInsets.only(top: 40)
                      : EdgeInsets.only(top: 20),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration:
                      BoxDecoration(color: Colors.grey[100], boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 2,
                      spreadRadius: 1,
                      offset: Offset(0, 1),
                    )
                  ]),
                  child: SingleChildScrollView(
                    child:
                        _showSignIn ? buildsigninWidget() : buildsignupWidget(),
                  ),
                ),
                _showSignIn
                    ? buildsigninbottomSection()
                    : buildsignupbottomSection(),

                    SizedBox(
                height: 40,
              ),
              ElevatedButton(child: Container(child: Text("Open APP"),color: Colors.pink,),
              onPressed: direct,
              style: ElevatedButton.styleFrom(
                primary: Colors.pink[300],
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                textStyle: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold))

 ,)
              ],
            ),
          ),
        )
      ]),
    );
  }

  Container buildsigninbottomSection() {
    return Container(
      margin: EdgeInsets.only(top: 50),
      child: Column(
        children: [
          Text(
            "Forget Password ?",
            style: TextStyle(
                color: Colors.blue,
                fontSize: 18,
                decoration: TextDecoration.underline),
          ),
          SizedBox(
            height: 25,
          ),
          Column(
            children: [
              Container(
                child: ElevatedButton(
                  onPressed: drawer,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                    child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "LOGIN",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            child: Icon(
                              Icons.arrow_right,
                              color: Colors.yellow,
                              size: 40,
                            ),
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(width: 0.1)),
                          ),
                        ]),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              RichText(
                  text: TextSpan(
                      text: "Don't Have an Account ? ",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                      children: [
                    TextSpan(
                        text: "Create an Account",
                        recognizer: _tapGestureRecognizer,
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ))
                  ]))
            ],
          )
        ],
      ),
    );
  }

  Container buildsignupbottomSection() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          SizedBox(
            height: 25,
          ),
          Column(
            children: [
              Container(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.purple,
                  ),
                  onPressed: signUp,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                    child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Text(
                                  "Create Account",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  child: Icon(
                                    Icons.arrow_right,
                                    color: Colors.yellow,
                                    size: 40,
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(width: 0.1)),
                                ),
                              ],
                            ),
                          ),
                        ]),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              RichText(
                  text: TextSpan(
                      text: "Already Account ? ",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                      children: [
                    TextSpan(
                        text: "Sign In",
                        recognizer: _tapGestureRecognizer,
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ))
                  ]))
            ],
          )
        ],
      ),
    );
  }

  Column buildsigninWidget() {
    return Column(
      children: [
        buildtextFeild(
            "EMAIL ADDRESS", "abc@gmail.com", false, useremail_login),
        SizedBox(
          height: 35,
        ),
        buildtextFeild("Password", "*****", true, password_login),
      ],
    );
  }

  Column buildsignupWidget() {
    return Column(
      children: [
        buildtextFeild("User Name", "ABC", false, usernameController),
        SizedBox(
          height: 20,
        ),
        buildtextFeild("Email", "abc@gmail.com", true, useremailController),
        SizedBox(
          height: 20,
        ),
        buildtextFeild("Password", "*****", false, userpasswordController),
        // SizedBox(
        //   height: 20,
        // ),
        // buildtextFeild("Contact Number", "0123456789", false),
      ],
    );
  }

  Container buildtextFeild(String email, String placeholder, bool ispassword,
      TextEditingController text_controller) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            email,
            style: TextStyle(color: Colors.blue, fontSize: 20),
          ),
          SizedBox(
            height: 5,
          ),
          TextField(
            controller: text_controller,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(16),
              filled: true,
              fillColor: Colors.grey[200],
              hintText: placeholder,
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[300]),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container buildAvatarContainer() {
    return Container(
      width: 130,
      height: 130,
      decoration: BoxDecoration(
          color: _showSignIn ? Colors.pink : Colors.grey,
          borderRadius: BorderRadius.circular(60),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 2,
              spreadRadius: 1,
              offset: Offset(0, 1),
            )
          ]),
      child: Center(
        child: Stack(
          children: [
            Positioned(
              left: 1.0,
              top: 3.0,
              child: Icon(
                Icons.person_outline,
                size: 60,
                color: Colors.black.withOpacity(.1),
              ),
            ),
            Icon(
              Icons.person_outline,
              size: 60,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Positioned BuildCircleRightSide() {
    return Positioned(
      top: MediaQuery.of(context).size.height -
          MediaQuery.of(context).size.width,
      right: MediaQuery.of(context).size.width / 2,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.pink.withOpacity(0.15),
          borderRadius:
              BorderRadius.circular(MediaQuery.of(context).size.width),
        ),
      ),
    );
  }

  Positioned BuildCircleTopSide() {
    return Positioned(
      top: 0,
      child: Transform.translate(
        offset: Offset(0.0, -MediaQuery.of(context).size.width / 1.3),
        child: Transform.scale(
          scale: 1.35,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.55,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: _showSignIn ? Colors.black : Colors.pink[800],
              borderRadius:
                  BorderRadius.circular(MediaQuery.of(context).size.width),
            ),
          ),
        ),
      ),
    );
  }
}
