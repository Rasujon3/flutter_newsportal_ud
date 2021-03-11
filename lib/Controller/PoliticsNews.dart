import 'package:flutter/material.dart';
import 'package:flutter_newsportal_ud/View/PoliticsNews/PoliticsAllNews.dart' as allnews;
import 'package:flutter_newsportal_ud/View/PoliticsNews/Politics_Gallery.dart' as gallery;

class PoliticsNews extends StatefulWidget {
  @override
  _PoliticsNewsState createState() => _PoliticsNewsState();
}

class _PoliticsNewsState extends State<PoliticsNews>with SingleTickerProviderStateMixin {

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
        title: Text("Politics News"),
        backgroundColor: Color(0xFF272b4a),

        bottom: TabBar(
          controller: controller,
          indicatorColor: Colors.blueGrey,
          indicatorWeight: 5.0,
          tabs: [
            new Tab(icon: Icon(Icons.view_headline,),text: "Politics News",),
            new Tab(icon: Icon(Icons.image,),text: "Gallery",),


          ],
        ),
      ),

      body: TabBarView(
        controller: controller,
        children: [
          allnews.PoliticsNews(),
          gallery.PoliticsNews_Gallery(),
        ],
      ),

    );
  }
}
