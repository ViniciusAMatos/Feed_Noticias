import 'dart:convert';

import 'package:feed_noticias/pages/view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:link/link.dart';

import '../model/user_model.dart';
import 'category_news_view.dart';

/*
 * Author: Ciro Dourado de Oliveira
 */

/*
 * async é usado para configurar o Refresh da página
 */

class HeadlinesNewsView extends StatefulWidget {
  @override
  _HeadlinesNewsViewState createState() => _HeadlinesNewsViewState();
}

class _HeadlinesNewsViewState extends State<HeadlinesNewsView> {
  @override
  void initState() {
    super.initState();
    _getData().then((value) => {}); //Iniciar a API.
  }

  Future<Map> _getData() async {
    http.Response response;
    response = await http.get(
        'http://newsapi.org/v2/top-headlines?country=br&apiKey=33e4cbb785c647cdb1f7724704be4d86');
    return json.decode(response.body);
  }

  UserModel model = UserModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notícias",
          style: Theme.of(context).textTheme.headline5,
        ), // title
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              model.signOut();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
              );
            },
          ), // IconButton
        ], // actions
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
                    builder: (context) => CategoryNewView(
                      getCategory: 'business',
                      geTitle: 'Negócios',
                    ),
                  ),
                );
              },
              title: Text('Negócios'),
              trailing: Icon(Icons.arrow_forward),
              leading: Icon(Icons.assessment),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CategoryNewView(
                      getCategory: 'Sports',
                      geTitle: 'Esportes',
                    ),
                  ),
                );
              },
              title: Text('Esportes'),
              trailing: Icon(Icons.arrow_forward),
              leading: Icon(Icons.accessibility_new),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CategoryNewView(
                      getCategory: 'health',
                      geTitle: 'Saúde',
                    ),
                  ),
                );
              },
              title: Text('Saúde'),
              trailing: Icon(Icons.arrow_forward),
              leading: Icon(Icons.add_to_queue),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CategoryNewView(
                      getCategory: 'science',
                      geTitle: 'Ciência',
                    ),
                  ),
                );
              },
              title: Text('Ciência'),
              trailing: Icon(Icons.arrow_forward),
              leading: Icon(Icons.account_balance),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CategoryNewView(
                      getCategory: 'technology',
                      geTitle: 'Tecnologia',
                    ),
                  ),
                );
              },
              title: Text('Tecnologia'),
              trailing: Icon(Icons.arrow_forward),
              leading: Icon(Icons.cloud_upload),
            ),
          ],
        ), // child ListView
      ), // Drawer
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: Padding(
          padding: EdgeInsets.zero,
          child: FutureBuilder(
            future: _getData(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                case ConnectionState.none:
                  return Center();
                default:
                  if (snapshot.hasError) {
                    return Container();
                  } else {
                    return myScreen(context, snapshot);
                  }
              } // switch
            }, // builder (context, snapshot)
          ), // FutureBuilder
        ), // Padding
      ), // RefreshIndicator
    ); // Scaffold
  } // override build

  Future<Null> _handleRefresh() async {
    await _getData();
  }

  Widget myScreen(context, snapshot) {
    return StaggeredGridView.countBuilder(
      itemCount: snapshot.data["articles"].length,
      staggeredTileBuilder: (index) => StaggeredTile.extent(1, 200),
      mainAxisSpacing: 0.0,
      crossAxisSpacing: 0.0,
      crossAxisCount: 1,
      itemBuilder: (BuildContext context, int index) => Link(
        url: snapshot.data["articles"][index]["url"],
        child: Padding(
          padding: const EdgeInsets.all(4.5),
          child: Card(
            child: Container(
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    Colors.deepOrange.shade900,
                    Colors.deepOrange.shade100,
                  ], // colors
                ), // LinearGradient
              ), // BoxDecoration
              child: Stack(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(
                      _verification(snapshot, index),
                      fit: BoxFit.fitWidth,
                    ), // Image child
                  ), // Container
                  Column(
                    children: <Widget>[
                      Flexible(
                        child: Center(
                          child: Stack(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  snapshot.data['articles'][index]['title'],
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 4,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    letterSpacing: 0.5,
                                    wordSpacing: 0.5,
                                    fontFamily: 'Roboto',
                                    fontSize: 20,
                                    foreground: Paint()
                                      ..style = PaintingStyle.stroke
                                      ..strokeWidth = 6
                                      ..color = Colors.black,
                                  ), // TextStyle
                                ),
                              ), // Text
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  snapshot.data['articles'][index]['title'],
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 4,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    letterSpacing: 0.5,
                                    wordSpacing: 0.5,
                                    fontFamily: 'Roboto',
                                    fontSize: 20,
                                    color: Colors.white,
                                  ), // TextStyle
                                ),
                              ), // Text
                            ],
                          ), // Stack
                        ), // Center
                      ), // Flexible
                    ], // Column children
                  ), // Column
                ], // Stack children
              ), // Stack
            ), // Container child
          ),
        ), // Card
      ), // Link
    ); // return
  } // myScreen

  _verification(snapshot, index) {
    if (snapshot.data['articles'][index]['urlToImage'] != null)
      return snapshot.data['articles'][index]['urlToImage'];
    else
      return 'https://www.lumitecfoto.com.br/media/catalog/product/cache/1/image/800x/9df78eab33525d08d6e5fb8d27136e95/f/u/fundo-fotogr_fico-em-tecido-muslin-20x30m-preto-3.jpg';
  }
} // _MyHomePageState
