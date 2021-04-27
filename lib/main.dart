import 'dart:convert';
import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

Map<String, dynamic> mp = {"message": ""};
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  getData() async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('http://3.7.71.29:6001/get_user_details'));
    request.body = '''{\n    "mobile":"1234567890"\n}''';
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var res = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      if (mp["message"] == "") {
        setState(() {
          mp.addAll(json.decode(res.body));
        });
      }
      print(mp["user_data"]["Email"]);

      print("Data Fetched");
    } else {
      print(response.reasonPhrase);
    }

    print(mp.length);
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
        appBar: AppBar(
            title: Text(
              'Profile',
            ),
            backgroundColor: Colors.blue,
            centerTitle: true),
        backgroundColor: Colors.black,
        body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(15),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.blue,
                    width: 2,
                  )),
              child: Stack(
                children: <Widget>[
                  Container(
                    //CoverPic

                    padding: EdgeInsets.all(85),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.blueGrey,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(mp["message"] == "Success"
                                ? mp["user_data"]["FirmImage"]
                                : 'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg'))),
                  ),
                  Positioned(
                    //CircleAvatar
                    top: 140,
                    left: 130,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 45,
                        backgroundColor: Colors.blue,
                        backgroundImage: NetworkImage(mp["message"] == "Success"
                            ? mp["user_data"]["ProfileImage"]
                            : 'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 285, left: 45),
                    child: ListTile(
                      leading: Icon(
                        Icons.person,
                        color: Colors.blue,
                      ),
                      title: Text(
                        //Name
                        mp["message"] == "Success"
                            ? mp["user_data"]["Name"]
                            : "Kaushik",
                        style: GoogleFonts.mcLaren(color: Colors.white),
                      ),
                      trailing: Icon(
                        Icons.edit,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Container(
                    //Mobile
                    padding: EdgeInsets.only(top: 325, left: 45),
                    child: ListTile(
                      leading: Icon(
                        Icons.phone,
                        color: Colors.blue,
                      ),
                      title: Text(
                        mp["message"] == "Success"
                            ? mp["user_data"]["Mobile"]
                            : "9876543210",
                        style: GoogleFonts.mcLaren(color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    //Firmname
                    padding: EdgeInsets.only(top: 365, left: 45),
                    child: ListTile(
                      leading: Icon(
                        Icons.home_work_outlined,
                        color: Colors.blue,
                      ),
                      title: Text(
                        (mp["message"] == "Success")
                            ? mp["user_data"]["FirmName"]
                            : "Google",
                        style: GoogleFonts.mcLaren(color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    //Zone
                    padding: EdgeInsets.only(top: 405, left: 45),
                    child: ListTile(
                      leading: Icon(
                        Icons.location_on_sharp,
                        color: Colors.blue,
                      ),
                      title: Text(
                        mp["message"] == "Success"
                            ? mp["user_data"]["Zone"]
                            : "Kolkata",
                        style: GoogleFonts.mcLaren(color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    //Email
                    padding: EdgeInsets.only(top: 445, left: 45),
                    child: ListTile(
                      leading: Icon(
                        Icons.email,
                        color: Colors.blue,
                      ),
                      title: Text(
                        mp["message"] == "Success"
                            ? mp["user_data"]["Email"]
                            : "kg@gmail.com",
                        style: GoogleFonts.mcLaren(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
