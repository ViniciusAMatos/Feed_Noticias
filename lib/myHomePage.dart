import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'dart:async';

import 'login/model/user_model.dart';
import 'news_screen.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  UserModel model = UserModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Noticias',
          style: Theme.of(context).textTheme.headline5,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              model.signOut();
              Navigator.of(context).pop();
            },
          )
        ],
      ), // AppBar
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: null,
              decoration: BoxDecoration(
                color: Colors.deepOrange,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Newscreen(
                      getCategory: 'business',
                      geTitle: 'Negócios',
                    ),
                  ),
                );
              },
              title: Text('Negócios'),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Newscreen(
                      getCategory: 'entertainment',
                      geTitle: 'Entretenimento',
                    ),
                  ),
                );
              },
              title: Text('Entretenimento'),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Newscreen(
                      getCategory: 'Sports',
                      geTitle: 'Esportes',
                    ),
                  ),
                );
              },
              title: Text('Esportes'),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Newscreen(
                      getCategory: 'health',
                      geTitle: 'Saúde',
                    ),
                  ),
                );
              },
              title: Text('Saúde'),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Newscreen(
                      getCategory: 'science',
                      geTitle: 'Ciência',
                    ),
                  ),
                );
              },
              title: Text('Ciência'),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Newscreen(
                      getCategory: 'sports',
                      geTitle: 'Esportes',
                    ),
                  ),
                );
              },
              title: Text('Esportes'),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Newscreen(
                      getCategory: 'technology',
                      geTitle: 'Tecnologia',
                    ),
                  ),
                );
              },
              title: Text('Tecnologia'),
            ),
          ],
        ), // child ListView
      ), // Drawer
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: Padding(
          padding: EdgeInsets.zero,
          child: StaggeredGridView.count(
            physics: AlwaysScrollableScrollPhysics(),
            crossAxisCount: 4,
            staggeredTiles: _staggeredTiles,
            children: _tiles,
            mainAxisSpacing: 0,
            crossAxisSpacing: 0,
            padding: EdgeInsets.all(8.0),
          ), // child StaggeredGridView
        ), // Padding
      ), // RefreshIndicator
    ); // Scaffold
  } // override build

  Future<Null> _handleRefresh() async {
    await new Future.delayed(new Duration(seconds: 3));
    return null;
  }
} // _MyHomePageState

class MyGridTiles extends StatefulWidget {
  MyGridTiles(this.backgroundColor, this.iconData);
  final Color backgroundColor;
  final IconData iconData;
  @override
  _MyGridTilesState createState() => _MyGridTilesState();
}

class _MyGridTilesState extends State<MyGridTiles> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.backgroundColor,
      child: InkWell(
        onTap: () {},
        child: Center(
          child: Icon(
            widget.iconData,
            color: Colors.white,
          ), // Icon
        ), // Center
      ), // InkWell
    ); // Card
  } // build
} // _MyGridTilesState

List<StaggeredTile> _staggeredTiles = <StaggeredTile>[
  StaggeredTile.count(4, 2),
  StaggeredTile.count(4, 2),
  StaggeredTile.count(4, 2),
  StaggeredTile.count(4, 2),
  StaggeredTile.count(4, 2),
  StaggeredTile.count(4, 2),
  StaggeredTile.count(4, 2),
  StaggeredTile.count(4, 2),
  StaggeredTile.count(4, 2),
]; // list of tiles

List<Widget> _tiles = <Widget>[
  MyGridTiles(Colors.deepOrangeAccent, Icons.file_upload),
  MyGridTiles(Colors.deepOrangeAccent, Icons.file_upload),
  MyGridTiles(Colors.deepOrangeAccent, Icons.file_upload),
  MyGridTiles(Colors.deepOrangeAccent, Icons.file_upload),
  MyGridTiles(Colors.deepOrangeAccent, Icons.file_upload),
  MyGridTiles(Colors.deepOrangeAccent, Icons.file_upload),
  MyGridTiles(Colors.deepOrangeAccent, Icons.file_upload),
  MyGridTiles(Colors.deepOrangeAccent, Icons.file_upload),
  MyGridTiles(Colors.deepOrangeAccent, Icons.file_upload),
]; // list of tiles constructors
