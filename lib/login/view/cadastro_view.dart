import 'package:feed_noticias/login/model/user_model.dart';

import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();

  final _emailController = TextEditingController();

  final _passController = TextEditingController();
  final _confirmpassController = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Cadastrar"),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ScopedModelDescendant<UserModel>(builder: (context, child, model) {
        if (model.isloading)
          return Center(
            child:
                CircularProgressIndicator(), // se tiver carregando o login ele retorna um widget circula para indicar que ta carregando
          );
        return Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(hintText: "Nome Completo"),
                validator: (text) {
                  if (text.isEmpty) return "Nome Inválido!";
                },
              ),
              SizedBox(
                height: 32.0,
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(hintText: "E-mail"),
                keyboardType: TextInputType.emailAddress,
                validator: (text) {
                  if (text.isEmpty || !text.contains("@"))
                    return "E-mail Inválido!"; //validação simples para email
                },
              ),
              SizedBox(
                height: 16.0,
              ),
              TextFormField(
                controller: _passController,
                decoration: InputDecoration(hintText: "Senha"),
                obscureText: true,
                validator: (text) {
                  if (text.isEmpty || text.length < 6)
                    return "Senha inválida!"; // validação simples para senha
                },
              ),
              SizedBox(
                height: 16.0,
              ),
              TextFormField(
                controller: _confirmpassController,
                decoration: InputDecoration(hintText: "Confirmar Senha"),
                obscureText: true,
                // ignore: missing_return
                validator: (text) {
                  if (text.isEmpty || text != _passController.text)
                    return "Senhas Diferentes!"; // compara as senhas
                },
              ),
              SizedBox(
                height: 16.0,
              ),
              SizedBox(
                height: 50.0,
                child: RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      Map<String, dynamic> userData = {
                        //if valida se os campos estão com informações
                        "name": _nameController
                            .text, //e salva no userdata para enviar pro bd posteriormente
                        "email": _emailController.text,
                      };
                      model.signUp(
                        // manda pra funçao no user_model as informações necessarias para salvar no bd
                        userData: userData,
                        pass: _passController.text,
                        onSuccess: _onSuccess,
                        onFail: _onFail,
                      );
                    }
                  },
                  child: Text(
                    "Criar Conta",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  textColor: Colors.white,
                  color: Theme.of(context).primaryColor,
                ),
              )
            ],
          ),
        );
      }),
    );
  }

  void _onSuccess() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text("Usúario criado com sucesso!"),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.of(context).pop();
    });
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text("Falha ao criar usuário!"),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 2),
      ),
    );
  }
}
