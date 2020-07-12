import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:link/link.dart';


class Newscreen extends StatefulWidget {
//Criando variáveis e construtores para pegarmos o título da tela e também a categoria selecionada.
   final String geTitle;
   final String getCategory;

   Newscreen({this.geTitle, this.getCategory});

  @override
  _NewscreenState createState() => _NewscreenState();
}

class _NewscreenState extends State<Newscreen> {

  @override
  void initState() {
    super.initState();
    _getData().then((value) => {}); //Iniciar a API.
  }

  Future<Map> _getData() async {
    // Funcao criada para pegarmos os dados da API.
    http.Response response;
    response = await http.get(
        'http://newsapi.org/v2/top-headlines?country=br&category=${widget.getCategory}&apiKey=33e4cbb785c647cdb1f7724704be4d86');
    return json
        .decode(response.body); // Retornando os dados para a variavel response.
  }

  Widget _tela(context, snapshot) {
    return ListView.builder(
        itemCount:
            snapshot.data['articles'].length, //Pegar o tamanho da aba artigos.
        itemBuilder: (context, index) {
          return Link(
              url: snapshot.data['articles'][index]['url'],
              onError: _showErrorSnackBar,//Era pra funcionar, mas...
              child: Card(
            child: Container(
              height: 100.0,
              width: 400.0,
              child: Row(
                children: <Widget>[
                  Container(
                    child: Image.network(_verification(snapshot, index),
                        fit: BoxFit.cover),
                    width: MediaQuery.of(context).size.width * 0.42,
                  ), //Pegar imagem da noticia da API.
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    width: 200.0,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            top: 5,
                          ),
                          child: Text(
                            snapshot.data['articles'][index]['title'],
                            overflow: TextOverflow.ellipsis,
                            maxLines: 5,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              letterSpacing: 0.5,
                              wordSpacing: 0.5,
                            ),
                          ), // Pegar o titulo da notica da API.
                          //Text(snapshot.data['articles'][index]['description'], overflow: TextOverflow.fade)// Pegar a descrição da noticia.
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ));
        });
  }

  _verification(snapshot, index) {
    if (snapshot.data['articles'][index]['urlToImage'] != null)
      return snapshot.data['articles'][index]['urlToImage'];
    else
      return 'https://www.lumitecfoto.com.br/media/catalog/product/cache/1/image/800x/9df78eab33525d08d6e5fb8d27136e95/f/u/fundo-fotogr_fico-em-tecido-muslin-20x30m-preto-3.jpg';
  }

void _showErrorSnackBar() {//Funcao erro modelo da doc do Flutter, caso nao consiga carregar a URL.
    Scaffold.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text('Ocorreu um erro ao abrir a URL!!'),
      ),
    );
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.geTitle),
          centerTitle: true,
          // backgroundColor: Colors.black,
        ),
        body: Container(
          // color: Colors.black,
          child: FutureBuilder(
              future: _getData(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return Container(
                      width: 200.0,
                      height: 200.0,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 5.0,
                      ),
                    );
                  default:
                    if (snapshot.hasError) {
                      return Container();
                    } else {
                      return _tela(context, snapshot);
                    }
                }
              }),
        ));
  }
}
