import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'login/model/user_model.dart';
import 'login/view/login_view.dart';

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
