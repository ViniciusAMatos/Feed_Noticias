/*
 * Author: Ciro Dourado de Oliveira
 */

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'dart:async';
/*
 * async é usado para configurar o Refresh da página
 */

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
    @override Widget build(BuildContext context) {
        return MaterialApp(
            title: 'News',
            theme: ThemeData(
                brightness: Brightness.dark,
                primarySwatch: Colors.deepOrange,
                primaryColor: Colors.deepOrange,
                accentColor: Colors.deepOrange,
                visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: MyHomePage(title: 'Home'),
        );
    }
}

class MyHomePage extends StatefulWidget {
    MyHomePage({Key key, this.title}) : super(key: key);
    final String title;
    @override _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
    @override Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text(
                    widget.title,
                    style: Theme.of(context).textTheme.headline5,
                ),
            ), // AppBar
            drawer: Drawer(
                child: ListView(
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                        DrawerHeader(
                            decoration: BoxDecoration(
                                color: Colors.deepOrange,
                            ),
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
    @override _MyGridTilesState createState() => _MyGridTilesState();
}

class _MyGridTilesState extends State<MyGridTiles> {
    @override Widget build(BuildContext context) {
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
