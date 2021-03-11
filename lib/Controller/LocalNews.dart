import 'package:flutter/material.dart';
import 'package:flutter_newsportal_ud/View/LocalNews/LocalAllNews.dart' as allnews;
import 'package:flutter_newsportal_ud/View/LocalNews/LocalNewsGallery.dart' as gallery;

class LocalNews extends StatefulWidget {
  @override
  _LocalNewsState createState() => _LocalNewsState();
}

class _LocalNewsState extends State<LocalNews>with SingleTickerProviderStateMixin {

  TabController controller;

  @override
  void initState() {
    // TODO: implement initState
    controller= new TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Local News"),
        backgroundColor: Color(0xFF272b4a),

        bottom: TabBar(
          controller: controller,
          indicatorColor: Colors.blueGrey,
          indicatorWeight: 5.0,
          tabs: [
            new Tab(icon: Icon(Icons.view_headline,),text: "Local News",),
            new Tab(icon: Icon(Icons.image,),text: "Gallery",),


          ],
        ),
      ),

      body: TabBarView(
        controller: controller,
        children: [
          allnews.LocalNews(),
          gallery.LocalNews_Gallery(),
        ],
      ),

    );
  }
}
