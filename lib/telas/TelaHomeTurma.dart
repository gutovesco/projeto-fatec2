import 'package:app_teste/model/Publicacao.dart';
import 'package:app_teste/model/Turma.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class TelaHomeTurma extends StatefulWidget {
  Turma turma;

  TelaHomeTurma(this.turma);

  @override
  _TelaHomeTurmaState createState() => _TelaHomeTurmaState();
}

class _TelaHomeTurmaState extends State<TelaHomeTurma> {
  FirebaseAuth fireAuth = FirebaseAuth.instance;
  Future<bool> tipoUserAdmn;

  Future<List<Publicacao>> recuperarDados() async {
    FirebaseUser user = await fireAuth.currentUser();
    if (user != null) {
      FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
      DatabaseReference dataRef = firebaseDatabase.reference();

      List<Publicacao> listaPublicacoes = List();

      var dados = dataRef.child("turmas").child(widget.turma.curso).child(widget.turma.periodo).child(widget.turma.modulo);

      return listaPublicacoes;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Turma"),
        actions: <Widget>[
          FutureBuilder<FirebaseUser>(
            future: configurarIconTipoUsuario(),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                if (snapshot.data.email == widget.turma.usuario.email) {
                  print("É igual");
                  myBottomBar();
                  return Container();
                } else {
                  return IconButton(
                    onPressed: () {
                      _neverSatisfied();
                    },
                    icon: Icon(Icons.exit_to_app),
                  );
                }
              } else {
                return Container();
              }
            },
          )
        ],
      ),
      body: FutureBuilder<List<Publicacao>>(
        future: recuperarDados(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Carregando"),
                    CircularProgressIndicator()
                  ],
                ),
              );
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if (snapshot.data.length == 0) {
                return Center(
                  child: Text("Sem publicação!"),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, indice) {
                    List<Publicacao> listPublicacao = snapshot.data;

                    Publicacao publicacao = listPublicacao[indice];

                    return Column(
                      children: <Widget>[
                        Card(
                            elevation: 3,
                            child: Container(
                              padding: EdgeInsets.all(3),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SafeArea(
                                    child: Text("titulo"),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      CircleAvatar(
                                        backgroundImage: ExactAssetImage(
                                            "imagens/fundo.png"),
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Text("Nome: professor")
                                        ],
                                      )
                                    ],
                                  ),
                                  Divider(),
                                  SafeArea(
                                    child: Text("Descricao"),
                                  )
                                ],
                              ),
                            ))
                      ],
                    );
                  },
                );
              }
              break;
          }
        },
      ),
      bottomNavigationBar: myBottomBar(),
          );
        }
      
        Future<void> _neverSatisfied() async {
          return showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Alerta!"),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[Text("Deseja sair dessa turma?")],
                  ),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Cancelar"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton(
                    child: Text("Confirmar"),
                    onPressed: () {},
                  )
                ],
              );
            },
          );
        }
      
        Future<FirebaseUser> configurarIconTipoUsuario() async {
          return fireAuth.currentUser();
        }
      
        FutureBuilder<dynamic> myBottomBar() {
          if(configurarIconTipoUsuario != null){
            return FutureBuilder<dynamic>(
              future: configurarIconTipoUsuario(),
              builder: (context, snapshot){
                print("bottom foi");
                if (snapshot.data.email == widget.turma.usuario.email) {
                  return BottomNavigationBar(
                    items: [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        title: Text("Home")
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.send),
                        title: Text("Publicar")
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.settings),
                        title: Text("Configurações")
                      ),
                    ],
                  );
                }else{
                  return Visibility(
                    visible: false,
                    child: BottomNavigationBar(
                    items: [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.explicit),
                        title: Text("test1")
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.explicit),
                        title: Text("test1")
                      )
                    ],
                  )
                  );
                }
              },
            );
          }else{
            print("bottom == null");
            return null;
          }
        }
}
