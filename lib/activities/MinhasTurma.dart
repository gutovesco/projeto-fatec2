import 'package:app_teste/model/Turma.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class MinhasTurmas extends StatefulWidget {
  @override
  _MinhasTurmasState createState() => _MinhasTurmasState();
}

class _MinhasTurmasState extends State<MinhasTurmas> {

  Future<List<Turma>> buscarDados() async {
    FirebaseAuth fireAuth = FirebaseAuth.instance;
    FirebaseUser fireUser = await fireAuth.currentUser();
    FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
    DatabaseReference dataRef = firebaseDatabase.reference();
    
    List<Turma> listaTurma = List();

    var dados = dataRef.child("usuarios").child(fireUser.uid).child("turmas");

    await dados.once().then((DataSnapshot snapshot){
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key,values) {
        Turma turma = Turma();
        turma.nomeTurma = values["nomeTurma"];
        turma.periodo = values["periodo"];
        turma.curso = values["curso"];
        turma.modulo = values["modulo"];
        listaTurma.add(turma);
      });
    });
    return listaTurma;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Minhas turma"),
      ),
      body: FutureBuilder<List<Turma>>(
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
                  List<Turma> listTurma = snapshot.data;
                  
                  Turma turma = listTurma[indice];

                  return ListTile(
                    title: Text(turma.nomeTurma),
                    subtitle: Text("Curso: ${turma.curso} | Perído: ${turma.periodo} | Módulo: ${turma.modulo}"),
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