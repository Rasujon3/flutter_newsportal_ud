import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:flutter_slidable/flutter_slidable.dart';

class PoliticsNews_Gallery extends StatefulWidget {
  @override
  _PoliticsNews_GalleryState createState() => _PoliticsNews_GalleryState();
}

class _PoliticsNews_GalleryState extends State<PoliticsNews_Gallery> {
  Future getAllimage() async {
    var firestore = Firestore.instance;

    QuerySnapshot snap =
    await firestore.collection("InternationalAllNews").getDocuments();
    return snap.documents;
  } // get data from server, table name internationalnews

  Future<Null> onRefresh() async {
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      getAllimage();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF222240),
      body: FutureBuilder(
        future: getAllimage(),
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
                      child: Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.all(6.0),
                            height: 300.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Color(0xFF272b4a),
                            ),
                            child: Container(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: Image.network(
                                  snapshot.data[index].data["image"],
                                  height: 299.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 40.0,
                            left: 30.0,
                            child: Container(
                              height: 50.0,
                              width: 200.0,
                              decoration: BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20.0),
                                  topRight: Radius.circular(20.0),
                                ),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Political News",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
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
