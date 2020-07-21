import 'package:feed_noticias/pages/model/user_model.dart';
import 'package:feed_noticias/pages/view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
        model: UserModel(),
        child: MaterialApp(
          title: 'News',
          theme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.deepOrange,
            primaryColor: Colors.deepOrange,
            accentColor: Colors.deepOrange,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          debugShowCheckedModeBanner: false,
          home: LoginScreen(),
        ));
  }
}
