import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:new_app/Components/Home/Show_Detail_News.dart';

class SportNews extends StatefulWidget {
  var userUid;
 
  SportNews(this.userUid);
  @override
  _SportNewsState createState() => _SportNewsState(userUid);
}

class _SportNewsState extends State<SportNews> {

  var userUid;
   _SportNewsState(this.userUid);

   String _user;

  var news = [];
  bool data = true;

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

  var value;
  String chooseValue = '';
  String selectCty;

  Future<List<dynamic>> getuser() async {
    if (chooseValue == '') {
      print("no");
      return null;
    } else {
      print(country_name.length);
      print(country_code.length);
      for (var i = 0; i < country_name.length; i++) {
        if (country_name[i] == chooseValue) {
          setState(() {
            selectCty = country_code[i];
          });
          print(selectCty);
        }
      }

      setState(() {
        news = [];
        data = false;
      });

      var res = await http.get(Uri.parse(
          'https://newsapi.org/v2/top-headlines?country=$selectCty&category=sports&apiKey=1866ed19591c4d99880992a3ca614497'));
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

      print(news);
    }
    return news;
  }

  @override
  void initState() {
    super.initState();
    print(chooseValue);
  }

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            child: SingleChildScrollView(
              child: Column(children: [
                Padding(padding: EdgeInsets.all(20)),
                Text(
                  "Sports News",
                  style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'Arial',
                       color: Colors.pink[400],
                      fontWeight: FontWeight.bold),
                ),
                Padding(padding: EdgeInsets.all(10)),
                //  Text(
                //   "Select Country :",
                //   style: TextStyle(
                //       fontSize: 20,
                //       fontFamily: 'Arial',
                //      ),
                // ),
                Container(
                    padding: const EdgeInsets.all(0.0),
                    child: Row(
                      children: [
                         Text(
                  "Select Country : ",
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Arial',
                     ),
                ),
                        Container(
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
                                  chooseValue = val;
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    )),
                FutureBuilder(
                  future: getuser(),
                  builder: (context, snapshot) {
                    print(snapshot.data);
                    if (snapshot.data == null) {
                      return data 
                          ? Center(
                              child: Column(children: [
                              Text(
                                "",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Arial',
                                ),
                              ),
                            ]))
                          : Center(
                              child: Column(
                                children: [
                                  Text(
                                    "loading Sport News.....",
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
                          Container(child:
                           Text(
                                    "Sport News Of "+chooseValue,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Arial',
                                       color: Colors.green,
                                    ),
                           )
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
                                      GestureDetector(
                                        onTap: () => Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (_) => Alldata(
                                                  value = snapshot.data[i],
                                                  _user = userUid
                                                  )),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
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
                                                    BorderRadius.circular(5),
                                                // ),
                                              ),
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                color: Colors.white,
                                                elevation: 20,
                                                child:Row(
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
                                                                      .title),
                                                              Text(
                                                                "Published At :" +
                                                                    snapshot
                                                                        .data[i]
                                                                        .publishedAt,
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
              ]),
            ),
          ),
        ],
      ),
    );
  }
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
