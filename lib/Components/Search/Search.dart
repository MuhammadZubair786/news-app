import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_app/Components/Home/Show_Detail_News.dart';
import 'package:new_app/Components/Favourite_New/Favourite.dart';
import 'package:new_app/Components/Home/Home.dart';
import 'package:http/http.dart' as http;
import 'package:new_app/Components/Profile/profile.dart';
import 'package:new_app/SplashScreen/SplashScreen.dart';

class Service extends StatefulWidget {
  var userUid;
  var Name;
  var Email;
  Service(this.userUid, this.Name, this.Email);
  @override
  _ServiceState createState() => _ServiceState(userUid, Name, Email);
}

class _ServiceState extends State<Service> {
  var userUid;
  var Name;
  var Email;
  _ServiceState(this.userUid, this.Name, this.Email);

  bool pressCountry = false;
  bool pressCat = false;
  bool selectData = false;
  bool showCountry = false;
  bool showCat = false;

  bool data = true;

  String _user;

  String title;

   signOut(){
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.signOut();
    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SplashScreen()));


  }
  // DateTime selectedDate = DateTime.now();
  // DateTime FromDate = DateTime.now();

  var news;

  String selectCty;

  var value;

  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime picked = await showDatePicker(
  //       context: context,
  //       initialDate: selectedDate,
  //       firstDate: DateTime(2015, 8),
  //       lastDate: DateTime(2101));
  //   if (picked != null && picked != selectedDate)
  //     setState(() {
  //       selectedDate = picked;
  //     });
  // }

  // Future<void> _fromDate(BuildContext context) async {
  //   final DateTime picked = await showDatePicker(
  //       context: context,
  //       initialDate: selectedDate,
  //       firstDate: DateTime(2015, 8),
  //       lastDate: DateTime(2101));
  //   if (picked != null && picked != FromDate)
  //     setState(() {
  //       FromDate = picked;
  //     });
  // }

  var Cat = ["Headline", "sports", "Top News", "business"];

  var country_name = [
    'Argentina',
    'Australia',
    'Austria',
    'Belgium',
    'Brazil',
    'Bulgaria',
    'Canada',
    'China',
    'Colombia',
    'Cuba',
    'Czech Republic',
    'Egypt',
    'France',
    'Germany',
    'Greece',
    'Hong Kong',
    'Hungary',
    'India',
    'Indonesia',
    'Ireland',
    'Israel',
    'Italy',
    'Japan',
    'Latvia',
    'Lithuania',
    'Malaysia',
    'Mexico',
    'Morocco',
    'Netherlands',
    'New Zealand',
    'Nigeria',
    'Norway',
    'Philippines',
    'Poland',
    'Portugal',
    'Romania',
    'Russia',
    'Saudi Arabia',
    'Serbia',
    'Singapore',
    'Slovakia',
    'Slovenia',
    'South Africa',
    'South Korea',
    'Sweden',
    'Switzerland',
    'Taiwan',
    'Thailand',
    'Turkey',
    'UAE',
    'Ukraine',
    'United Kingdom',
    'United States',
    'Venuzuela'
  ];

  var country_code = [
    'ar',
    'au',
    'at',
    'be',
    'br',
    'bg',
    'ca',
    'cn',
    'co',
    'cu',
    'cz',
    'eg',
    'fr',
    'de',
    'gr',
    'hk',
    'hu',
    'in',
    'id',
    'ie',
    'il',
    'it',
    'jp',
    'lv',
    'lt',
    'my',
    'mx',
    'ma',
    'nl',
    'nz',
    'ng',
    'no',
    'ph',
    'pl',
    'pt',
    'ro',
    'ru',
    'sa',
    'rs',
    'sg',
    'sk',
    'za',
    'kr',
    'ch',
    'tw',
    'th',
    'tr',
    'ae',
    'ua',
    'gb',
    'us',
    've'
  ];
  String chooseValue = '';
  String chooseCountry = '';

  selectapi() {
    if (chooseValue == '') {
      print("no");
    } else {
      setState(() {
        selectData = true;
      });
    }
  }

  Future<List<dynamic>> getuser() async {
    if (chooseValue == '') {
      print("no");
      return news = [];
    } else {
      print(country_name.length);
      print(country_code.length);
      for (var i = 0; i < country_name.length; i++) {
        if (country_name[i] == chooseCountry) {
          print(country_code[i]);
          setState(() {
            selectCty = country_code[i];
          });
          print(selectCty);
        }
      }

      setState(() {
        news = [];
      });

      if (chooseValue == 'Headline' && chooseCountry == '') {
        var res = await http.get(Uri.parse(
            'https://newsapi.org/v2/top-headlines?country=us&apiKey=1866ed19591c4d99880992a3ca614497'));
        var jsonData = jsonDecode(res.body);

        print(jsonData['articles'].length);

        for (var i in jsonData['articles']) {
          UserModel2 today_new = UserModel2(
              i['author'],
              i['title'],
              i['description'],
              i['url'],
              i['urlToImage'],
              i['publishedAt'],
              i['content']);
          news.add(today_new);
          // print(i['urlToImage']);
        }

        return news;
      } else if (chooseValue == 'Headline' ||
          chooseValue == 'Top News' && chooseCountry != '') {
        print("not head");
        setState(() {
          news = [];
        });

        var res = await http.get(Uri.parse(
            'https://newsapi.org/v2/top-headlines?country=$selectCty&apiKey=1866ed19591c4d99880992a3ca614497'));
        var jsonData = jsonDecode(res.body);

        print(jsonData['articles'].length);

        for (var i in jsonData['articles']) {
          UserModel2 today_new = UserModel2(
              i['author'],
              i['title'],
              i['description'],
              i['url'],
              i['urlToImage'],
              i['publishedAt'],
              i['content']);
          news.add(today_new);
          // print(i['urlToImage']);
        }

        return news;
      } else if (chooseValue != '' &&
          chooseValue != 'Headline' &&
          chooseCountry != '') {
        print("find");
        print(selectCty);
        // print(selectedDate);
        // print(FromDate);

        var res = await http.get(Uri.parse(
            'https://newsapi.org/v2/top-headlines?country=$selectCty&category=$chooseValue&apiKey=1866ed19591c4d99880992a3ca614497'));
        var jsonData = jsonDecode(res.body);

        print(jsonData['articles'].length);

        for (var i in jsonData['articles']) {
          UserModel2 today_new = UserModel2(
              i['author'],
              i['title'],
              i['description'],
              i['url'],
              i['urlToImage'],
              i['publishedAt'],
              i['content']);
          news.add(today_new);
          // print(i['urlToImage']);
        }
      }

      // var res = await http.get(Uri.parse(
      //     'https://newsapi.org/v2/top-headlines?country=$selectCty&category=sports&apiKey=1866ed19591c4d99880992a3ca614497'));
      // var jsonData = jsonDecode(res.body);

      // print(jsonData['articles'].length);

      // for (var i in jsonData['articles']) {
      //   UserModel2 today_new = UserModel2(
      //       i['author'],
      //       i['title'],
      //       i['description'],
      //       i['url'],
      //       i['urlToImage'],
      //       i['publishedAt'],
      //       i['content']);
      //   news.add(today_new);
      //   // print(i['urlToImage']);
      // }

      print(news);
    }
    return news;
  }

  @override
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
                Text(
                  "Search News",
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.bold,
                      color: Colors.pink),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 50.0, top: 5, bottom: 5, right: 10),
                  child: Row(
                    children: [
                      Text(
                        "Select Categories : ",
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Arial',
                        ),
                      ),
                      Center(
                          child: RaisedButton(
                        child: pressCat ? Text('yes') : Text("No"),
                        textColor: Colors.white,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        color: pressCat ? Colors.blue : Colors.grey,
                        onPressed: () => setState(
                            () => {pressCat = !pressCat, chooseValue = ""}),
                      )),
                    ],
                  ),
                ),
                pressCat
                    ? Container(
                        width: 200,
                        child: DropdownButton(
                          hint: chooseValue == null
                              ? Text('Dropdown')
                              : Text(
                                  chooseValue,
                                  style: TextStyle(color: Colors.blue),
                                ),
                          isExpanded: true,
                          iconSize: 30.0,
                          style: TextStyle(color: Colors.blue),
                          items: Cat.map(
                            (val) {
                              return DropdownMenuItem<String>(
                                value: val,
                                child: Text(val),
                              );
                            },
                          ).toList(),
                          onChanged: (val) {
                            setState(
                              () {
                                chooseValue = val;
                              },
                            );
                          },
                        ),
                      )
                    : Text(""),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 50.0, top: 5, bottom: 5, right: 10),
                  child: Row(
                    children: [
                      Text(
                        "Select Country : ",
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Arial',
                        ),
                      ),
                      Center(
                          child: RaisedButton(
                        child: pressCountry ? Text('yes') : Text("No"),
                        textColor: Colors.white,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        color: pressCountry ? Colors.blue : Colors.grey,
                        onPressed: () => setState(() =>
                            {pressCountry = !pressCountry, chooseCountry = ''}),
                      )),
                    ],
                  ),
                ),
                pressCountry
                    ? Container(
                        width: 200,
                        child: DropdownButton(
                          hint: chooseValue == null
                              ? Text('Dropdown')
                              : Text(
                                  chooseCountry,
                                  style: TextStyle(color: Colors.blue),
                                ),
                          isExpanded: true,
                          iconSize: 30.0,
                          style: TextStyle(color: Colors.blue),
                          items: country_name.map(
                            (val) {
                              return DropdownMenuItem<String>(
                                value: val,
                                child: Text(val),
                              );
                            },
                          ).toList(),
                          onChanged: (val) {
                            setState(
                              () {
                                chooseCountry = val;
                              },
                            );
                          },
                        ),
                      )
                    : Text(""),
                chooseValue == '' || chooseValue == 'Headline'
                    ? Text("")
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),

                          // Text("${selectedDate.toLocal()}".split(' ')[0]),
                          // Text("${FromDate.toLocal()}".split(' ')[0]),

                          SizedBox(
                            height: 20.0,
                          ),
                        ],
                      ),
                ElevatedButton(
                  child: Text("Show Data"),
                  onPressed: selectapi,
                ),
                selectData
                    ? FutureBuilder(
                        future: getuser(),
                        builder: (context, snapshot) {
                          print(snapshot.data);
                          if (snapshot.data == null) {
                            return Center(
                              child: Column(
                                children: [
                                  Text(
                                    "loading  News.....",
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
                                Container(
                                    child: chooseValue == 'Headline'
                                        ? Text(
                                            chooseCountry == ''
                                                ? "OverAll Head Line"
                                                : chooseCountry != ''
                                                    ? "Head Line Of " +
                                                        chooseCountry
                                                    : '',
                                            style: TextStyle(
                                                fontSize: 25,
                                                fontFamily: 'Arial',
                                                fontWeight: FontWeight.bold,
                                                color: Colors.pink[300]),
                                          )
                                        : chooseValue == 'business' &&
                                                chooseCountry != ''
                                            ? Text(
                                                "Bussiness News Of " +
                                                    chooseCountry,
                                                style: TextStyle(
                                                    fontSize: 25,
                                                    fontFamily: 'Arial',
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.pink[300]),
                                              )
                                            : chooseValue == 'Top News' &&
                                                    chooseCountry != ''
                                                ? Text(
                                                    "Top News Of " +
                                                        chooseCountry,
                                                    style: TextStyle(
                                                        fontSize: 25,
                                                        fontFamily: 'Arial',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            Colors.pink[300]),
                                                  )
                                                : chooseValue == 'sports' &&
                                                        chooseCountry != ''
                                                    ? Text(
                                                        "Sports News Of " +
                                                            chooseCountry,
                                                        style: TextStyle(
                                                            fontSize: 25,
                                                            fontFamily: 'Arial',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors
                                                                .pink[300]),
                                                      )
                                                    : Text("")),
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
                                                        value =
                                                            snapshot.data[i],
                                                              _user = userUid
                                                            )),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(.0),
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
                                                          BorderRadius.circular(
                                                              5),
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
                                                              Text(
                                                                  snapshot
                                                                      .data[i]
                                                                      .title,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold)),
                                                              Text(
                                                                  "Published At :" +
                                                                      snapshot
                                                                          .data[
                                                                              i]
                                                                          .publishedAt,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .pink)),
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
                      )
                    : Text("")
              ],
            ),
          ),
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
