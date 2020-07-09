import 'package:feed_noticias/news_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: Newscreen(getCategory: 'Sports',geTitle: 'Esportes',),//Passando o parametro da tela, que sera o search.
    );
  }
}
