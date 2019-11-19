import 'package:app_teste/model/Usuario.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Perfil extends StatefulWidget {

  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  FirebaseAuth fireAuth = FirebaseAuth.instance;
  List list = [];

  carregarLista(){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Perfil"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () async {
                await fireAuth.signOut();
                Navigator.pushNamedAndRemoveUntil(context, "/", (_) => false);
              })
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment:  MainAxisAlignment.center,
          children: <Widget>[
            Container(
                height: 120,
                width: 120,
                child: CircleAvatar(
                  backgroundImage: ExactAssetImage("imagens/fundo.png"),
                )
            ),
            Text("Clique na foto para adicionar/alterar"),

            /*ListView.builder(
              itemCount: 5,
              itemBuilder: (context, indice){

              },
            ),*/

          ],
        ),
      ),
    );
  }
}
