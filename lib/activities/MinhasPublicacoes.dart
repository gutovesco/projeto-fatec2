import 'package:app_teste/model/Publicacao.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class MinhasPublicacoes extends StatefulWidget {
  @override
  _MinhasPublicacoesState createState() => _MinhasPublicacoesState();
}

class _MinhasPublicacoesState extends State<MinhasPublicacoes> {

  Future<List<Publicacao>> buscarDados() async {
    FirebaseAuth fireAuth = FirebaseAuth.instance;
    FirebaseUser fireUser = await fireAuth.currentUser();
    FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
    DatabaseReference dataRef = firebaseDatabase.reference();
    
    List<Publicacao> listaTurma = List();

    var dados = dataRef.child("usuarios").child(fireUser.uid).child("minhasPublicacoes");

    await dados.once().then((DataSnapshot snapshot){
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key,values) {
        Publicacao publicacao = Publicacao();
        publicacao.titulo = values["titulo"];
        publicacao.descricao = values["descricao"];
        publicacao.data = values["data"];
        publicacao.hora = values["hora"];
        publicacao.urlImagem = values["urlImagem"];
        publicacao.ads = values["ads"];
        publicacao.projetos = values["projetos"];
        publicacao.mecatronica = values["mecatronica"];
        publicacao.semRestricoes = values["semRestricoes"];
        listaTurma.add(publicacao);
      });
    });
    return listaTurma;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Publicações"),
      ),
      body: FutureBuilder<List<Publicacao>>(
        future: buscarDados(),
        builder: (context, snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
            print("executei");
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Carregando..."),
                    CircularProgressIndicator()
                  ],
                ),
              );
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
            print(snapshot.data);
              if(snapshot.data == null){
                return Center(
                  child: Text("Não foi possível recuperar os dados!"),
                );
              }else{
                return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (_, indice){
                  List<Publicacao> listPublicacao = snapshot.data;
                  
                  Publicacao publicacao = listPublicacao[indice];

                  return ListTile(
                    title: Text(publicacao.titulo),
                  );
                },
              );
              }
              break;
          }
        },
      ),
    );
  }
}