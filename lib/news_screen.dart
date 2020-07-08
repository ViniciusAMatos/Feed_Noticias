import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Newscreen extends StatefulWidget {
  final String search; //Variavel para ser usada na procura no Json.

  Newscreen({this.search}); // construtor da variavel.

  @override
  _NewscreenState createState() => _NewscreenState();
}

class _NewscreenState extends State<Newscreen> {
  String get search => widget.search;

  @override
  void initState(){
    super.initState();
    _getData().then((value) => {});//Iniciar a API.
  }

  Future<Map> _getData() async {
    // Funcao criada para pegarmos os dados da API.
    http.Response response;
    response = await http.get(
        'http://newsapi.org/v2/everything?language=pt&q=$search&apiKey=33e4cbb785c647cdb1f7724704be4d86');
    return json
        .decode(response.body); // Retornando os dados para a variavel response. 
  }


  Widget _tela(context, snapshot) {
    return ListView.builder(
        itemCount:
            snapshot.data['articles'].length, //Pegar o tamanho da aba artigos.
        itemBuilder: (context, index) {
          return GestureDetector(
            child: Container(
              height: 100.0,
              width: 400.0,
              child: Row(
                children: <Widget>[
                  Container(child: Image.network(snapshot.data['articles'][index]['urlToImage']), width: 100.0,), //Pegar imagem da noticia da API.
                  Container( width: 200.0,
                    child: Column(
                      children: <Widget>[
                        Text(snapshot.data['articles'][index]['title'], overflow: TextOverflow.fade,),// Pegar o titulo da notica da API.

                        //Text(snapshot.data['articles'][index]['description'], overflow: TextOverflow.fade)// Pegar a descrição da noticia.
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(search),centerTitle: true ,), 
      body: Container(
        child: FutureBuilder(future: _getData(),builder: (context, snapshot) {switch(snapshot.connectionState){
            case ConnectionState.waiting:
            case ConnectionState.none: return Container(
                      width: 200.0,
                      height: 200.0,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 5.0,
                      ),
                    );
            default: if (snapshot.hasError) {
              return Container();
            }else{
              return _tela(context,snapshot);
            }
          }}),
      )
    );
  }
}
