import 'package:app_teste/model/Publicacao.dart';
import 'package:app_teste/model/Usuario.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class Publicar extends StatefulWidget {
  static var titulo = TextEditingController();
  static var descricao = TextEditingController();
  static var caminhoImagem = "";
  static var data = TextEditingController();
  static var hora = TextEditingController();

  static var ads = false;
  static var projetos = false;
  static var mecatronica = false;
  static var semRestricoes = false;

  static Usuario usuario;

  Publicar({Usuario user}){
    usuario = user;
  }

  @override
  _PublicarState createState() => _PublicarState();
}

class _PublicarState extends State<Publicar> {
  int _indiceFragment = 0;
  int _fragmentselecionado = 0;

  List<Widget> _listFragments = [EditarPublicacao(), VisuliazarPublicacao()];

  void verificarPublicacao() {
    bool verificar = verificarCampos();

    if (verificar == true) {
      _neverSatisfied();
    }
  }

  Future<void> _neverSatisfied() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Observação"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    "Ao publicar não será mais possível remover, somente editar!")
              ],
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
              child: Text("Publicar"),
              onPressed: () {
                iniciarProcessoCadastro();
              },
            )
          ],
        );
      },
    );
  }

  bool verificarCampos() {
    if (Publicar.titulo.text.isNotEmpty) {
      if (Publicar.ads == false &&
          Publicar.projetos == false &&
          Publicar.mecatronica == false &&
          Publicar.semRestricoes == false) {
        Toast.show("O campo público dessa publicação está vazio!", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        return false;
      }
    } else {
      Toast.show("Campo título é obrigatório!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _fragmentselecionado,
        onTap: (indice) {
          if (indice == 0) {
            setState(() {
              _fragmentselecionado = indice;
              _indiceFragment = indice;
            });
          } else if (indice == 1) {
            setState(() {
              _fragmentselecionado = indice;
              _indiceFragment = indice;
            });
          } else {
            verificarPublicacao();
          }
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.edit), title: Text("Editar")),
          BottomNavigationBarItem(
              icon: Icon(Icons.visibility), title: Text("Visualizar")),
          BottomNavigationBarItem(
              icon: Icon(Icons.done), title: Text("Publicar"))
        ],
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Publicar"),
      ),
      body: SingleChildScrollView(
        child: _listFragments[_indiceFragment],
      ),
    );
  }

  void iniciarProcessoCadastro() {
    Publicacao publicacao = Publicacao();
    publicacao.titulo = Publicar.titulo.text;
    publicacao.descricao = Publicar.descricao.text;
    publicacao.data = Publicar.data.text;
    publicacao.hora = Publicar.hora.text;
    publicacao.ads = Publicar.ads;
    publicacao.projetos = Publicar.projetos;
    publicacao.mecatronica = Publicar.mecatronica;
    publicacao.semRestricoes = Publicar.semRestricoes;
    publicacao.usuario = Publicar.usuario;
    publicacao.salvarFirebase();
    
  }
}

class EditarPublicacao extends StatefulWidget {
  @override
  _EditarPublicacaoState createState() => _EditarPublicacaoState();
}

class _EditarPublicacaoState extends State<EditarPublicacao> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.only(
          top: 10,
          left: 30,
          right: 30,
        ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
Row(
children: <Widget>[
              Text("Campos com * são obrigatórios.",
              style: TextStyle(
                color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 7,
                            fontFamily: "Open Sans",
              ),),
            ]),   

          TextField(
            controller: Publicar.titulo,
            decoration: InputDecoration(
                hintText: "Ex: Palestra no auditório sobre ChatBot",
                labelText: "Título*", 
                          labelStyle: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w400,
                          fontSize: 17,
                          fontFamily: "Open Sans",
                          ),),
                    ),
          TextField(
            controller: Publicar.descricao,
            decoration: InputDecoration(
                hintText: "Ex: ", labelText: "Descrição da publicação*", 
                          labelStyle: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w400,
                          fontSize: 17,
                          fontFamily: "Open Sans",
                          ),),
                    ),
          TextField(
            controller: Publicar.data,
            decoration: InputDecoration(
             hintText: "Dia/Mês/Ano", labelText: "Data do evento", 
                          labelStyle: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w400,
                          fontSize: 17,
                          fontFamily: "Open Sans",
                          ),),
                    ),
          TextField(
            controller: Publicar.hora,
            decoration:
                InputDecoration(hintText: "Ex: 19:30", labelText: "Horário", 
                          labelStyle: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w400,
                          fontSize: 17,
                          fontFamily: "Open Sans",
                          ),),
                    ),
          SizedBox(height: 20),
                    
          Text("Quem vai receber essa publicação?",
            style: TextStyle(
              color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          fontFamily: "Open Sans",
            ),),     
            
            SizedBox(height: 10),

          CheckboxListTile(
            title: Text("Ads",
            style: TextStyle(
              color: Colors.black87,
                          fontWeight: FontWeight.w400,
                          fontSize: 17,
                          fontFamily: "Open Sans",
            ),),
            value: Publicar.ads,
            onChanged: (bool resultado) {
              setState(() {
                Publicar.ads = resultado;
              });
            },
          ),
          CheckboxListTile(
            title: Text("Projetos",
            style: TextStyle(
              color: Colors.black87,
                          fontWeight: FontWeight.w400,
                          fontSize: 17,
                          fontFamily: "Open Sans",
            ),),
            value: Publicar.projetos,
            onChanged: (bool resultado) {
              setState(() {
                Publicar.projetos = resultado;
              });
            },
          ),
          CheckboxListTile(
            title: Text("Mecatrônica",
            style: TextStyle(
              color: Colors.black87,
                          fontWeight: FontWeight.w400,
                          fontSize: 17,
                          fontFamily: "Open Sans",
            ),),
            value: Publicar.mecatronica,
            onChanged: (bool resultado) {
              setState(() {
                Publicar.mecatronica = resultado;
              });
            },
          ),
          CheckboxListTile(
            title: Text("Sem restrições",
            style: TextStyle(
              color: Colors.black87,
                          fontWeight: FontWeight.w400,
                          fontSize: 17,
                          fontFamily: "Open Sans",
            ),),
            subtitle: Text("Todos podem visualizar",
            style: TextStyle(
              color: Colors.black87,
                          fontWeight: FontWeight.w400,
                          fontSize: 17,
                          fontFamily: "Open Sans",
            ),),
            value: Publicar.semRestricoes,
            onChanged: (bool resultado) {
              semRestricoes(resultado);
            },
          )
        ],
      ),
    ));
  }

  void semRestricoes(bool resultado) {
    setState(() {
      Publicar.ads = resultado;
      Publicar.projetos = resultado;
      Publicar.mecatronica = resultado;
      Publicar.semRestricoes = resultado;
    });
  }
}

class VisuliazarPublicacao extends StatefulWidget {
  @override
  _VisuliazarPublicacaoState createState() => _VisuliazarPublicacaoState();
}

class _VisuliazarPublicacaoState extends State<VisuliazarPublicacao> {
  var visualizar_Titulo = "";
  var visualizar_Descricao = "";
  var visualizar_CaminhoImagem = "";
  var visualizar_Data = "";
  var visualizar_Hora = "";
  String conData = "";
  String conHora = "";

  void verificarCamposVisualizacao() {
    if (Publicar.titulo.text.isNotEmpty) {
      setState(() {
        visualizar_Titulo = Publicar.titulo.text;
      });
    }

    if (Publicar.descricao.text.isNotEmpty) {
      setState(() {
        visualizar_Descricao = Publicar.descricao.text;
      });
    }

    if (Publicar.data.text.isNotEmpty) {
      setState(() {
        visualizar_Data = Publicar.data.text;
        conData = "Data: ";
      });
    }

    if (Publicar.hora.text.isNotEmpty) {
      setState(() {
        visualizar_Hora = Publicar.hora.text;
        conHora = " às ";
      });
    }
  }

  Widget imagemVisualizar() {
    if (Publicar.caminhoImagem != null && Publicar.caminhoImagem.isNotEmpty) {
      return Image.asset("imagens/fundo.png", width: 345);
    } else {
      return Container();
    }
  }

  @override
  void initState() {
    super.initState();

    verificarCamposVisualizacao();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 3,
        child: Container(
          padding: EdgeInsets.all(3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SafeArea(
                child: Text(visualizar_Titulo),
              ),
              Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: ExactAssetImage("imagens/fundo.png"),
                  ),
                  Column(
                    children: <Widget>[Text(Publicar.usuario.nome)],
                  )
                ],
              ),
              Divider(),
              SafeArea(
                child: Text(visualizar_Descricao),
              ),
              imagemVisualizar(),
              Divider(),
              Row(
                children: <Widget>[
                  Text(conData),
                  Text(visualizar_Data),
                  Text(conHora),
                  Text(visualizar_Hora)
                ],
              )
            ],
          ),
        ));
  }
}
