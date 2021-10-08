import 'package:flutter/material.dart';

class newScreen extends StatefulWidget {
  var value;
  newScreen(this.value);

  @override
  _newScreenState createState() => _newScreenState(value);
}

class _newScreenState extends State<newScreen> {
  var value;
  _newScreenState(this.value);

  String select_country;

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

  @override
  void initState() {
    super.initState();
    print(value.title);
    print(value.country);

    if (value.country == 'ar') {
      select_country = country_name[0];
    } else if (value.country == 'au') {
      select_country = country_name[1];
    } else if (value.country == 'at') {
      select_country = country_name[2];
    } else if (value.country == 'be') {
      select_country = country_name[3];
    } else if (value.country == 'br') {
      select_country = country_name[4];
    } else if (value.country == 'bg') {
      select_country = country_name[5];
    } else if (value.country == 'ca') {
      select_country = country_name[6];
    } else if (value.country == 'cn') {
      select_country = country_name[7];
    } else if (value.country == 'co') {
      select_country = country_name[8];
    } else if (value.country == 'cu') {
      select_country = country_name[8];
    } else if (value.country == 'cz') {
      select_country = country_name[9];
    } else if (value.country == 'eg') {
      select_country = country_name[10];
    } else if (value.country == 'fr') {
      select_country = country_name[11];
    } else if (value.country == 'de') {
      select_country = country_name[12];
    } else if (value.country == 'gr') {
      select_country = country_name[13];
    } else if (value.country == 'hk') {
      select_country = country_name[14];
    } else if (value.country == 'hu') {
      select_country = country_name[15];
    } else if (value.country == 'in') {
      select_country = country_name[16];
    } else if (value.country == 'id') {
      select_country = country_name[17];
    } else if (value.country == 'ie') {
      select_country = country_name[18];
    } else if (value.country == 'il') {
      select_country = country_name[19];
    } else if (value.country == 'it') {
      select_country = country_name[20];
    } else if (value.country == 'jp') {
      select_country = country_name[21];
    } else if (value.country == 'lv') {
      select_country = country_name[22];
    } else if (value.country == 'lt') {
      select_country = country_name[23];
    } else if (value.country == 'my') {
      select_country = country_name[24];
    } else if (value.country == 'mx') {
      select_country = country_name[25];
    } else if (value.country == 'ma') {
      select_country = country_name[26];
    } else if (value.country == 'nl') {
      select_country = country_name[27];
    } else if (value.country == 'nz') {
      select_country = country_name[28];
    } else if (value.country == 'ng') {
      select_country = country_name[29];
    } else if (value.country == 'no') {
      select_country = country_name[30];
    } else if (value.country == 'ph') {
      select_country = country_name[31];
    } else if (value.country == 'pl') {
      select_country = country_name[32];
    } else if (value.country == 'pt') {
      select_country = country_name[33];
    } else if (value.country == 'ro') {
      select_country = country_name[34];
    } else if (value.country == 'ru') {
      select_country = country_name[35];
    } else if (value.country == 'sa') {
      select_country = country_name[36];
    } else if (value.country == 'rs') {
      select_country = country_name[37];
    } else if (value.country == 'sg') {
      select_country = country_name[38];
    } else if (value.country == 'sk') {
      select_country = country_name[39];
    } else if (value.country == 'za') {
      select_country = country_name[40];
    } else if (value.country == 'kr') {
      select_country = country_name[41];
    } else if (value.country == 'ch') {
      select_country = country_name[42];
    } else if (value.country == 'tw') {
      select_country = country_name[43];
    } else if (value.country == 'th') {
      select_country = country_name[44];
    } else if (value.country == 'tr') {
      select_country = country_name[45];
    } else if (value.country == 'ae') {
      select_country = country_name[46];
    } else if (value.country == 'ua') {
      select_country = country_name[47];
    } else if (value.country == 'gb') {
      select_country = country_name[48];
    } else if (value.country == 'us') {
      select_country = country_name[49];
    } else if (value.country == 've') {
      select_country = country_name[50];
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("new"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                color: Colors.white,
                elevation: 20,
                child: Column(
                  children: [
                    value.image == null || value.image == ''
                        ? Image.asset('assets/no.jpg')
                        : Image.network(value.image,
                            width: 400, height: 200, fit: BoxFit.fill),

                    // child: Row(
                    //   verticalDirection: VerticalDirection.down,
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Text( "Title : " ,style: TextStyle(color: Colors.pink),

                    //     ),
                    //      value.title == null || value.title == ''
                    //      ? Text('No Title')
                    //   : Column(
                    //    children :[ Text( value.title,style: TextStyle(color: Colors.black,fontSize: 25),),
                    //    ])
                    //   ],
                    // ),
                    SizedBox(height: 10,),
                    Row(children: [
                      Text("Title : ",
                          style: TextStyle(color: Colors.pink, fontSize: 25)),
                    ]),
                    value.title == null || value.title == ''
                        ? Text('No Title')
                        : Container(
                            child: Text(value.title,
                                style:
                                    TextStyle(color: Colors.black, fontSize: 18)),
                          ),
                    SizedBox(
                      height: 13,
                    ),
                    Row(children: [
                      Text("Description : ",
                          style: TextStyle(color: Colors.pink, fontSize: 25)),
                    ]),
                    value.description == null || value.description == ''
                        ? Text('No Description')
                        : Container(
                            child: Text(value.description,
                                style:
                                    TextStyle(color: Colors.black, fontSize: 18)),
                          ),

                    SizedBox(
                      height: 13,
                    ),
                    Row(children: [
                      Text("publishedAt : ",
                          style: TextStyle(color: Colors.pink, fontSize: 25)),
                    ]),
                    value.publishedAt == null || value.publishedAt == ''
                        ? Row(children: [
                            Text("Not Show Date : ",
                                style:
                                    TextStyle(color: Colors.pink, fontSize: 25)),
                          ])
                        : Row(children: [
                            Text(value.publishedAt,
                                style:
                                    TextStyle(color: Colors.black, fontSize: 18)),
                          ]),

                    SizedBox(
                      height: 13,
                    ),
                    Row(children: [
                      Text("Country: ",
                          style: TextStyle(color: Colors.pink, fontSize: 25)),
                    ]),

                    Row(
                      children: [
                        Text(select_country,
                            style: TextStyle(color: Colors.black, fontSize: 18)),
                      ],
                    ),

                    SizedBox(
                      height: 13,
                    ),
                    Row(children: [
                      Text("Source: ",
                          style: TextStyle(color: Colors.pink, fontSize: 25)),
                    ]),
                    value.source == null || value.source == ''
                        ? Row(children: [
                            Text("No Sources : ",
                                style:
                                    TextStyle(color: Colors.pink, fontSize: 25)),
                          ])
                        : Row(children: [
                            Text(value.source,
                                style:
                                    TextStyle(color: Colors.black, fontSize: 18)),
                          ]),
                    SizedBox(
                      height: 13,
                    ),
                    Row(children: [
                      Text("Url : ",
                          style: TextStyle(color: Colors.pink, fontSize: 25)),
                    ]),
                    value.url == null || value.url == ''
                        ? Row(children: [
                            Text("No Url : ",
                                style:
                                    TextStyle(color: Colors.pink, fontSize: 25)),
                          ])
                        : Container(
                            child:  Text(value.url,
                                style:
                                    TextStyle(color: Colors.black, fontSize: 18)),
                          ),
                    Divider()
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
