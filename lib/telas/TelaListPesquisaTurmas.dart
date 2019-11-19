import 'package:app_teste/help/PesquisarTurmas.dart';
import 'package:app_teste/model/Turma.dart';
import 'package:app_teste/model/Usuario.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ListPesquisaTurmas extends StatefulWidget {

  String curso;
  String modulo;
  String periodo;

  ListPesquisaTurmas(this.curso, this.modulo, this.periodo){
    if(modulo == null || modulo == ""){
      this.modulo = "";
    }
  }

  @override
  _ListPesquisaTurmasState createState() => _ListPesquisaTurmasState();
}

class _ListPesquisaTurmasState extends State<ListPesquisaTurmas> {

  Future<List<Turma>> buscarDados() async {
    FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
    DatabaseReference dataRef = firebaseDatabase.reference();
    
    List<Turma> listaTurma = List();

    var dados = dataRef.child("turmas").child(widget.curso).child(widget.periodo).child(widget.modulo);

    await dados.once().then((DataSnapshot snapshot){
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key,values) {
        Turma turma = Turma();
        turma.nomeTurma = values["nomeTurma"];
        turma.periodo = values["periodo"];
        turma.curso = values["curso"];
        turma.modulo = values["modulo"];

        Usuario usuario = Usuario();
        usuario.nome = values["usuario"]["nome"];
        usuario.email = values["usuario"]["email"];

        turma.usuario = usuario;
        listaTurma.add(turma);
      });
    });
    return listaTurma;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Turmas"),
        actions: <Widget>[
          /*IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          showSearch(
            context: context,
            delegate: PesquisarTurmas()
          );
        },
      )*/
        ],
      ),
      body: FutureBuilder<List<Turma>>(
        future: buscarDados(),
        builder: (context, snapshot){
          switch(snapshot.connectionState){
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
              if(snapshot.data == null){
                return Center(
                  child: Text("Nenhuma turma registrada!"),
                );
              }else{
                return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (_, indice){

                  List<Turma> listTurma = snapshot.data;
                  
                  Turma turma = listTurma[indice];

                  return Column(
                    children: <Widget>[
                      ListTile(
                    title: Text(turma.nomeTurma),
                    subtitle: Text("Professor: ${turma.usuario.nome} | Curso: ${turma.curso} | Perído: ${turma.periodo} | Módulo: ${turma.modulo}"),
                    ),
                    Divider()
                    ],
                  );
                },
              );
              }
              break;
          }
        },
      )
        
      ,
      
    );
  }
}