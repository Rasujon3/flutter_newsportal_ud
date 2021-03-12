import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Int_PostDetails extends StatefulWidget {

  DocumentSnapshot snapshot;

  Int_PostDetails(this.snapshot);

  @override
  _Int_PostDetailsState createState() => _Int_PostDetailsState();
}

class _Int_PostDetailsState extends State<Int_PostDetails> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("International News"),
        backgroundColor: Color(0xFF222240),
      ),
      backgroundColor: Color(0xFF222240),
      body: new ListView(
        children: [
          // 1st container
          new Container(
            margin: EdgeInsets.all(6.0),
            height: MediaQuery.of(context).size.height - 400,
            //height: 250.0,
            width: MediaQuery.of(context).size.width,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: new Image.network(
                widget.snapshot.data["image"],
                //height: 250.0,
                height: MediaQuery.of(context).size.height - 400,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // 1st container end
          SizedBox(
            height: 6.0,
          ),
          new Container(
            color: Color(0xFF272B4A),
            margin: EdgeInsets.all(10.0),
            height: MediaQuery.of(context).size.height,
            child: new Column(
              children: [
                new Container(
                  margin: EdgeInsets.all(10.0),
                  child: new Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      new CircleAvatar(
                        child: new Text(
                          widget.snapshot.data["title"][0],
                          style: TextStyle(
                            fontSize: 21.0,
                          ),
                        ),
                        backgroundColor: Colors.deepOrange,
                      ),
                      new SizedBox(
                        width: 10.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 100,
                        child: new Text(
                          widget.snapshot.data["title"],
                          style: TextStyle(
                            fontSize: 19.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                new SizedBox(
                  height: 10.0,
                ),
                Container(
                  margin: EdgeInsets.only(left: 17.0,bottom: 10.0),
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
                        widget.snapshot.data["views"]+
                            " Views",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 5.0,
                ),
                new Text(
                  widget.snapshot.data["content"],
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
