import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'DetailsLatestPost.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  StreamSubscription<QuerySnapshot>
      subscription; //query our data & get the data from cloud firestore
  List<DocumentSnapshot>snapshot; // all the data store in a list
  CollectionReference collectionReference = Firestore.instance
      .collection("LatestPost"); // ei database table theke sob data asbe

  @override
  void initState() {
    subscription = collectionReference.snapshots().listen((datasnap) {
      setState(() {
        snapshot = datasnap.documents; // snapshot hold all data
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News Portal"),
        backgroundColor: Color(0xFF222240),
      ),
      drawer: new Drawer(
        child: Container(
          color: Color(0xFF272B4A),
          child: new ListView(
            children: [
              new UserAccountsDrawerHeader(
                accountName: new Text("News Portal App"),
                accountEmail: null,
                decoration: new BoxDecoration(
                  color: Color(0xFF222240),
                ),
              ),
              new ListTile(
                title: Text(
                  "International News",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  //Navigator.of(context).push(internationalNews.dart);
                },
                leading: new Icon(
                  Icons.next_week,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
              new ListTile(
                title: Text(
                  "Sports News",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  //Navigator.of(context).push(internationalNews.dart);
                },
                leading: new Icon(
                  Icons.sports,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
              new ListTile(
                title: Text(
                  "Local News",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  //Navigator.of(context).push(internationalNews.dart);
                },
                leading: new Icon(
                  Icons.local_bar_rounded,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
              new ListTile(
                title: Text(
                  "Political News",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  //Navigator.of(context).push(internationalNews.dart);
                },
                leading: new Icon(
                  Icons.adb,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Color(0xFF222240),
      body: ListView(
        children: [
          // 1st container start
          new Container(
            height: 230.0,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Text("Latest Post",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                  ),
                ),
                new SizedBox(height: 5.0,),
                new Container(
                  height: 140.0,
                  margin: EdgeInsets.only(top: 8.0),

                  child: new ListView.builder(
                    scrollDirection: Axis.horizontal,
                      itemCount: snapshot.length,
                      itemBuilder: (context,index){
                        return Container(
                          color: Color(0xFF272B4A),
                          width: MediaQuery.of(context).size.width - 100,
                          margin: EdgeInsets.only(left: 10.0),
                          //height: 150.0,
                          child: new Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              new Expanded(
                                  flex: 1,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15.0),
                                    child: new Image.network(snapshot[index].data["image"],
                                    fit: BoxFit.cover,
                                      height: 140,
                                    ),
                                  ),
                              ),
                              new SizedBox(width: 10.0,),
                              new Expanded(
                                  flex: 2,
                                  child: new Column(
                                    //mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: (){
                                          Navigator.of(context).push(new MaterialPageRoute(builder: (context) => LatestPostDetails(snapshot[index])));
                              },
                                        child: new Text(snapshot[index].data["title"],
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontSize: 22.0,
                                          color: Colors.white,
                                        ),
                                        ),
                                      ),
                                      new SizedBox(height: 5.0,),
                                      new Text(snapshot[index].data["content"],
                                      maxLines: 3,
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.white,
                                      ),),
                                      new SizedBox(height: 10.0,),
                                      new Container(
                                        child: new Row(
                                          children: [
                                            new Icon(Icons.remove_red_eye,
                                              color: Colors.deepOrange,
                                            ),
                                            new SizedBox(width: 5.0,),
                                            new Text("View",
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
          // 1st container end

        ],
      ),

    );
  }
}