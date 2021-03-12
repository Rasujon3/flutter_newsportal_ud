import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_newsportal_ud/View/SportsNews/Sports_DetailsPage.dart';
import 'dart:async';
import 'package:flutter_slidable/flutter_slidable.dart';

class SportsNews extends StatefulWidget {
  @override
  _SportsNewsState createState() => _SportsNewsState();
}

class _SportsNewsState extends State<SportsNews> {

  Future getallpost() async {
    var firestore = Firestore.instance;

    QuerySnapshot snap =
    await firestore.collection("InternationalAllNews").getDocuments();
    return snap.documents;
  } // get data from server, table name internationalnews

  Future<Null> onRefresh() async {
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      getallpost();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF222240),
      body: FutureBuilder(
        future: getallpost(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Text(
                "Data Loading..",
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
            );
          } else {
            return RefreshIndicator(
              onRefresh: onRefresh,
              backgroundColor: Colors.green,
              color: Colors.white,
              child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Slidable(
                      key: ValueKey(index),
                      actionPane: SlidableDrawerActionPane(),
                      actions: [
                        IconSlideAction(
                          caption: 'Archive',
                          color: Colors.blueGrey,
                          icon: Icons.archive,
                        ),
                        //SizedBox(width: 0.2,),
                        IconSlideAction(
                          caption: 'Share',
                          color: Colors.blue,
                          icon: Icons.share,
                        ),
                      ],
                      secondaryActions: [
                        IconSlideAction(
                          caption: 'Delete',
                          color: Colors.blueGrey,
                          icon: Icons.delete,
                        ),
                      ],
                      dismissal: SlidableDismissal(
                        child: SlidableDrawerDismissal(),
                      ),
                      child: Container(
                        margin: EdgeInsets.all(6.0),
                        height: 170.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Color(0xFF272b4a),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: Image.network(
                                  snapshot.data[index].data["image"],
                                  height: 169.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                children: [
                                  // 1st container title, content
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data[index].data["title"],
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 6.0,
                                        ),
                                        Text(
                                          snapshot.data[index].data["content"],
                                          maxLines: 3,
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // 1st container title, content end
                                  SizedBox(
                                    height: 30.0,
                                  ),
                                  // 2nd container start
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        // 1st container icon,text start
                                        Container(
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.remove_red_eye,
                                                color: Colors.deepOrange,
                                              ),
                                              SizedBox(
                                                width: 5.0,
                                              ),
                                              Text(
                                                snapshot.data[index]
                                                    .data["views"] +
                                                    " Views",
                                                style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.blueGrey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // 1st container icon,text end

                                        // 2nd container view details start
                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                new MaterialPageRoute(
                                                    builder: (context) =>
                                                        SportsNewsDetails(snapshot.data[index])));
                                          },
                                          child: Container(
                                            margin:
                                            EdgeInsets.only(right: 10.0),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(15.0),
                                              color: Colors.blueGrey,
                                            ),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "View Details",
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        // 2nd container view details end
                                      ],
                                    ),
                                  ),
                                  // 2nd container end
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            );
          }
        },
      ),
    );
  }
}
